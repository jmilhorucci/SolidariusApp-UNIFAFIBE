import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidgetCameraPosition {
  final LatLng target;
  final double? bearing;
  final double? tilt;
  final double? zoom;
  MapsWidgetCameraPosition(
      {required this.target, this.bearing, this.tilt, this.zoom});

  factory MapsWidgetCameraPosition._fromCameraPosition(CameraPosition cam) {
    return MapsWidgetCameraPosition(
        target: cam.target,
        bearing: cam.bearing,
        tilt: cam.tilt,
        zoom: cam.zoom);
  }

  CameraPosition _convertToCameraPostion(
      double bearingDefault, double tiltDefault, double zoomDefault) {
    return CameraPosition(
        target: target,
        bearing: bearing ?? bearingDefault,
        tilt: tilt ?? tiltDefault,
        zoom: zoom ?? zoomDefault);
  }

  bool compareLatLng(LatLng otherLatLng) {
    return otherLatLng.latitude == target.latitude &&
        otherLatLng.longitude == target.longitude;
  }

  bool compare(MapsWidgetCameraPosition other) {
    return compareLatLng(other.target) &&
        other.zoom == zoom &&
        other.bearing == bearing &&
        other.tilt == tilt;
  }
}

class _MapsWidgetCameraPosition
    extends ValueNotifier<MapsWidgetCameraPosition?> {
  _MapsWidgetCameraPosition() : super(null);
  updateCameraPosition(MapsWidgetCameraPosition camConfig) {
    value = camConfig;
  }
}

class MapsWidgetState {
  final Set<Marker> markers;
  final Set<Circle> circles;

  MapsWidgetState(this.markers, this.circles);
}

class _MapsWidgetState_ extends ValueNotifier<MapsWidgetState?> {
  _MapsWidgetState_() : super(null);

  setState(Set<Marker> markers, Set<Circle> circles) {
    value = MapsWidgetState(markers, circles);
  }
}

class _MapsWidgetDispose extends ChangeNotifier {
  disposeWidget() {
    notifyListeners();
  }
}

class MapsWidgetController {
  var _cam = _MapsWidgetCameraPosition();
  updateCameraPosition(MapsWidgetCameraPosition camConfig) {
    _cam.updateCameraPosition(camConfig);
  }

  var _state = _MapsWidgetState_();
  setState(Set<Marker> markers, Set<Circle> circles) {
    _state.setState(markers, circles);
  }

  var _dispose = _MapsWidgetDispose();

  dispose() {
    _cam.dispose();
    _state.dispose();
    _dispose.disposeWidget();
  }
}

class MapsWidget extends StatefulWidget {
  final Set<Marker> markers;
  final Set<Circle> circles;
  final CameraPosition initialCameraPosition;
  final void Function(MapsWidgetController) onMapCreated;
  final Function(bool) onMoving;
  final String? mapStyle;
  const MapsWidget({
    Key? key,
    required this.markers,
    required this.circles,
    required this.initialCameraPosition,
    required this.onMapCreated,
    required this.onMoving,
    this.mapStyle,
  }) : super(key: key);

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  GoogleMapController? mapsController;
  late MapsWidgetCameraPosition currentCameraPosition;

  var widgetController = MapsWidgetController();

  @override
  void initState() {
    currentCameraPosition = MapsWidgetCameraPosition._fromCameraPosition(
        widget.initialCameraPosition);
    widgetController._cam.addListener(() {
      if (widgetController._cam.value != null &&
          !widgetController._cam.value!.compare(currentCameraPosition)) {
        currentCameraPosition = widgetController._cam.value!;
        mapsController!.animateCamera(
          CameraUpdate.newCameraPosition(
              currentCameraPosition._convertToCameraPostion(
                  widget.initialCameraPosition.bearing,
                  widget.initialCameraPosition.tilt,
                  widget.initialCameraPosition.zoom)),
        );
      }
    });
    widgetController._state.addListener(() {
      setState(() {});
    });
    widgetController._dispose.addListener(() {
      mapsController?.dispose();
      mapsController = null;
    });
    super.initState();
  }

  @override
  void dispose() {
    mapsController?.dispose();
    mapsController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: widget.initialCameraPosition,
      buildingsEnabled: false, //desativar construções 3D
      zoomControlsEnabled: true,
      mapType: MapType.normal,
      myLocationEnabled: false,
      myLocationButtonEnabled: true,
      onCameraIdle: () {
        widget.onMoving(false);
      },
      onCameraMoveStarted: () {
        widget.onMoving(true);
      },
      onMapCreated: (c) {
        mapsController = c;
        mapsController!.setMapStyle(widget.mapStyle);
        widget.onMapCreated(widgetController);
      },
      markers: widget.markers,
      circles: widget.circles,
    );
  }
}
