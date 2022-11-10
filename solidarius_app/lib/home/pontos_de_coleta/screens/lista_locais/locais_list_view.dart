import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:solidarius_app/model/usuario_api.dart';
import 'package:solidarius_app/home/pontos_de_coleta/models/locais_list_data.dart';
import 'package:flutter/material.dart';
import 'package:solidarius_app/service/base.service.dart';
import 'package:solidarius_app/widgets/local_detalhes.dart';

final UsuarioApi usuarioApi = GetIt.I<UsuarioApi>();

class LocaisListViewController extends ValueNotifier<String> {
  LocaisListViewController() : super("");
  void filtrar(String pesquisa) {
    value = pesquisa;
  }
}

class LocaisListView extends StatefulWidget {
  const LocaisListView(
      {Key? key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      required this.controller})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final LocaisListViewController controller;

  @override
  _LocaisListViewState createState() => _LocaisListViewState();
}

class _LocaisListViewState extends State<LocaisListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  NeverScrollableScrollPhysics? physical = NeverScrollableScrollPhysics();
  var _locaisListData = <LocaisListData>[];
  var locaisListDataFiltrada = <LocaisListData>[];

  @override
  void initState() {
    gerarListaInstituicoes();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animationController!.addListener(() {
      if (animationController!.status == AnimationStatus.completed) {
        physical = null;
        WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
      }
    });

    widget.controller.addListener(() {
      if (widget.controller.value.isEmpty) {
        locaisListDataFiltrada = _locaisListData;
      } else {
        var _pesquisa = widget.controller.value.toLowerCase();
        locaisListDataFiltrada = _locaisListData
            .where((e) => e.nome.toLowerCase().contains(_pesquisa))
            .toList();
      }
      setState(() {});
    });
    super.initState();
  }

  void gerarListaInstituicoes() async {
    var listaInstituicoes = await obterInstituicoesCadastroAprovado(usuarioApi);
    for (var instituicao in listaInstituicoes) {
      _locaisListData.add(LocaisListData(
        foto: instituicao.urlImagem ??
            "http://iseb3.com.br/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png",
        nome: instituicao.nome!,
        cnpj: instituicao.cnpj!,
        email: instituicao.email!,
        telefone: instituicao.telefone1!,
        funcionamento: instituicao.descDisponibilidade!,
        sobreLocal: instituicao.descSobre!,
        fimBeneficente: instituicao.descFinsBeneficentes!,
        apoiadores: instituicao.descApoiadores!,
        observacoes: instituicao.descObservacoes!,
        endereco:
            '${instituicao.logradouro!}, ${instituicao.numero!}${instituicao.complemento! == "" ? "" : ' - ' + instituicao.complemento!} - ${instituicao.bairro!}, ${instituicao.cidade!}-${instituicao.estado!}, ${instituicao.cep!}',
        cep: '${instituicao.cep!}',
        cidade: '${instituicao.cidade!} - ${instituicao.estado!}',
        itens: instituicao.descArrecadacoesAceitas!.split(','),
        latitude: instituicao.latitude!,
        longitude: instituicao.longitude!,
        urlFacebook: instituicao.urlFacebook ?? "",
        urlInstagram: instituicao.urlInstagram ?? "",
        chavePix: instituicao.chavePix ?? "",
        startColor: '#7C2AE8',
        endColor: '#4EC1C1',
      ));
    }
    Future.delayed(Duration.zero, () {
      locaisListDataFiltrada = _locaisListData;
      setState(() {});
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Container(
              // height: MediaQuery.of(context).size.height - 176,
              height: MediaQuery.of(context).size.height * 0.72,
              //176px é para poder exibir o último item da lista
              width: double.infinity,
              child: ListView.builder(
                physics: physical,
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    top: 8, bottom: 16, right: 16, left: 16),
                itemCount: locaisListDataFiltrada.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  final int count = locaisListDataFiltrada.length >= 0
                      ? 10
                      : locaisListDataFiltrada.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController!.forward();

                  return GestureDetector(
                    onLongPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        expand: true,
                        context: context,
                        builder: (context) =>
                            LocalDetalhes(local: locaisListDataFiltrada[index]),
                      );
                    },
                    child: LocaisVerticalView(
                      locaisListData: locaisListDataFiltrada[index],
                      animation: animation,
                      animationController: animationController!,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class LocaisVerticalView extends StatelessWidget {
  const LocaisVerticalView(
      {Key? key, this.locaisListData, this.animationController, this.animation})
      : super(key: key);

  final LocaisListData? locaisListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Container(
                          height: 106,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.grey.withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              splashColor:
                                  AppTheme.nearlyPurple.withOpacity(0.2),
                              onTap: () {
                                showCupertinoModalBottomSheet(
                                  expand: true,
                                  context: context,
                                  builder: (context) =>
                                      LocalDetalhes(local: locaisListData!),
                                );
                              },
                              child: Stack(
                                alignment: Alignment.topLeft,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    child: SizedBox(
                                      height: 106,
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.asset(
                                            "assets/pontos_de_coleta/back.png"),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 13.25,
                                    left: 8,
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppTheme.white,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: AppTheme.grey
                                                  .withOpacity(0.6),
                                              offset: const Offset(2.0, 4.0),
                                              blurRadius: 8),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100)),
                                        child: CachedNetworkImage(
                                          imageUrl: locaisListData!.foto,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: CircularProgressIndicator(
                                                color: AppTheme.nearlyPurple),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.image_not_supported,
                                            color: AppTheme.nearlyPurple,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 100,
                                              right: 16,
                                              top: 16,
                                            ),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  ((1.05 * 198.6) + 1.47),
                                              child: AutoSizeText(
                                                locaisListData!.nome,
                                                maxFontSize: 16,
                                                minFontSize: 14,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  letterSpacing: 0.2,
                                                  color: AppTheme.nearlyPurple,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 100,
                                              bottom: 12,
                                              top: 4,
                                              right: 16,
                                            ),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  ((1.05 * 198.6) + 1.47),
                                              child: Text(
                                                locaisListData!.endereco +
                                                    ", " +
                                                    locaisListData!.cidade +
                                                    ", " +
                                                    locaisListData!.cep,
                                                textAlign: TextAlign.justify,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                // textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  letterSpacing: 0.0,
                                                  color: AppTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
