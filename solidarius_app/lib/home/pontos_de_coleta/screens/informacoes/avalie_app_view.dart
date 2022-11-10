import 'package:accordion/accordion.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AvalieAppView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const AvalieAppView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Accordion(
                maxOpenSections: 7,
                disableScrolling: true,
                headerBackgroundColorOpened: Colors.black54,
                headerPadding: const EdgeInsets.all(16),
                paddingListBottom: 0,
                paddingListTop: 8,
                children: [
                  //Doações Aceitas
                  AccordionSection(
                    isOpen: true,
                    leftIcon: const Icon(Icons.feedback, color: Colors.white),
                    headerBackgroundColor: AppTheme.nearlyLightPurple,
                    headerBackgroundColorOpened: AppTheme.nearlyPurple,
                    header: Text(
                      'Avalie o App',
                      style: TextStyle(
                          color: AppTheme.nearlyWhite,
                          fontFamily: 'WorkSans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          Text(
                              'Sua avaliação é importante para o desenvolvimento deste projeto!',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'WorkSans',
                                // fontSize: 18,
                                letterSpacing: 0.2,
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                                'Toque no botão abaixo para acessar o formulário de avaliação.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  letterSpacing: 0.2,
                                )),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              const url = 'https://bit.ly/formsSolidariusApp';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Não foi possível abrir a url: $url';
                              }
                            },
                            style: ButtonStyle(
                                overlayColor: MaterialStatePropertyAll(
                                    AppTheme.nearlyPurple.withOpacity(0.2))),
                            label: Text(
                              'Acessar formulário',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                letterSpacing: 0.2,
                                color: AppTheme.nearlyPurple,
                              ),
                            ),
                            icon:
                                Icon(Icons.link, color: AppTheme.nearlyPurple),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                                'Tempo médio para responder o formulário: 5 minutos',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  letterSpacing: 0.2,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
