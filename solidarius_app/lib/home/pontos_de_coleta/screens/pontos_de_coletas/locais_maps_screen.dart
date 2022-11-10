import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'locais_maps_view.dart';

class LocaisMapsScreen extends StatefulWidget {
  final DisposeLocaisEvent disposeLocaisEvent;
  final Function(bool) onMoving;
  const LocaisMapsScreen(
      {Key? key,
      this.animationController,
      required this.disposeLocaisEvent,
      required this.onMoving})
      : super(key: key);

  final AnimationController? animationController;
  @override
  _LocaisMapsScreenState createState() => _LocaisMapsScreenState();
}

class _LocaisMapsScreenState extends State<LocaisMapsScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    Future.delayed(Duration.zero, () {
      addAllListData();
    });

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          Future.delayed(Duration.zero, () {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          Future.delayed(Duration.zero, () {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          Future.delayed(Duration.zero, () {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 1;

    listViews.add(
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 175,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 4.0),
              blurRadius: 10.0,
            ),
          ]),
          child: LocaisMapsView(
            onMoving: widget.onMoving,
            disposeLocaisEvent: widget.disposeLocaisEvent,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController!,
                    curve: Interval((1 / count) * 0, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController!,
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Container(
          color: AppTheme.background,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                getMainListViewUI(),
                getAppBarUI(),
                // SizedBox(
                //   height: MediaQuery.of(context).padding.bottom,
                // )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            color: AppTheme.nearlyOcean,
          ));
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,

              // bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
// Voltar ao homepage
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: AppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Pontos de Coleta',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppTheme.nearlyPurple,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: Center(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
