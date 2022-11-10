import 'package:flutter/services.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareScreen extends StatefulWidget {
  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
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
                  child: Image.asset('assets/images/sharing-verde.gif'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    'Compartilhe com a galera!',
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
                    'Juntos, conseguiremos inspirar pessoas a se tornarem novos doares.\n\nAcesse a URL abaixo para download do Solidariu\'s App e compartilhe!',
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
                        const url = 'https://bit.ly/downloadSolidariusApp';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Não foi possível abrir a url: $url';
                        }
                      },
                      onLongPress: () async {
                        Clipboard.setData(
                          ClipboardData(
                              text: 'https://bit.ly/downloadSolidariusApp'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppTheme.nearlyOcean,
                            content: Text(
                              "URL copiada. Agora só compartilhar! :)",
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
                              AppTheme.nearlyOcean.withOpacity(0.2))),
                      label: Text(
                        'solidariusappsite.vercel.app',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 0.2,
                          color: AppTheme.nearlyOcean,
                        ),
                      ),
                      icon: Icon(Icons.link, color: AppTheme.nearlyOcean),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
