import 'package:accordion/accordion.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
                  child: Image.asset('assets/images/solidariusapp-logo.png',
                      height: 200),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    'Sobre o App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'WorkSans',
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Accordion(
                  maxOpenSections: 7,
                  disableScrolling: true,
                  headerBackgroundColorOpened: Colors.black54,
                  headerPadding: const EdgeInsets.all(16),
                  paddingListBottom: 0,
                  paddingListTop: 8,
                  children: [
                    AccordionSection(
                      isOpen: true,
                      leftIcon: Image.asset(
                          'assets/images/solidariusapp-logo-w.png',
                          height: 25),
                      headerBackgroundColor: AppTheme.nearlyLightPurple,
                      headerBackgroundColorOpened: AppTheme.nearlyPurple,
                      header: Text(
                        'Solidariu\'s App',
                        style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        children: [
                          Accordion(
                            maxOpenSections: 7,
                            disableScrolling: true,
                            headerBackgroundColorOpened: Colors.black54,
                            headerPadding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 16),
                            paddingListBottom: 0,
                            paddingListTop: 8,
                            paddingListHorizontal: 0,
                            contentHorizontalPadding: 20,
                            contentBorderWidth: 0,
                            contentBorderColor: Colors.transparent,
                            children: [
                              AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(
                                  Icons.info,
                                  color: AppTheme.nearlyOcean,
                                ),
                                rightIcon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppTheme.nearlyOcean,
                                  size: 20,
                                ),
                                headerBackgroundColor: Colors.transparent,
                                headerBackgroundColorOpened: Colors.transparent,
                                header: Text(
                                  'Versão do Aplicativo',
                                  style: TextStyle(
                                      color: AppTheme.nearlyBlack,
                                      fontFamily: 'WorkSans',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: Text('1.0.0.beta',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        letterSpacing: 0.2,
                                      )),
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                leftIcon: const Icon(
                                  Icons.security,
                                  color: AppTheme.nearlyOcean,
                                ),
                                rightIcon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppTheme.nearlyOcean,
                                  size: 20,
                                ),
                                headerBackgroundColor: Colors.transparent,
                                headerBackgroundColorOpened: Colors.transparent,
                                header: Text(
                                  'Políticas de Privacidade e Termos de Uso',
                                  style: TextStyle(
                                      color: AppTheme.nearlyBlack,
                                      fontFamily: 'WorkSans',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Center(
                                        child: TextButton.icon(
                                          onPressed: () async {
                                            const url = 'https://';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Não foi possível abrir a url: $url';
                                            }
                                          },
                                          onLongPress: () async {
                                            Clipboard.setData(
                                              ClipboardData(text: 'https://'),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    AppTheme.nearlyOcean,
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
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      AppTheme.nearlyOcean
                                                          .withOpacity(0.2))),
                                          label: Text(
                                            'Acessar Políticas de Privacidade',
                                            style: TextStyle(
                                              fontFamily: 'WorkSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              color: AppTheme.nearlyOcean,
                                            ),
                                          ),
                                          icon: Icon(Icons.link,
                                              color: AppTheme.nearlyOcean),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Center(
                                        child: TextButton.icon(
                                          onPressed: () async {
                                            const url = 'https://';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Não foi possível abrir a url: $url';
                                            }
                                          },
                                          onLongPress: () async {
                                            Clipboard.setData(
                                              ClipboardData(text: 'https://'),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    AppTheme.nearlyOcean,
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
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      AppTheme.nearlyOcean
                                                          .withOpacity(0.2))),
                                          label: Text(
                                            'Acessar Termos de Uso',
                                            style: TextStyle(
                                              fontFamily: 'WorkSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              color: AppTheme.nearlyOcean,
                                            ),
                                          ),
                                          icon: Icon(Icons.link,
                                              color: AppTheme.nearlyOcean),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AccordionSection(
                      isOpen: true,
                      leftIcon: const Icon(
                        Icons.groups,
                        color: AppTheme.white,
                      ),
                      headerBackgroundColor: AppTheme.nearlyLightPurple,
                      headerBackgroundColorOpened: AppTheme.nearlyPurple,
                      header: Text(
                        'Desenvolvedores',
                        style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        children: [
                          Accordion(
                            maxOpenSections: 7,
                            disableScrolling: true,
                            headerBackgroundColorOpened: Colors.black54,
                            headerPadding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 16),
                            paddingListBottom: 0,
                            paddingListTop: 8,
                            paddingListHorizontal: 0,
                            contentHorizontalPadding: 20,
                            contentBorderWidth: 0,
                            contentBorderColor: Colors.transparent,
                            children: [
                              AccordionSection(
                                isOpen: false,
                                leftIcon: const Icon(
                                  Icons.person,
                                  color: AppTheme.nearlyOcean,
                                ),
                                rightIcon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppTheme.nearlyOcean,
                                  size: 20,
                                ),
                                headerBackgroundColor: Colors.transparent,
                                headerBackgroundColorOpened: Colors.transparent,
                                header: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Juliano Milhorucci',
                                        style: TextStyle(
                                            color: AppTheme.nearlyBlack,
                                            fontFamily: 'WorkSans',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Front-end Developer',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontFamily: 'WorkSans',
                                            letterSpacing: 0.2,
                                          )),
                                    ),
                                  ],
                                ),
                                content: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, top: 8.0),
                                      child: Center(
                                        child: TextButton.icon(
                                          onPressed: () async {
                                            const url =
                                                'https://github.com/jmilhorucci';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Não foi possível abrir a url: $url';
                                            }
                                          },
                                          onLongPress: () async {
                                            Clipboard.setData(
                                              ClipboardData(
                                                  text:
                                                      'https://github.com/jmilhorucci'),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    AppTheme.nearlyOcean,
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
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      AppTheme.nearlyOcean
                                                          .withOpacity(0.2))),
                                          label: Text(
                                            'Acessar GitHub',
                                            style: TextStyle(
                                              fontFamily: 'WorkSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              color: AppTheme.nearlyOcean,
                                            ),
                                          ),
                                          icon: FaIcon(FontAwesomeIcons.github,
                                              size: 20,
                                              color: AppTheme.nearlyOcean),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Center(
                                        child: TextButton.icon(
                                          onPressed: () async {
                                            const url =
                                                'https://www.linkedin.com/in/julianomilhorucci/';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Não foi possível abrir a url: $url';
                                            }
                                          },
                                          onLongPress: () async {
                                            Clipboard.setData(
                                              ClipboardData(
                                                  text:
                                                      'https://www.linkedin.com/in/julianomilhorucci/'),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    AppTheme.nearlyOcean,
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
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      AppTheme.nearlyOcean
                                                          .withOpacity(0.2))),
                                          label: Text(
                                            'Acessar Linkedin',
                                            style: TextStyle(
                                              fontFamily: 'WorkSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              color: AppTheme.nearlyOcean,
                                            ),
                                          ),
                                          icon: FaIcon(
                                              FontAwesomeIcons.linkedin,
                                              size: 20,
                                              color: AppTheme.nearlyOcean),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                leftIcon: const Icon(
                                  Icons.person,
                                  color: AppTheme.nearlyOcean,
                                ),
                                rightIcon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppTheme.nearlyOcean,
                                  size: 20,
                                ),
                                headerBackgroundColor: Colors.transparent,
                                headerBackgroundColorOpened: Colors.transparent,
                                header: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Vinicius Herculano',
                                        style: TextStyle(
                                            color: AppTheme.nearlyBlack,
                                            fontFamily: 'WorkSans',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Back-end Developer',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontFamily: 'WorkSans',
                                            letterSpacing: 0.2,
                                          )),
                                    ),
                                  ],
                                ),
                                content: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, top: 8.0),
                                      child: Center(
                                        child: TextButton.icon(
                                          onPressed: () async {
                                            const url =
                                                'https://github.com/ViniciusHerculano/';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Não foi possível abrir a url: $url';
                                            }
                                          },
                                          onLongPress: () async {
                                            Clipboard.setData(
                                              ClipboardData(
                                                  text:
                                                      'https://github.com/ViniciusHerculano'),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    AppTheme.nearlyOcean,
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
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      AppTheme.nearlyOcean
                                                          .withOpacity(0.2))),
                                          label: Text(
                                            'Acessar GitHub',
                                            style: TextStyle(
                                              fontFamily: 'WorkSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              color: AppTheme.nearlyOcean,
                                            ),
                                          ),
                                          icon: FaIcon(FontAwesomeIcons.github,
                                              size: 20,
                                              color: AppTheme.nearlyOcean),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Center(
                                        child: TextButton.icon(
                                          onPressed: () async {
                                            const url =
                                                'https://www.linkedin.com/in/vinicius-herculano/';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Não foi possível abrir a url: $url';
                                            }
                                          },
                                          onLongPress: () async {
                                            Clipboard.setData(
                                              ClipboardData(
                                                  text:
                                                      'https://www.linkedin.com/in/vinicius-herculano/'),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    AppTheme.nearlyOcean,
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
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      AppTheme.nearlyOcean
                                                          .withOpacity(0.2))),
                                          label: Text(
                                            'Acessar Linkedin',
                                            style: TextStyle(
                                              fontFamily: 'WorkSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              color: AppTheme.nearlyOcean,
                                            ),
                                          ),
                                          icon: FaIcon(
                                              FontAwesomeIcons.linkedin,
                                              size: 20,
                                              color: AppTheme.nearlyOcean),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
