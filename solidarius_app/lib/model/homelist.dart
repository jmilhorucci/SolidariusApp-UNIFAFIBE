import 'package:solidarius_app/home/pontos_de_coleta/pontos_de_coleta_home_screen.dart';
import 'package:solidarius_app/home/solicitar_ponto/onboarding_solicitar_ponto/onboarding_solicitar_ponto_screen.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/pontos_de_coleta/pontos_de_coleta.png',
      navigateScreen: PontosDeColetaHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/introduction_animation/solicitar_ponto.png',
      navigateScreen: OnboardingSolicitarPontoScreen(),
    ),
    // HomeList(
    //   imagePath: 'assets/introduction_animation/solicitar_ponto.png',
    //   navigateScreen: MenuPage(),
    // ),
    // HomeList(
    //   imagePath: 'assets/introduction_animation/solicitar_ponto.png',
    //   navigateScreen: DesignCourseHomeScreen(),
    // ),
  ];
}
