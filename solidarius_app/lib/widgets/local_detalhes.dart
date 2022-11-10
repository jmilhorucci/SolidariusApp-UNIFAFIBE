import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:solidarius_app/home/pontos_de_coleta/models/locais_list_data.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:accordion/accordion.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LocalDetalhes extends StatelessWidget {
  LocaisListData local;
  LocalDetalhes({Key? key, required this.local}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.nearlyPurple,
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sobre a Instituíção',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 0.27,
                        color: AppTheme.nearlyWhite,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  height: 38,
                  width: 38,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                    onTap: () => Navigator.of(context).pop(),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: AppTheme.nearlyWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: ListView(
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CachedNetworkImage(
                  height: 300,
                  width: 300,
                  imageUrl: local.foto,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: AppTheme.dark_grey.withOpacity(0.9),
                            blurRadius: 10.0)
                      ],
                      shape: BoxShape.rectangle,
                      color: AppTheme.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.image_not_supported,
                    color: AppTheme.nearlyPurple,
                    size: 80,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  local.nome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    letterSpacing: 0.2,
                    color: AppTheme.nearlyPurple,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onLongPress: () async {
                    //     Clipboard.setData(
                    //       ClipboardData(text: local.endereco),
                    //     );
                    //   },
                    //   child: Text(
                    //     local.endereco,
                    //     style: TextStyle(
                    //       fontFamily: 'WorkSans',
                    //       fontWeight: FontWeight.normal,
                    //       fontSize: 14,
                    //       letterSpacing: 0.2,
                    //       color: AppTheme.nearlyBlack,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(
                              Icons.location_on,
                              color: AppTheme.nearlyOcean,
                            ),
                          ),
                          Text(
                            'ENDEREÇO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyOcean,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: TextButton(
                        onPressed: () async {
                          Clipboard.setData(
                            ClipboardData(text: local.endereco),
                          );

                          Fluttertoast.showToast(
                            msg: "Endereço copiado!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor:
                                AppTheme.nearlyOcean.withOpacity(0.9),
                            textColor: Colors.white,
                            fontSize: 14,
                          );
                        },
                        style: ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(
                                AppTheme.steps.withOpacity(0.2))),
                        child: Text(
                          local.endereco,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            letterSpacing: 0.2,
                            color: AppTheme.nearlyBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.mail,
                        color: AppTheme.nearlyOcean,
                      ),
                    ),
                    Text(
                      'E-MAIL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyOcean,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
                child: TextButton(
                  onLongPress: () async {
                    Clipboard.setData(
                      ClipboardData(text: local.endereco),
                    );

                    Fluttertoast.showToast(
                      msg: "E-mail copiado!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppTheme.nearlyOcean.withOpacity(0.9),
                      textColor: Colors.white,
                      fontSize: 14,
                    );
                  },
                  onPressed: () {
                    final email = local.email;
                    launch('mailto:$email');
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(
                          AppTheme.nearlyPurple.withOpacity(0.2))),
                  child: Text(
                    local.email,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.2,
                      color: AppTheme.nearlyPurple,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Builder(
                          builder: (context) {
                            final telefone = local.telefone;
                            return ElevatedButton.icon(
                              onLongPress: () async {
                                Clipboard.setData(
                                  ClipboardData(text: telefone),
                                );
                                Fluttertoast.showToast(
                                  msg: "Número do Telefone copiado!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      AppTheme.nearlyOcean.withOpacity(0.9),
                                  textColor: Colors.white,
                                  fontSize: 14,
                                );
                              },
                              onPressed: () {
                                launch('tel://$telefone');
                              },
                              // onPressed: () async {
                              //   FlutterPhoneDirectCaller.callNumber(
                              //       local.telefone);
                              // },
                              style: ButtonStyle(
                                overlayColor: MaterialStatePropertyAll(
                                    AppTheme.nearlyOcean.withOpacity(0.2)),
                                fixedSize:
                                    MaterialStatePropertyAll(Size(100, 60)),
                                backgroundColor: MaterialStatePropertyAll(
                                    AppTheme.nearlyWhite),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side:
                                        BorderSide(color: AppTheme.nearlyOcean),
                                  ),
                                ),
                              ),
                              label: Text(
                                'Ligar',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 0.2,
                                  color: AppTheme.nearlyOcean,
                                ),
                              ),
                              icon: Icon(Icons.phone,
                                  color: AppTheme.nearlyOcean),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Builder(
                          builder: (context) {
                            return ElevatedButton.icon(
                              onPressed: () => openMapsSheet(context),
                              style: ButtonStyle(
                                  fixedSize:
                                      MaterialStatePropertyAll(Size(100, 60)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppTheme.nearlyOcean),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  )),
                              label: Text(
                                'Ver Rota',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 0.2,
                                  color: AppTheme.nearlyWhite,
                                ),
                              ),
                              icon: Icon(Icons.map),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: Accordion(
                  maxOpenSections: 9,
                  disableScrolling: true,
                  headerBackgroundColorOpened: Colors.black54,
                  headerPadding: const EdgeInsets.all(16),
                  children: [
                    //Sobre
                    AccordionSection(
                      isOpen: true,
                      leftIcon:
                          const Icon(Icons.add_comment, color: AppTheme.white),
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
                      content: Text(local.sobreLocal,
                          style: TextStyle(
                              color: AppTheme.nearlyText,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                      contentHorizontalPadding: 20,
                      contentBorderColor: AppTheme.nearlyText,
                    ),
                    //Doações Aceitas
                    AccordionSection(
                      isOpen: true,
                      leftIcon:
                          const Icon(Icons.category, color: AppTheme.white),
                      headerBackgroundColor: AppTheme.nearlyLightPurple,
                      headerBackgroundColorOpened: AppTheme.nearlyPurple,
                      header: Text(
                        'Doações Aceitas',
                        style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(local.itens!.join(' • '),
                          style: TextStyle(
                              color: AppTheme.nearlyText,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                      contentHorizontalPadding: 20,
                      contentBorderColor: AppTheme.nearlyText,
                    ),
                    //Fins Beneficentes
                    AccordionSection(
                      isOpen: true,
                      leftIcon: const Icon(Icons.volunteer_activism,
                          color: AppTheme.white),
                      headerBackgroundColor: AppTheme.nearlyLightPurple,
                      headerBackgroundColorOpened: AppTheme.nearlyPurple,
                      header: Text(
                        'Fins Beneficentes',
                        style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(local.fimBeneficente,
                          style: TextStyle(
                              color: AppTheme.nearlyText,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                      contentHorizontalPadding: 20,
                      contentBorderColor: AppTheme.nearlyText,
                    ),
                    // Dia/Horario de Funcionamento
                    AccordionSection(
                      isOpen: local.funcionamento == '' ? false : true,
                      leftIcon: const Icon(Icons.calendar_month,
                          color: AppTheme.white),
                      headerBackgroundColor: AppTheme.nearlyLightPurple,
                      headerBackgroundColorOpened: AppTheme.nearlyPurple,
                      header: Text(
                        'Dias e Horários',
                        style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            local.funcionamento == ''
                                ? 'Sem informações :('
                                : local.funcionamento,
                            style: TextStyle(
                                color: AppTheme.nearlyText,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      ),
                      contentHorizontalPadding: 20,
                      contentBorderColor: AppTheme.nearlyText,
                    ),
                    //Apoiadores
                    AccordionSection(
                      isOpen: local.apoiadores == '' ? false : true,
                      leftIcon:
                          const Icon(Icons.add_business, color: AppTheme.white),
                      headerBackgroundColor: AppTheme.nearlyLightPurple,
                      headerBackgroundColorOpened: AppTheme.nearlyPurple,
                      header: Text(
                        'Apoiadores',
                        style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                          local.apoiadores == ''
                              ? 'Sem informações :('
                              : local.apoiadores,
                          style: TextStyle(
                              color: AppTheme.nearlyText,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                      contentHorizontalPadding: 20,
                      contentBorderColor: AppTheme.nearlyText,
                    ),
                    AccordionSection(
                      isOpen: local.urlFacebook == '' ? false : true,
                      leftIcon:
                          const Icon(Icons.facebook, color: AppTheme.white),
                      headerBackgroundColor: AppTheme.nearlyLightPurple,
                      headerBackgroundColorOpened: AppTheme.nearlyPurple,
                      header: Text(
                        'Facebook',
                        style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: local.urlFacebook == ''
                          ? Text('Sem informações :(',
                              style: TextStyle(
                                  color: AppTheme.nearlyText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))
                          : Column(
                              children: [
                                TextButton.icon(
                                  onLongPress: () async {
                                    Clipboard.setData(
                                      ClipboardData(text: local.urlFacebook),
                                    );

                                    Fluttertoast.showToast(
                                      msg: "URL do Facebook copiada!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          AppTheme.nearlyOcean.withOpacity(0.9),
                                      textColor: Colors.white,
                                      fontSize: 14,
                                    );
                                  },
                                  onPressed: () async {
                                    final url =
                                        ('https://' + local.urlFacebook);
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Não foi possível abrir a url: $url';
                                    }
                                  },
                                  style: ButtonStyle(
                                      overlayColor: MaterialStatePropertyAll(
                                          AppTheme.nearlyPurple
                                              .withOpacity(0.2))),
                                  label: Text(
                                    local.urlFacebook,
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: const Icon(Icons.info,
                                            color: AppTheme.nearlyLabel),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Text(
                                          'Toque sobre o link para acessa-lo ou pressione para copiá-lo.',
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
                      contentHorizontalPadding: 20,
                      contentBorderColor: AppTheme.nearlyText,
                    ),
                    AccordionSection(
                      isOpen: local.urlInstagram == '' ? false : true,
                      leftIcon: const FaIcon(FontAwesomeIcons.instagramSquare,
                          color: AppTheme.white),
                      headerBackgroundColor: AppTheme.nearlyLightPurple,
                      headerBackgroundColorOpened: AppTheme.nearlyPurple,
                      header: Text(
                        'Instagram',
                        style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: local.urlInstagram == ''
                          ? Text('Sem informações :(',
                              style: TextStyle(
                                  color: AppTheme.nearlyText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))
                          : Column(
                              children: [
                                TextButton.icon(
                                  onLongPress: () async {
                                    Clipboard.setData(
                                      ClipboardData(text: local.urlInstagram),
                                    );

                                    Fluttertoast.showToast(
                                      msg: "URL do Instagram copiada!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          AppTheme.nearlyOcean.withOpacity(0.9),
                                      textColor: Colors.white,
                                      fontSize: 14,
                                    );
                                  },
                                  onPressed: () async {
                                    final url =
                                        ('https://' + local.urlInstagram);
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Não foi possível abrir a url: $url';
                                    }
                                  },
                                  style: ButtonStyle(
                                      overlayColor: MaterialStatePropertyAll(
                                          AppTheme.nearlyPurple
                                              .withOpacity(0.2))),
                                  label: Text(
                                    local.urlInstagram,
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: const Icon(Icons.info,
                                            color: AppTheme.nearlyLabel),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Text(
                                          'Toque sobre o link para acessa-lo ou pressione para copiá-lo.',
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
                      contentHorizontalPadding: 20,
                      contentBorderColor: AppTheme.nearlyText,
                    ),
                    AccordionSection(
                      isOpen: local.chavePix == '' ? false : true,
                      leftIcon: const FaIcon(FontAwesomeIcons.pix,
                          color: AppTheme.white),
                      headerBackgroundColor: AppTheme.nearlyLightPurple,
                      headerBackgroundColorOpened: AppTheme.nearlyPurple,
                      header: Text(
                        'Chave PIX',
                        style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        children: [
                          local.chavePix == ''
                              ? Text('Sem informações :(',
                                  style: TextStyle(
                                      color: AppTheme.nearlyText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal))
                              : Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Text(
                                          'Efetue doações em dinheiro (R\$) para a chave PIX abaixo:',
                                          style: TextStyle(
                                              color: AppTheme.nearlyText,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                    TextButton.icon(
                                      onPressed: () async {
                                        Clipboard.setData(
                                          ClipboardData(text: local.chavePix),
                                        );

                                        Fluttertoast.showToast(
                                          msg: "Chave PIX copiada!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: AppTheme.nearlyOcean
                                              .withOpacity(0.9),
                                          textColor: Colors.white,
                                          fontSize: 14,
                                        );
                                      },
                                      onLongPress: () async {
                                        Clipboard.setData(
                                          ClipboardData(text: local.chavePix),
                                        );

                                        Fluttertoast.showToast(
                                          msg: "Chave PIX copiada!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: AppTheme.nearlyOcean
                                              .withOpacity(0.9),
                                          textColor: Colors.white,
                                          fontSize: 14,
                                        );
                                      },
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStatePropertyAll(AppTheme
                                                  .nearlyPurple
                                                  .withOpacity(0.2))),
                                      label: Text(
                                        local.chavePix,
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                          color: AppTheme.nearlyPurple,
                                        ),
                                      ),
                                      icon: Icon(Icons.copy,
                                          color: AppTheme.nearlyPurple),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: const Icon(Icons.info,
                                                color: AppTheme.nearlyLabel),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Text(
                                              'Toque ou pressione sobre o texto para copiá-lo.',
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
                          // : GestureDetector(
                          //     onLongPress: () {
                          //       Clipboard.setData(
                          //           ClipboardData(text: local.chavePix));
                          //     },
                          //     child: Text(local.chavePix,
                          //         style: TextStyle(
                          //             color: AppTheme.nearlyText,
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.normal)),
                          //   ),
                        ],
                      ),
                      contentHorizontalPadding: 20,
                      contentBorderColor: AppTheme.nearlyText,
                    ),
                    //Observações
                    AccordionSection(
                      isOpen: local.observacoes == '' ? false : true,
                      leftIcon: const Icon(Icons.info, color: AppTheme.white),
                      headerBackgroundColor: AppTheme.nearlyLightPurple,
                      headerBackgroundColorOpened: AppTheme.nearlyPurple,
                      header: Text(
                        'Observações',
                        style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                          local.observacoes == ''
                              ? 'Sem informações :('
                              : local.observacoes,
                          style: TextStyle(
                              color: AppTheme.nearlyText,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                      contentHorizontalPadding: 20,
                      contentBorderColor: AppTheme.nearlyText,
                    ),
                    //Doações Aceitas

                    // AccordionSection(
                    //   isOpen: true,
                    //   leftIcon:
                    //       const Icon(Icons.compare_rounded, color: AppTheme.white),
                    //   header: Text(
                    //     'Nested Section #2',
                    //     style: TextStyle(
                    //         color: Color(0xffffffff),
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    //   headerBackgroundColor: Colors.black38,
                    //   headerBackgroundColorOpened: Colors.black54,
                    //   contentBorderColor: Colors.black54,
                    //   content: Row(
                    //     children: [
                    //       const Icon(Icons.compare_rounded,
                    //           size: 120, color: Colors.orangeAccent),
                    //       Flexible(
                    //           flex: 1,
                    //           child: Text(
                    //               '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''',
                    //               style: TextStyle(
                    //                   color: Color(0xff999999),
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.normal))),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showMarkerWithFirstMap() async {
    final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(local.latitude, local.longitude),
      title: local.nome,
    );
  }

  showDirectionWithFirstMap() async {
    final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showDirections(
      destination: Coords(local.latitude, local.longitude),
    );
  }

  checkAvailableAndShow() async {
    bool isGoogleMaps =
        await MapLauncher.isMapAvailable(MapType.google) ?? false;
    if (isGoogleMaps) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(local.latitude, local.longitude),
        title: local.nome,
        description: local.endereco,
      );
    }
  }

  openMapsSheet(BuildContext context) async {
    try {
      final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        backgroundColor: AppTheme.nearlyOcean,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  for (AvailableMap map in availableMaps)
                    ListTile(
                      onTap: () => map.showDirections(
                        destination: Coords(local.latitude, local.longitude),
                      ),
                      title: Text(
                        map.mapName,
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: AppTheme.nearlyWhite,
                        ),
                      ),
                      leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: AppTheme.grey.withOpacity(0.6),
                                offset: const Offset(2.0, 4.0),
                                blurRadius: 8),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: SvgPicture.asset(
                            map.icon,
                            height: 32.0,
                            width: 32.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
