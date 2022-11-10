// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:solidarius_app/controllers/new_locais_controller.dart';
import 'package:solidarius_app/widgets/local_detalhes.dart';
import 'package:solidarius_app/widgets/maps_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_switch/flutter_switch.dart';

final appKey = GlobalKey();

class DisposeLocaisEvent extends ChangeNotifier {
  disposeWidget() {
    notifyListeners();
  }
}

class LocaisMapsView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  final DisposeLocaisEvent disposeLocaisEvent;
  final Function(bool) onMoving;
  LocaisMapsView(
      {Key? key,
      this.animationController,
      this.animation,
      required this.disposeLocaisEvent,
      required this.onMoving})
      : super(key: key);

  @override
  State<LocaisMapsView> createState() => _LocaisMapsViewState();
}

class _LocaisMapsViewState extends State<LocaisMapsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int? prevPage;
  bool status7 = false;

  var newController = NewLocaisController();

  @override
  void initState() {
    super.initState();
    newController.init(() {
      setState(() {});
    }).then((_) {
      setState(() {});
    });
    widget.disposeLocaisEvent.addListener(() async {
      await newController.dispose();
    });
  }

  @override
  void dispose() {
    newController.dispose();
    super.dispose();
  }

  _locaisRepository(index) {
    var item = newController.data[index];
    return Builder(
      builder: (context) {
        return AnimatedBuilder(
          animation: newController.pageController,
          builder: (BuildContext context, Widget? widget) {
            double value = 1;
            if (newController.pageController.hasClients &&
                newController.pageController.position.haveDimensions) {
              value = newController.pageController.page! - index;
              value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
            }
            return Center(
              heightFactor: 0,
              child: SizedBox(
                height: Curves.easeInOut.transform(value) *
                    MediaQuery.of(context).size.height,
                width: Curves.easeInOut.transform(value) *
                    MediaQuery.of(context).size.width,
                child: widget,
              ),
            );
          },
          child: InkWell(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 0, bottom: 0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            height: 130.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black54,
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                splashColor:
                                    AppTheme.nearlyPurple.withOpacity(0.2),
                                onTap: () {
                                  showCupertinoModalBottomSheet(
                                    context: appKey.currentState!.context,
                                    builder: (context) =>
                                        LocalDetalhes(local: item),
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      child: SizedBox(
                                        height: 90,
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.asset(
                                              "assets/pontos_de_coleta/back.png"),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 25,
                                      left: 8,
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.white,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: AppTheme.grey
                                                    .withOpacity(0.6),
                                                offset: const Offset(2.0, 4.0),
                                                blurRadius: 8),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                  topLeft:
                                                      Radius.circular(10.0)),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: item.foto,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child:
                                                    CircularProgressIndicator(
                                                        color: AppTheme
                                                            .nearlyPurple),
                                              ),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.image_not_supported,
                                                color: AppTheme.nearlyPurple,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          flex: 5,
                                          fit: FlexFit.tight,
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 100,
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 2,
                                                ),
                                                child: Container(
                                                  /* DPI 392 ATÉ 480 */
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      ((1.05 * 198.6) + 1.47),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 8,
                                                    ),
                                                    child: AutoSizeText(
                                                      item.nome,
                                                      maxFontSize: 16,
                                                      minFontSize: 14,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppTheme.fontName,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        letterSpacing: 0.2,
                                                        color: AppTheme
                                                            .nearlyPurple,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          fit: FlexFit.tight,
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 100,
                                                  bottom: 0,
                                                  top: 0,
                                                  right: 0,
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      ((1.05 * 198.6) + 1.47),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 8,
                                                    ),
                                                    child: AutoSizeText(
                                                      item.endereco,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      // textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppTheme.fontName,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10,
                                                        letterSpacing: 0.0,
                                                        color: AppTheme.grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 4,
                                          fit: FlexFit.tight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 2,
                                              left: 100,
                                              right: 0,
                                              bottom: 8,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      ((1.05 * 198.6) + 1.47),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 8,
                                                    ),
                                                    child: AutoSizeText(
                                                      item.itens!.join(' • '),
                                                      textAlign:
                                                          TextAlign.justify,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily:
                                                            AppTheme.fontName,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        letterSpacing: 0.2,
                                                        color: AppTheme
                                                            .nearlyOcean,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ),
                        // ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                1.0, 30 * (1.0 - widget.animation!.value), 1.0),
            child: Scaffold(
              key: appKey,
              body: Builder(builder: (context) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: <Widget>[
                      if (newController.erroMessage != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                newController.erroMessage!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.nearlyOcean,
                                  fontFamily: 'WorkSans',
                                  fontSize: 18,
                                  letterSpacing: 0.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  'assets/images/mapa-verde.gif',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (newController.currentPosition != null)
                        MapsWidget(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                newController.currentPosition!.latitude,
                                newController.currentPosition!.longitude),
                            zoom: 20,
                            bearing: 0,
                          ),
                          onMoving: widget.onMoving,
                          onMapCreated: newController.onMapCreated,
                          markers: newController.markers,
                          circles: newController.circles,
                          mapStyle: newController.mapStyle,
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TaggleCurrentPosition(
                                  newLocaisController: newController,
                                  setState: () => setState(() {}),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 100.0,
                        child: SizedBox(
                          height: 155.0,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                            controller: newController.pageController,
                            itemCount: newController.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _locaisRepository(index);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class TaggleCurrentPosition extends StatefulWidget {
  final NewLocaisController newLocaisController;
  final Function() setState;
  const TaggleCurrentPosition(
      {Key? key, required this.newLocaisController, required this.setState})
      : super(key: key);

  @override
  State<TaggleCurrentPosition> createState() => _TaggleCurrentPositionState();
}

class _TaggleCurrentPositionState extends State<TaggleCurrentPosition> {
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      value: !widget.newLocaisController.listeningCurrentPosition,
      borderRadius: 30.0,
      padding: 2.0,
      activeToggleColor: AppTheme.nearlyPurple,
      inactiveToggleColor: AppTheme.nearlyOcean,
      activeSwitchBorder: Border.all(
        color: AppTheme.nearlyPurple,
        width: 6.0,
      ),
      inactiveSwitchBorder: Border.all(
        color: AppTheme.nearlyOcean,
        width: 6.0,
      ),
      activeColor: AppTheme.nearlyWhite,
      inactiveColor: AppTheme.nearlyWhite,
      activeIcon: Image.asset('assets/pontos_de_coleta/location_w.png'),
      inactiveIcon: Image.asset('assets/pontos_de_coleta/user-location_w.png'),
      onToggle: (val) {
        setState(() {
          if (!val) {
            widget.newLocaisController.initListenerCurrentLocation();
          } else {
            widget.newLocaisController
                .stopListenerCurrentLocation(widget.setState);
          }
        });
      },
    );
  }
}
