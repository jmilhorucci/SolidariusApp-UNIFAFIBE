import 'package:accordion/accordion.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SobreAppView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const SobreAppView({Key? key, this.animationController, this.animation})
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
                  AccordionSection(
                    isOpen: false,
                    leftIcon: const Icon(Icons.info, color: Colors.white),
                    headerBackgroundColor: AppTheme.nearlyLightPurple,
                    headerBackgroundColorOpened: AppTheme.nearlyPurple,
                    header: Text(
                      'Sobre',
                      style: TextStyle(
                          color: AppTheme.nearlyWhite,
                          fontFamily: 'WorkSans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 16, right: 16),
                          child: Text(
                            'O Solidariu\'s App surgiu com intuíto de ajudar você à ajudar o próximo. Conheça mais sobre o app abaixo.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
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
                              leftIcon: const Icon(Icons.message,
                                  color: AppTheme.nearlyOcean),
                              rightIcon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppTheme.nearlyLightPurple,
                                size: 20,
                              ),
                              headerBackgroundColor: Colors.transparent,
                              headerBackgroundColorOpened: Colors.transparent,
                              header: Text(
                                'Motivo da Criação',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                  'Atualmente, os processos de arrecadações de recursos beneficentes na cidade de Bebedouro-SP são realizados no formato de campanhas por instituições privadas e públicas, com editais separados em determinadas épocas do ano ou conforme a necessidade.\n\nOs meios de comunicação para anunciar estas ações são rádios, redes sociais, portais de noticias e institucionais, “boca a boca” e internamente para os colaboradores e agregados de algumas empresas que aderem as campanhas.\n\nDesse modo, as informações ficam dispersas e carentes de acesso, pois estas divulgações só atingirão as pessoas com acesso a esses meios de comunicação.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.2,
                                  )),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(Icons.lightbulb,
                                  color: AppTheme.nearlyYellow),
                              rightIcon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppTheme.nearlyLightPurple,
                                size: 20,
                              ),
                              headerBackgroundColor: Colors.transparent,
                              headerBackgroundColorOpened: Colors.transparent,
                              header: Text(
                                'Ideia',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                  'De acordo com esse cenário, tivemos a ideia de criar um aplicativo para smartphones com objetivo de centralizar essas informações, facilitar o seu acesso, aumentar o acervo de arrecadações e inspirar novas pessoas a se tornarem doadores.\n\nDesta forma, o doador interessado conseguirá reconhecer os estabelecimentos de sua região que aceitam doações, assim como, visualizar mais informações sobre o local selecionado.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.2,
                                  )),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(Icons.favorite,
                                  color: AppTheme.nearlyError),
                              rightIcon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppTheme.nearlyLightPurple,
                                size: 20,
                              ),
                              headerBackgroundColor: Colors.transparent,
                              headerBackgroundColorOpened: Colors.transparent,
                              header: Text(
                                'A Origem',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                  'Consultando os principais sites de buscas e lojas de aplicativos, não foi encontrado nenhum com a mesma finalidade proposta. Portanto, o Solidariu\’s App surgiu para cumprir esses objetivos a fim de apoiar todas instituições e estabelecimentos da região que praticam o trabalho social em prol do amor.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.2,
                                  )),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(Icons.settings,
                                  color: AppTheme.nearlyBlue),
                              rightIcon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppTheme.nearlyLightPurple,
                                size: 20,
                              ),
                              headerBackgroundColor: Colors.transparent,
                              headerBackgroundColorOpened: Colors.transparent,
                              header: Text(
                                'Funcionalidades',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                  'O Solidariu\’s App demarcará no mapa pontos de coletas que poderão ser instituições públicas e privadas (com CNPJ ativo), que praticam ou apoiam ações e campanhas beneficentes na região.\n\nO responsável da instituição solicitará a inclusão do estabelecimento no mapa através de um formulário localizado na Home do aplicativo.\n\nAs informações preenchidas no formulário são referentes ao estabelecimento, tais como: foto, contatos, localização, horário de funcionamento, quais tipos de bens arrecadados são aceitos, qual será o fim destas doações, e entre outras informações.\n\nAs doações serão entregues pelo próprio doador para o ponto de sua escolha, porém, para facilitar, na tela do mapa onde é demarcado os pontos, será exibidos em forma de destaques os 5 estabelecimentos mais próximos de sua localização atual.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.2,
                                  )),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(Icons.android,
                                  color: AppTheme.nearlyGreen),
                              rightIcon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppTheme.nearlyLightPurple,
                                size: 20,
                              ),
                              headerBackgroundColor: Colors.transparent,
                              headerBackgroundColorOpened: Colors.transparent,
                              header: Text(
                                'Disponibilidade',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                  'O Solidariu\’s App estará disponível somente para smartphones com sistema operacional Android, versão 8.0 ou superior.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.2,
                                  )),
                            ),
                          ],
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
    );
  }
}
