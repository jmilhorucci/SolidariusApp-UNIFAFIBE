import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:solidarius_app/model/usuario_api.dart';
import 'package:solidarius_app/home/pontos_de_coleta/models/locais_list_data.dart';
import 'package:solidarius_app/home/pontos_de_coleta/screens/pontos_de_coletas/locais_maps_view.dart';
import 'package:solidarius_app/service/base.service.dart';
import 'package:solidarius_app/widgets/local_detalhes.dart';
import 'package:solidarius_app/widgets/maps_widget.dart';

final UsuarioApi usuarioApi = GetIt.I<UsuarioApi>();

class NewLocaisController {
  MapsWidgetController? _mapsController;
  StreamSubscription<Position>? streamPosition;
  BitmapDescriptor? mapMarkerUser;
  BitmapDescriptor? mapMarkerOthers;
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  bool get listeningCurrentPosition => streamPosition != null;
  Position? currentPosition;
  List<LocaisListData> data = [];
  List<LocaisListData> dataMarkers = [];
  var pageController = PageController(viewportFraction: 0.8);
  var currentIndexCard = -1;
  Timer? loopCheckInitLocaleService;
  String? erroMessage;

  Future<void> init(Function() setState) async {
    markers = {};
    circles = {};
    await initListenerCurrentLocation();
    if (await _checkPermissions()) {
      await _initCustomMarkerUser();
      await _initCustomMarkerOthers();
      if (await _checkLocaleServiceService()) {
        currentPosition = await _getCurrentPosition();
      }
      await stopListenerCurrentLocation(() {});
      if (currentPosition != null) {
        await _updateMakerAndCirclePositionUser(currentPosition!);
        await _loadCard(setState);
      } else {
        _loopCheckLocaleService(setState);
      }
    }
  }

  Future<void> _loadCard(Function() setState) async {
    await updateDataList(
        usuarioApi, currentPosition!.latitude, currentPosition!.longitude);
    if (data.length > 0) {
      currentIndexCard = 0;
    }
    await _updateMarkersOthers(dataMarkers, () => () {});
    pageController.addListener(() {
      currentIndexCard = pageController.page!.toInt();
      var item = data[pageController.page!.toInt()];
      _moveCamera(item.latitude, item.longitude, setState);
    });
  }

  Future<void> updateDataList(
      UsuarioApi usuarioApi, double latitude, double longitude) async {
    var listaInstituicoes = await obterInstituicoesProximasPorLatitudeLongitude(
        usuarioApi, latitude, longitude, 999999, 999999);

    var lstTodasInstituicoes = listaInstituicoes;

    data = [];
    dataMarkers = [];
    for (var instituicao in listaInstituicoes.take(5)) {
      data.add(LocaisListData(
        foto: instituicao.urlImagem ??
            "http://iseb3.com.br/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png",
        nome: instituicao.nome!,
        cnpj: instituicao.cnpj!,
        email: instituicao.email!,
        telefone: instituicao.telefone1!,
        funcionamento: instituicao.descDisponibilidade!,
        sobreLocal: instituicao.descSobre!,
        fimBeneficente: instituicao.descFinsBeneficentes!,
        apoiadores: instituicao.descApoiadores!,
        observacoes: instituicao.descObservacoes!,
        endereco:
            '${instituicao.logradouro!}, ${instituicao.numero!}${instituicao.complemento! == "" ? "" : ' - ' + instituicao.complemento!} - ${instituicao.bairro!}, ${instituicao.cidade!}-${instituicao.estado!}, ${instituicao.cep!}',
        cep: '${instituicao.cep!}',
        cidade: '${instituicao.cidade!} - ${instituicao.estado!}',
        itens: instituicao.descArrecadacoesAceitas!.split(','),
        latitude: instituicao.latitude!,
        longitude: instituicao.longitude!,
        urlFacebook: instituicao.urlFacebook ?? "",
        urlInstagram: instituicao.urlInstagram ?? "",
        chavePix: instituicao.chavePix ?? "",
        startColor: '#7C2AE8',
        endColor: '#4EC1C1',
      ));
    }

    for (var instituicao in lstTodasInstituicoes) {
      dataMarkers.add(LocaisListData(
        foto: instituicao.urlImagem ??
            "http://iseb3.com.br/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png",
        nome: instituicao.nome!,
        cnpj: instituicao.cnpj!,
        email: instituicao.email!,
        telefone: instituicao.telefone1!,
        funcionamento: instituicao.descDisponibilidade!,
        sobreLocal: instituicao.descSobre!,
        fimBeneficente: instituicao.descFinsBeneficentes!,
        apoiadores: instituicao.descApoiadores!,
        observacoes: instituicao.descObservacoes!,
        endereco:
            '${instituicao.logradouro!}, ${instituicao.numero!}${instituicao.complemento! == "" ? "" : ' - ' + instituicao.complemento!} - ${instituicao.bairro!}, ${instituicao.cidade!}-${instituicao.estado!}, ${instituicao.cep!}',
        cep: '${instituicao.cep!}',
        cidade: '${instituicao.cidade!} - ${instituicao.estado!}',
        itens: instituicao.descArrecadacoesAceitas!.split(','),
        latitude: instituicao.latitude!,
        longitude: instituicao.longitude!,
        urlFacebook: instituicao.urlFacebook ?? "",
        urlInstagram: instituicao.urlInstagram ?? "",
        chavePix: instituicao.chavePix ?? "",
        startColor: '#7C2AE8',
        endColor: '#4EC1C1',
      ));
    }
  }

  void _loopCheckLocaleService(Function() setState) {
    Future.microtask(() {
      loopCheckInitLocaleService?.cancel();
      loopCheckInitLocaleService =
          Timer.periodic(Duration(seconds: 3), (timer) async {
        if (await _checkLocaleServiceService()) {
          await initListenerCurrentLocation();
          currentPosition = await _getCurrentPosition();
          await stopListenerCurrentLocation(() {});
          await _updateMakerAndCirclePositionUser(currentPosition!);
          await _loadCard(setState);
          erroMessage = null;
          setState();
          loopCheckInitLocaleService?.cancel();
        }
      });
    });
  }

  Future<bool> _checkLocaleServiceService() async {
    var enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      erroMessage =
          "Por favor, habilite a localização no smartphone para ter acesso ao mapa";
    }
    return enabled;
  }

  Future<bool> _checkPermissions() async {
    var permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        erroMessage = "Você precisa autorizar o acesso à localização";
        return false;
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      erroMessage = "Você precisa autorizar o acesso à localização";
      return false;
    }
    return true;
  }

  Future<Position> _getCurrentPosition() async {
    return Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<void> _initCustomMarkerUser() async {
    mapMarkerUser = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'assets/pontos_de_coleta/user-location.png');
  }

  Future<void> _initCustomMarkerOthers() async {
    mapMarkerOthers = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/pontos_de_coleta/location.png',
    );
  }

  initListenerCurrentLocation() async {
    streamPosition = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 0,
      ),
    ).listen(_updateMakerAndCirclePositionUser);
  }

  stopListenerCurrentLocation(Function() setState) {
    _stopListenerCurrentLocation();
    if (data.length > 0) {
      _moveCamera(data[currentIndexCard].latitude,
          data[currentIndexCard].longitude, () => setState());
    }
  }

  Future<void> _stopListenerCurrentLocation(
      {bool disposeMapController = false}) async {
    await streamPosition?.cancel();
    streamPosition = null;
    if (disposeMapController) {
      _mapsController?.dispose();
    }
  }

  _updateMakerAndCirclePositionUser(Position position) {
    if (_mapsController == null) return;
    var marker = Marker(
        markerId: const MarkerId('user-markerId'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'Minha Localização'),
        icon: mapMarkerUser!);

    var circle = Circle(
      fillColor: AppTheme.nearlyOcean.withAlpha(50),
      strokeColor: AppTheme.nearlyOcean,
      strokeWidth: 2,
      circleId: CircleId('user-circleId'),
      center: LatLng(position.latitude, position.longitude),
      radius: 300,
    );
    markers.add(marker);
    circles.add(circle);

    _mapsController?.updateCameraPosition(MapsWidgetCameraPosition(
        target: LatLng(position.latitude, position.longitude)));
    _mapsController?.setState(markers, circles);
  }

  _updateMarkersOthers(List<LocaisListData> list, Function() onTap) {
    for (var i = 0; i < list.length; i++) {
      var item = list[i];
      markers.add(
        Marker(
          markerId: MarkerId(item.nome),
          position: LatLng(item.latitude, item.longitude),
          icon: mapMarkerOthers!,
          onTap: () => {
            item,
            showCupertinoModalBottomSheet(
              expand: true,
              context: appKey.currentState!.context,
              builder: (context) => LocalDetalhes(local: item),
              // shape: RoundedRectangleBorder(
              //     borderRadius:
              //         BorderRadius.vertical(top: Radius.circular(20))),
            )
          },
        ),
      );
    }
  }

  onMapCreated(MapsWidgetController ctrl) {
    _mapsController = ctrl;
    _updateMakerAndCirclePositionUser(currentPosition!);
  }

  Future<void> dispose() async {
    pageController.dispose();
    await _stopListenerCurrentLocation(disposeMapController: true);
  }

  _moveCamera(double latitude, double longitude, Function() setState) {
    if (listeningCurrentPosition) {
      _stopListenerCurrentLocation();
      setState();
    }
    _mapsController?.updateCameraPosition(MapsWidgetCameraPosition(
        target: LatLng(latitude, longitude), zoom: 15));
  }

  String get mapStyle => '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "landscape",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#89e1ff"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
    ''';
}
