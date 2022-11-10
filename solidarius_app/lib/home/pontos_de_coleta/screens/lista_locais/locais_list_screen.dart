import 'dart:async';

import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'locais_list_view.dart';

class LocaisListScreen extends StatefulWidget {
  const LocaisListScreen({Key? key, this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  _LocaisListScreenState createState() => _LocaisListScreenState();
}

class _LocaisListScreenState extends State<LocaisListScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  final controller = LocaisListViewController();
  Timer? timerToSearch;
  var searchInputController = TextEditingController();

  List<Widget> listViews = <Widget>[];
  // final ScrollController scrollController = ScrollController();
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

    // scrollController.addListener(() {
    //   if (scrollController.offset >= 24) {
    //     if (topBarOpacity != 1.0) {
    //       setState(() {
    //         topBarOpacity = 1.0;
    //       });
    //     }
    //   } else if (scrollController.offset <= 24 &&
    //       scrollController.offset >= 0) {
    //     if (topBarOpacity != scrollController.offset / 24) {
    //       setState(() {
    //         topBarOpacity = scrollController.offset / 24;
    //       });
    //     }
    //   } else if (scrollController.offset <= 0) {
    //     if (topBarOpacity != 0.0) {
    //       setState(() {
    //         topBarOpacity = 0.0;
    //       });
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    timerToSearch?.cancel();
    Future.delayed(Duration.zero, () {
      widget.animationController?.reset();
    });
    super.dispose();
  }

  void addAllListData() {
    const int count = 1;
//Tamanho do listView abaixo (2 = suporta até dois listView.add, sendo a posição 0 até 1)

    listViews.add(
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: LocaisListView(
          controller: controller,
          mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController!,
                  curve: Interval((1 / count) * 0, 1.0,
                      curve: Curves.fastOutSlowIn))),
          mainScreenAnimationController: widget.animationController!,
        ),
      ),
    );
  }

  // listViews.add()

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            color: AppTheme.nearlyPurple,
          ));
        } else {
          return Column(
            children: [
              Flexible(
                flex: 5,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: AppBar().preferredSize.height +
                        MediaQuery.of(context).padding.top +
                        80,
                    bottom: 100 + MediaQuery.of(context).padding.bottom,
                  ),
                  itemCount: listViews.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    widget.animationController?.forward();
                    return listViews[index];
                  },
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.1,
              // ),
            ],
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
                        ),
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
                                  'Lista de Locais',
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                    controller: searchInputController,
                                    minLines: 1,
                                    maxLines: 1,
                                    cursorColor: AppTheme.nearlyOcean,
                                    style: TextStyle(
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppTheme.nearlyPurple,
                                    ),
                                    onChanged: (value) {
                                      timerToSearch?.cancel();
                                      timerToSearch = Timer(
                                          Duration(milliseconds: 800), () {
                                        controller.filtrar(value);
                                      });
                                    },
                                    onSubmitted: (value) {
                                      controller.filtrar(value);
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            width: 1, color: AppTheme.steps),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            width: 1, color: AppTheme.steps),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppTheme.nearlyError),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppTheme.nearlyPurple),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: AppTheme.nearlyError),
                                      ),
                                      errorStyle: TextStyle(
                                        color: AppTheme.nearlyError,
                                        fontSize: 13,
                                      ),
                                      counterStyle: TextStyle(
                                        color: AppTheme.nearlyPurple,
                                      ),
                                      filled: true, //fundo claro
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15),
                                      hintText: 'Pesquisar',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        letterSpacing: 0.2,
                                        color: AppTheme.nearlyLabel,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      isDense: true,
                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () {},
                                        color: AppTheme.nearlyPurple,
                                        iconSize: 20,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          controller.filtrar("");
                                          searchInputController.clear();
                                        },
                                        color: AppTheme.nearlyError,
                                        iconSize: 20,
                                      ),
                                      focusColor: AppTheme.nearlyOcean,
                                    ),
                                    autofocus: false,
                                    textInputAction: TextInputAction.search),
                              ),
                            ),
                          ],
                        ),
                      ),
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
