import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_it/get_it.dart';
import 'package:solidarius_app/model/usuario_api.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'navigation_home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'home/pontos_de_coleta/models/locais_list_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  final InternetConnectionChecker customInstance =
      InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 1),
    checkInterval: const Duration(seconds: 1),
  );
  registrarConnectionChecker(customInstance);

  // if (Platform.isAndroid) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  // }

  // var usuarioApi = await autenticarApi();
  // registrarUsuarioApi(usuarioApi);
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then(
    (_) => runApp(
      ChangeNotifierProvider<LocaisRepository>(
        create: (_) => LocaisRepository(),
        child: MyApp(),
      ),
    ),
  );
}

registrarConnectionChecker(InternetConnectionChecker customInstance) {
  GetIt.I.registerSingleton<InternetConnectionChecker>(customInstance);
}

void registrarUsuarioApi(UsuarioApi usuarioApi) {
  GetIt.I.registerSingleton<UsuarioApi>(usuarioApi);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InternetConnectionChecker connectionCheckerInstance =
        GetIt.I<InternetConnectionChecker>();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
        title: 'Solidariu\'s App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        home: AnimatedSplashScreen(
            duration: 3000,
            splashIconSize: 200,
            splash: Image.asset('assets/images/solidariusapp-logo-w.png'),
            nextScreen: NavigationHomeScreen(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: AppTheme.nearlyPurple));
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
