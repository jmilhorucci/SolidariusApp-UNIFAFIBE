import 'package:flutter/services.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
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
                  child: Image.asset('assets/images/feedback.gif'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    'O Solidariu\'s App precisa de você!',
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
                    'Sua avaliação é importante para o desenvolvimento deste projeto!',
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
                  child: Text(
                      'Toque no botão abaixo para acessar o formulário de avaliação.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        letterSpacing: 0.2,
                        fontSize: 16,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: TextButton.icon(
                      onPressed: () async {
                        const url = 'https://bit.ly/formsSolidariusApp';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Não foi possível abrir a url: $url';
                        }
                      },
                      onLongPress: () async {
                        Clipboard.setData(
                          ClipboardData(
                              text: 'https://bit.ly/formsSolidariusApp'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppTheme.nearlyPurple,
                            content: Text(
                              "URL copiada!",
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
                        'Acessar formulário',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 0.2,
                          color: AppTheme.nearlyPurple,
                        ),
                      ),
                      icon: Icon(Icons.link, color: AppTheme.nearlyPurple),
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
                    'Tempo médio para responder o formulário: 5 minutos',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                    ),
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
