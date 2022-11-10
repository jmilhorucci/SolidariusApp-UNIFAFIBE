import 'package:flutter/services.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AjudaScreen extends StatefulWidget {
  @override
  _AjudaScreenState createState() => _AjudaScreenState();
}

class _AjudaScreenState extends State<AjudaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 16,
                      right: 16),
                  child: Image.asset('assets/images/support-roxo.gif'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    'Está com problemas para utilizar o aplicativo?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'WorkSans',
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    'Se você estiver passando por problemas técnicos ou precisando de alguma ajuda para utilizar nosso aplicativo, orientamos a abrir uma ordem de serviço para o e-mail:',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'WorkSans',
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: TextButton.icon(
                      onPressed: () async {
                        const email = 'solidariusapp@outlook.com';
                        launch('mailto:$email');
                      },
                      onLongPress: () async {
                        Clipboard.setData(
                          ClipboardData(text: 'solidariusapp@outlook.com'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppTheme.nearlyPurple,
                            content: Text(
                              "E-mail copiado!",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'WorkSans',
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        );
                      },
                      style: ButtonStyle(
                          overlayColor: MaterialStatePropertyAll(
                              AppTheme.nearlyPurple.withOpacity(0.2))),
                      label: Text(
                        'solidariusapp@outlook.com',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 0.2,
                          color: AppTheme.nearlyPurple,
                        ),
                      ),
                      icon: Icon(Icons.email, color: AppTheme.nearlyPurple),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child:
                            const Icon(Icons.info, color: AppTheme.nearlyLabel),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          'Toque para acessar a URL ou pressione sobre o texto para copiá-lo.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: AppTheme.nearlyLabel,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    'No corpo do e-mail, descreva detalhadamente sobre, e se necessário, incluir imagens (capturas de tela) para facilitar no processo de analise desta ordem de serviço.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'WorkSans',
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child:
                            const Icon(Icons.info, color: AppTheme.nearlyLabel),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          'O prazo inicial para analise das informações é em até 3 dias úteis. Este período poderá ser extendido se houver algum problema durante o processo de analise.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: AppTheme.nearlyLabel,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
