import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:solidarius_app/model/usuario_api.dart';
import 'package:solidarius_app/service/base.service.dart';

bool conseguiuLogarAoAbrirApp = GetIt.I<bool>();

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  final InternetConnectionChecker connectionCheckerInstance =
      GetIt.I<InternetConnectionChecker>();

  Future<void> execute(
      InternetConnectionChecker internetConnectionChecker, context) async {
    // verificação simples para ver se temos Internet

    print('''A declaração 'esta máquina está conectada à internet' é: ''');
    final bool isConnected = await InternetConnectionChecker().hasConnection;

    print(
      isConnected.toString(),
    );
    // returns a bool

    // também pode-se obter um enum em vez de um bool
    // ignore: avoid_print
    print(
      'Status atual: ${await InternetConnectionChecker().connectionStatus}',
    );
    // imprime InternetConnectionStatus.connected
    // ou InternetConnectionStatus.disconnected

    // escuta ativamente as atualizações de status
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            // ignore: avoid_print
            print('A conexão de dados está disponível.');
            if (conseguiuLogarAoAbrirApp == false) {
              conseguiuLogarAoAbrirApp = true;
              var _usuarioApi = await autenticarApi();
              GetIt.I.registerSingleton<UsuarioApi>(_usuarioApi);
            }
            Navigator.of(context).pop();
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            showDialog(context: context, builder: (_) => const OfflineScreen());
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    execute(connectionCheckerInstance, context);

    bool loading = false;

    Future.delayed(Duration(milliseconds: 3000), () {
      loading = true;
    });
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: AppTheme.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Ops!',
                        style: TextStyle(
                            color: AppTheme.nearlyPurple,
                            fontFamily: 'WorkSans',
                            fontSize: 38,
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          'Sem conexão com a internet :(',
                          style: TextStyle(
                              color: AppTheme.nearlyPurple,
                              fontFamily: 'WorkSans',
                              fontSize: 18,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'assets/images/sem-conexao-roxo.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          'Verifique sua conexão com a internet para continuar utilizando o aplicativo.',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppTheme.nearlyBlack,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            letterSpacing: 0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24.0, bottom: 8.0),
                              child: CircularProgressIndicator(
                                  color: AppTheme.nearlyPurple),
                            ),
                            Text(
                              'Aguardando conexão...',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: AppTheme.nearlyBlack,
                                fontFamily: 'WorkSans',
                                fontSize: 14,
                                letterSpacing: 0.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
