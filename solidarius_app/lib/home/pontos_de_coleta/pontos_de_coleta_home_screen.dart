import 'dart:async';

import 'package:solidarius_app/theme/app_theme.dart';
import 'package:solidarius_app/home/pontos_de_coleta/models/tabIcon_data.dart';
import 'package:solidarius_app/home/pontos_de_coleta/screens/lista_locais/locais_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:solidarius_app/home/pontos_de_coleta/screens/pontos_de_coletas/locais_maps_view.dart';
import 'package:solidarius_app/widgets/full_loading.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'screens/informacoes/informacoes_screen.dart';
import 'screens/pontos_de_coletas/locais_maps_screen.dart';

class PontosDeColetaHomeScreen extends StatefulWidget {
  @override
  _PontosDeColetaHomeScreenState createState() =>
      _PontosDeColetaHomeScreenState();
}

class _PontosDeColetaHomeScreenState extends State<PontosDeColetaHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  var disposeLocaisEvent = DisposeLocaisEvent();
  var pevIndex = 0;
  var currentIndex = 0;
  bool disabledMenu = true;
  bool shouldPop = false;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = LocaisMapsScreen(
      animationController: animationController,
      disposeLocaisEvent: disposeLocaisEvent,
      onMoving: (moving) {
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() {
            disabledMenu = moving;
            print('movendo: $moving');
            Future.delayed(Duration(milliseconds: 1000), () {
              if (moving == false) {
                shouldPop = true; // desbloquea
                print('Botão Voltar liberado: $shouldPop');
              } else if (moving == true) {
                shouldPop = false;
                print('Botão Voltar bloqueado: $shouldPop'); // bloqueado
              }
            });
          });
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Container(
        color: AppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    tabBody,
                    bottomBar(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  // controla o conteúdo de cada item do menu
  void updateBody(int index) async {
    pevIndex = currentIndex;
    currentIndex = index;

    if (pevIndex == 0) {
      disposeLocaisEvent.disposeWidget();
    }

    // menu 1 = Google Maps
    if (index == 0) {
      setState(() {
        disabledMenu = true;
        shouldPop = false;
        FullLoading.show(context);
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(
            () {
              FullLoading.hide(context);
              tabBody = LocaisMapsScreen(
                  animationController: animationController,
                  disposeLocaisEvent: disposeLocaisEvent,
                  onMoving: (moving) {
                    shouldPop = false;

                    disabledMenu = moving;
                    print('movendo: $moving');
                    Future.delayed(Duration(milliseconds: 1000), () {
                      if (moving == false) {
                        shouldPop = true; // desbloquea
                        print('Botão Voltar liberado: $shouldPop');
                      } else if (moving == true) {
                        shouldPop = false;
                        print(
                            'Botão Voltar bloqueado: $shouldPop'); // bloqueado
                      }
                    });
                  });
            },
          );
        });
      });

      // menu 2 = listagem de locais
    } else if (index == 1) {
      shouldPop = false; // bloqueado
      print('Botão Voltar bloqueado: $shouldPop');
      FullLoading.show(context);
      Future.delayed(Duration(milliseconds: 2000), () {
        setState(() {
          shouldPop = true;
          print('Botão Voltar liberado: $shouldPop');
          FullLoading.hide(context);
          tabBody = LocaisListScreen(animationController: animationController);
        });
      });

      // menu 3 = informações
    } else if (index == 3) {
      shouldPop = false; // bloqueado
      print('Botão Voltar bloqueado: $shouldPop');
      FullLoading.show(context);
      Future.delayed(Duration(milliseconds: 2000), () {
        setState(() {
          shouldPop = true;
          print('Botão Voltar liberado: $shouldPop');
          FullLoading.hide(context);
          tabBody = InformacoesScreen(animationController: animationController);
        });
      });
    }
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        AbsorbPointer(
          absorbing: false,
          child: BottomBarView(
            tabIconsList: tabIconsList,
            addClick: () {},
            changeIndex: (int index) {
              updateBody(index);
            },
          ),
        ),
      ],
    );
  }
}
