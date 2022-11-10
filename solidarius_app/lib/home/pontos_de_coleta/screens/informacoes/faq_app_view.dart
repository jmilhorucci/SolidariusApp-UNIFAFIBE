import 'package:accordion/accordion.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqAppView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const FaqAppView({Key? key, this.animationController, this.animation})
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
                    leftIcon: const Icon(Icons.help, color: Colors.white),
                    headerBackgroundColor: AppTheme.nearlyLightPurple,
                    headerBackgroundColorOpened: AppTheme.nearlyPurple,
                    header: Text(
                      'F.A.Qs',
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
                            'Confira abaixo as perguntas frequentes sobre o Solidariu\'s App.',
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
                              leftIcon: const Icon(
                                Icons.help,
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
                                'Quem pode solicitar pontos de coleta?',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                  'Qualquer empresa ou instituição, seja elas grandes ou pequenas, privadas ou públicas, com CNPJ ativo e que atuam na área social, realizando campanhas ou ações solidarias.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.2,
                                  )),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(
                                Icons.help,
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
                                'Qual é o prazo para aprovação da solicitação de ponto de coleta?',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                  'O prazo inicial para analise das informações e aprovação é em até 3 dias úteis. Este período poderá ser extendido se houver algum problema durante o processo de analise.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.2,
                                  )),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(
                                Icons.help,
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
                                'Qual é a necessidade de informar os dados solicitados no formulário de solicitação de ponto de coleta?',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                        'Todas as informações solicitadas no formulário (exceto CNPJ), serão exibidas como detalhes do estabelecimento, sendo possível acessar tocando sobre o card dos destaques, ponto de coleta no mapa (marcadores na cor roxa) e item da lista.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Text('ATENÇÃO',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Text(
                                        'O CNPJ será utilizado somente para controle interno.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(
                                Icons.help,
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
                                'Como preencher os campos de "Latitude" e "Longitude"?',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                        'Os campos de coordenadas "Latitude" e "Longitude" são opcionais, porém caso deseje preenche-los mas não sabe como, recomendamos alguns sites que podem te ajudar a indeitificar sua latitude e longitude através do endereço ou outras plataformas do próprio smartphone. Confira abaixo:',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 4.0),
                                    child: TextButton.icon(
                                      onPressed: () async {
                                        const url =
                                            'http://www.travelaholics.com.br/ferramentas/qual-%C3%A9-a-minha-latitude-e-longitude/';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Não foi possível abrir a url: $url';
                                        }
                                      },
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStatePropertyAll(AppTheme
                                                  .nearlyPurple
                                                  .withOpacity(0.2))),
                                      label: Text(
                                        'Site: travelaholics.com.br',
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                          color: AppTheme.nearlyPurple,
                                        ),
                                      ),
                                      icon: Icon(Icons.link,
                                          color: AppTheme.nearlyPurple),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, bottom: 8.0),
                                    child: TextButton.icon(
                                      onPressed: () async {
                                        const url =
                                            'https://pt.wikihow.com/Descobrir-a-Longitude-e-Latitude-Usando-o-Google-Maps';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Não foi possível abrir a url: $url';
                                        }
                                      },
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStatePropertyAll(AppTheme
                                                  .nearlyPurple
                                                  .withOpacity(0.2))),
                                      label: Text(
                                        'Manual: Descobrir coordenadas com Google Maps',
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                          color: AppTheme.nearlyPurple,
                                        ),
                                      ),
                                      icon: Icon(Icons.link,
                                          color: AppTheme.nearlyPurple),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Text('ATENÇÃO',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Text(
                                        'Estamos trabalhando para que futuramente estes campos sejam preenchidos automaticamente após informar todos os dados referentes ao endereço.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(
                                Icons.help,
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
                                'Quais plataformas o Solidariu\'s App está disponível?',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                  'No momento, o aplicativo está disponível apenas para smartphones com sistema operacional Android, versão 8 ou acima. Estamos trabalhando no projeto para que futuramente haja possibilidade do aplicativo estar disponível também para smartphones com sistema operacional IOS.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.2,
                                  )),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(
                                Icons.help,
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
                                'Em quais regiões o Solidariu\'s App está disponível?',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                  'No momento, o aplicativo está disponível apenas para usuários da cidade de Bebedouro-SP. Estamos trabalhando no projeto para que futuramente haja possibilidade de expansão nas demais regiões.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.2,
                                  )),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(
                                Icons.help,
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
                                'Onde posso reportar problemas técnicos sobre o aplicativo?',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                children: [
                                  Text(
                                      'Para problemas técnicos, orientamos a abrir uma ordem de serviço para o e-mail:',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        letterSpacing: 0.2,
                                      )),
                                  TextButton.icon(
                                    onPressed: () async {
                                      const email = 'solidariusapp@outlook.com';
                                      launch('mailto:$email');
                                    },
                                    style: ButtonStyle(
                                        overlayColor: MaterialStatePropertyAll(
                                            AppTheme.nearlyPurple
                                                .withOpacity(0.2))),
                                    label: Text(
                                      'solidariusapp@outlook.com',
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        letterSpacing: 0.2,
                                        color: AppTheme.nearlyPurple,
                                      ),
                                    ),
                                    icon: Icon(Icons.email,
                                        color: AppTheme.nearlyPurple),
                                  ),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(
                                Icons.help,
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
                                'Como faço para remover o meu estabelecimento do mapa?',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                        'Para que seja possível a remoção do estabelecimento no mapa, orientamos a abrir uma ordem de serviço para o e-mail:',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                  TextButton.icon(
                                    onPressed: () async {
                                      const email = 'solidariusapp@outlook.com';
                                      launch('mailto:$email');
                                    },
                                    style: ButtonStyle(
                                        overlayColor: MaterialStatePropertyAll(
                                            AppTheme.nearlyPurple
                                                .withOpacity(0.2))),
                                    label: Text(
                                      'solidariusapp@outlook.com',
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        letterSpacing: 0.2,
                                        color: AppTheme.nearlyPurple,
                                      ),
                                    ),
                                    icon: Icon(Icons.email,
                                        color: AppTheme.nearlyPurple),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                        'Para facilitar na identificação, informe no corpo do e-mail, os seguintes dados: nome exato do estabelecimento, endereço completo e CNPJ.\n\nO prazo para a remoção é de até 3 dias úteis.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: false,
                              leftIcon: const Icon(
                                Icons.help,
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
                                'Porque os pontos de coleta não aparecem no mapa?',
                                style: TextStyle(
                                    color: AppTheme.nearlyBlack,
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                        'Os pontos de coleta só serão exibidos no mapa se:\n\n- Possuir estabelecimentos cadastrados na cidade em que você se encontra localizado.\n- O estabelecimento for aprovado após solicitação.\n- A localização (GPS) do smartphone estiver habilitada (Recomendamos que a precisão mais forte da localização esteja habilitada. Esta opção pode ser encontrada nas configurações do sistema operacional, porém pode variar de acordo com sua versão).\n- Possuir conexão estável com a internet.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Text('ATENÇÃO',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Text(
                                        'Dependendo da quantidade de pontos de coleta cadastrados e ativos na região, pode ocorrer atrasos na exibição. Isso significa que ao abrir a tela que consta o mapa, será feito a requisição para o banco de dados, e processamento dessas informações.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Text(
                                        'Se o problema de exibição dos pontos de coleta persistir, orientamos a abrir uma ordem de serviço para o e-mail:',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          letterSpacing: 0.2,
                                        )),
                                  ),
                                  TextButton.icon(
                                    onPressed: () async {
                                      const email = 'solidariusapp@outlook.com';
                                      launch('mailto:$email');
                                    },
                                    style: ButtonStyle(
                                        overlayColor: MaterialStatePropertyAll(
                                            AppTheme.nearlyPurple
                                                .withOpacity(0.2))),
                                    label: Text(
                                      'solidariusapp@outlook.com',
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        letterSpacing: 0.2,
                                        color: AppTheme.nearlyPurple,
                                      ),
                                    ),
                                    icon: Icon(Icons.email,
                                        color: AppTheme.nearlyPurple),
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
            ),
          ),
        );
      },
    );
  }
}
