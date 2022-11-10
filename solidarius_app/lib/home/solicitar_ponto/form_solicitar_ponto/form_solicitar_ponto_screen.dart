import 'dart:io';

import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solidarius_app/home/solicitar_ponto/components/image_picker/select_photo_options_screen.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:solidarius_app/model/instituicao.dart';
import 'package:solidarius_app/model/resposta_api.dart';
import 'package:solidarius_app/model/usuario_api.dart';
import 'package:flutter/material.dart';
import 'package:solidarius_app/widgets/full_loading.dart';
import 'package:validatorless/validatorless.dart';
import 'package:mask/mask.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:search_cep/search_cep.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:quickalert/quickalert.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:geocoding/geocoding.dart';

import '../../../service/base.service.dart' as baseService;

final UsuarioApi usuarioApi = GetIt.I<UsuarioApi>();

class FormSolicitarPontoScreen extends StatefulWidget {
  @override
  _FormSolicitarPontoScreenState createState() =>
      _FormSolicitarPontoScreenState();
}

class DescArrecadacoesAceitas {
  final int? id;
  final String? name;

  DescArrecadacoesAceitas({
    this.id,
    this.name,
  });
}

class _FormSolicitarPontoScreenState extends State<FormSolicitarPontoScreen> {
  final _solicitaPontoFormKey = new GlobalKey<FormState>();
  GlobalKey<FormFieldState> _nomeLocalFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _cnpjFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _emailFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _telefone1FildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _descSobreFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _descFinsBeneficentesFildKey =
      new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _descDisponibilidadeFildKey =
      new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _descArrecadacoesAceitasFildKey =
      new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _descApoiadoresFildKey =
      new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _descObservacoesFildKey =
      new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _cepFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _logradouroFildKey =
      new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _bairroFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _numeroFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _complementoFildKey =
      new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _cidadeFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _estadoFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _latitudeFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _longitudeFildKey = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _linkFacebookFildKey =
      new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _linkInstagramFildKey =
      new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _chavePixFildKey = new GlobalKey<FormFieldState>();

  final _nomeLocalController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefone1Controller = TextEditingController();
  final _descSobreController = TextEditingController();
  final _descFinsBeneficentesController = TextEditingController();
  final _descDisponibilidadeController = TextEditingController();
  final _descArrecadacoesAceitasController = TextEditingController();
  final _descApoiadoresController = TextEditingController();
  final _descObservacoesController = TextEditingController();
  final _cepController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _complementoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _linkFacebookController = TextEditingController();
  final _linkInstagramController = TextEditingController();
  final _chavePixController = TextEditingController();

  //Nome Local
  FocusNode nomeLocalFocusNode = FocusNode();
  bool nomeLocalValidated = true;
  bool nomeLocalHasFocus = false;
  //CNPJ
  FocusNode cnpjFocusNode = FocusNode();
  bool cnpjValidated = true;
  bool cnpjHasFocus = false;
  //E-mail
  FocusNode emailFocusNode = FocusNode();
  bool emailValidated = true;
  bool emailHasFocus = false;
  //Telefone1
  FocusNode telefone1FocusNode = FocusNode();
  bool telefone1Validated = true;
  bool telefone1HasFocus = false;
  //Desc Sobre
  FocusNode descSobreFocusNode = FocusNode();
  bool descSobreValidated = true;
  bool descSobreHasFocus = false;
  //Fins Beneficentes
  FocusNode descFinsBeneficentesFocusNode = FocusNode();
  bool descFinsBeneficentesValidated = true;
  bool descFinsBeneficentesHasFocus = false;
  //Desc Disponibilidade
  FocusNode descDisponibilidadeFocusNode = FocusNode();
  bool descDisponibilidadeValidated = true;
  bool descDisponibilidadeHasFocus = false;
  //Desc Arrecadacoes Aceitas
  bool descArrecadacoesAceitasValidated = true;
  bool descArrecadacoesAceitasHasFocus = false;
  //Desc Apoiadores
  FocusNode descApoiadoresFocusNode = FocusNode();
  bool descApoiadoresValidated = true;
  bool descApoiadoresHasFocus = false;
  //Desc Observacoes
  FocusNode descObservacoesFocusNode = FocusNode();
  bool descObservacoesValidated = true;
  bool descObservacoesHasFocus = false;
  //CEP
  FocusNode cepFocusNode = FocusNode();
  bool cepValidated = true;
  bool cepHasFocus = false;
  //Logradouro
  FocusNode logradouroFocusNode = FocusNode();
  bool logradouroValidated = true;
  bool logradouroHasFocus = false;
  //Bairro
  FocusNode bairroFocusNode = FocusNode();
  bool bairroValidated = true;
  bool bairroHasFocus = false;
  //Numero
  FocusNode numeroFocusNode = FocusNode();
  bool numeroValidated = true;
  bool numeroHasFocus = false;
  //Complemento
  FocusNode complementoFocusNode = FocusNode();
  bool complementoValidated = true;
  bool complementoHasFocus = false;
  //Cidade
  FocusNode cidadeFocusNode = FocusNode();
  bool cidadeValidated = true;
  bool cidadeHasFocus = false;
  //Estado
  FocusNode estadoFocusNode = FocusNode();
  bool estadoValidated = true;
  bool estadoHasFocus = false;
  //Latitude
  FocusNode latitudeFocusNode = FocusNode();
  bool latitudeValidated = true;
  bool latitudeHasFocus = false;
  //Longitude
  FocusNode longitudeFocusNode = FocusNode();
  bool longitudeValidated = true;
  bool longitudeHasFocus = false;
  //Link Facebook
  FocusNode linkFacebookFocusNode = FocusNode();
  bool linkFacebookValidated = true;
  bool linkFacebookHasFocus = false;
  //Link Instagram
  FocusNode linkInstagramFocusNode = FocusNode();
  bool linkInstagramValidated = true;
  bool linkInstagramHasFocus = false;
  //Chave PIX
  FocusNode chavePixFocusNode = FocusNode();
  bool chavePixValidated = true;
  bool chavePixHasFocus = false;

  File? _image;

  String modeloDiaHorarioTexto =
      '\u{203A} Segunda: hh:mm às hh:mm\n\u{203A} Terça: hh:mm às hh:mm\n\u{203A} Quarta: hh:mm às hh:mm\n\u{203A} Quinta: hh:mm às hh:mm\n\u{203A} Sexta: hh:mm às hh:mm\n\u{203A} Sábado: FECHADO\n\u{203A} Domingo: FECHADO\n\n\u{203A} Fecha para almoço: SIM\n\u{203A} Horários de almoço: hh:mm às hh:mm\n\u{203A} Atendimento aos feriados: SIM';

  //Desc Arrecadacoes Aceitas - Lista
  static List<DescArrecadacoesAceitas> _descArrecadacoesAceitas = [
    DescArrecadacoesAceitas(id: 1, name: "Alimentos não pereciveis"),
    DescArrecadacoesAceitas(id: 2, name: "Roupas"),
    DescArrecadacoesAceitas(id: 3, name: "Calçados"),
    DescArrecadacoesAceitas(id: 4, name: "Brinquedos"),
    DescArrecadacoesAceitas(id: 5, name: "Produtos de limpeza"),
    DescArrecadacoesAceitas(id: 6, name: "Produtos de higiene"),
    DescArrecadacoesAceitas(id: 7, name: "Eletrônicos"),
    DescArrecadacoesAceitas(id: 8, name: "Móveis"),
    DescArrecadacoesAceitas(id: 9, name: "Óleo de cozinha usado"),
    DescArrecadacoesAceitas(id: 10, name: "Ração p/ animais"),
    DescArrecadacoesAceitas(id: 11, name: "Livros"),
    DescArrecadacoesAceitas(id: 13, name: "Cabelo"),
    DescArrecadacoesAceitas(id: 14, name: "Tempo (trabalho voluntário)"),
    DescArrecadacoesAceitas(id: 15, name: "Cama, mesa e banho"),
    DescArrecadacoesAceitas(id: 16, name: "Suplemento alimentar"),
    DescArrecadacoesAceitas(
        id: 17, name: "Tampas de garrafas e lacres de latas")
  ];

  final _itemsArrecadacoesAceitas = _descArrecadacoesAceitas
      .map((item) => MultiSelectItem<DescArrecadacoesAceitas>(item, item.name!))
      .toList();
  List<DescArrecadacoesAceitas> _selectedItemsArrecadacoesAceitas = [];

  void _validateCep() async {
    String _bairro;
    String _cidade;
    String _cep;
    String _uf;
    String _endereco;
    final viaCepSearchCep = ViaCepSearchCep();
    _cep = _cepController.text;

    final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: '$_cep');

    // variáveis recebendo os dados em JSON da API
    _bairro = infoCepJSON.fold(
        (l) => l.errorMessage, (data) => data.bairro.toString());
    _endereco = infoCepJSON.fold(
        (l) => l.errorMessage, (data) => data.logradouro.toString());
    _cidade = infoCepJSON.fold(
        (l) => l.errorMessage, (data) => data.localidade.toString());
    _uf = infoCepJSON.fold((l) => l.errorMessage, (data) => data.uf.toString());

    // tratamento de erro - CEP não encontrado
    if (_endereco == "CEP inexistente." ||
        _bairro == "CEP inexistente." ||
        _cidade == "CEP inexistente." ||
        _uf == "CEP inexistente.") {
      if (_endereco == "CEP inexistente.") {
        _logradouroController.text = '';
      } else {
        _logradouroController.text = _endereco;
      }

      if (_bairro == "CEP inexistente.") {
        _bairroController.text = '';
      } else {
        _bairroController.text = _bairro;
      }

      if (_cidade == "CEP inexistente.") {
        _cidadeController.text = '';
      } else {
        _cidadeController.text = _cidade;
      }

      if (_uf == "CEP inexistente.") {
        _estadoController.text = '';
      } else {
        _estadoController.text = _uf;
      }
      FocusScope.of(context).unfocus();
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Ops! CEP não encontrado. Por favor, digite um CEP válido.",
          maxLines: 3,
        ),
      );
      setState(() {
        _cepController.text = '';
        cepValidated = false;
        _cepFildKey.currentState!.validate();
        logradouroValidated = false;
        _logradouroFildKey.currentState!.validate();
        bairroValidated = false;
        _bairroFildKey.currentState!.validate();
        cidadeValidated = false;
        _cidadeFildKey.currentState!.validate();
        estadoValidated = false;
        _estadoFildKey.currentState!.validate();
      });
    } else {
      setState(() {
        _logradouroController.text = _endereco;
        _bairroController.text = _bairro;
        _cidadeController.text = _cidade;
        _estadoController.text = _uf;
        cepValidated = true;
        _cepFildKey.currentState!.validate();
        logradouroValidated = true;
        _logradouroFildKey.currentState!.validate();
        bairroValidated = true;
        _bairroFildKey.currentState!.validate();
        cidadeValidated = true;
        _cidadeFildKey.currentState!.validate();
        estadoValidated = true;
        _estadoFildKey.currentState!.validate();
      });
    }
  }

  // captura a coordenadas de latitude e longitude pelo endereço
  _capturaLatLng() async {
    if (_numeroController.text.isNotEmpty ||
        _bairroController.text.isNotEmpty ||
        _numeroController.text.isNotEmpty ||
        _cidadeController.text.isNotEmpty ||
        _estadoController.text.isNotEmpty ||
        _cepController.text.isNotEmpty) {
      _latitudeController.text = "";
      _longitudeController.text = "";
    }

    String? endereco = _logradouroController.text +
        ", " +
        _numeroController.text +
        ", " +
        _bairroController.text +
        ", " +
        _cidadeController.text +
        " - " +
        _estadoController.text +
        ", " +
        _cepController.text;

    List<Location> locations = await locationFromAddress(endereco);

    setState(() {
      _latitudeController.text = locations.last.latitude.toString();
      _longitudeController.text = locations.last.longitude.toString();
    });
  }

  _setModeloDataHorario() async {
    setState(() {
      if (_descDisponibilidadeController.text == "" ||
          _descDisponibilidadeController.text != modeloDiaHorarioTexto) {
        _descDisponibilidadeController.text = modeloDiaHorarioTexto;
        descDisponibilidadeValidated = true;
        _descDisponibilidadeFildKey.currentState!.validate();
      }
    });
  }

  _removeModeloDataHorario() async {
    setState(() {
      if (_descDisponibilidadeController.text != modeloDiaHorarioTexto) {
        _descDisponibilidadeController.text = "";
        descDisponibilidadeValidated = false;
        _descDisponibilidadeFildKey.currentState!.validate();
      } else if (_descDisponibilidadeController.text == modeloDiaHorarioTexto) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.confirm,
            title: 'Deseja realmente limpar este campo?',
            titleColor: AppTheme.nearlyPurple,
            widget: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Tooltip(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  message:
                      '\nEste modelo foi escolhido para padronização e melhor visualização das informações quando for exibido na tela. Lembrando que as informações devem ser alteradas, mas fique a vontade em preencher este campo como quiser :)\n',
                  textAlign: TextAlign.justify,
                  showDuration: Duration(seconds: 30),
                  triggerMode: TooltipTriggerMode.tap,
                  waitDuration: Duration(seconds: 20),
                  decoration: BoxDecoration(
                      color: AppTheme.nearlyPurple,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 8.0),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Psiu! Antes de confirmar, toque aqui para saber mais sobre o modelo de dia e horários.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      letterSpacing: 0.2,
                      color: AppTheme.nearlyBlack,
                    ),
                  ),
                ),
              ),
            ),
            animType: QuickAlertAnimType.scale,
            confirmBtnTextStyle: TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.white,
            ),
            confirmBtnColor: AppTheme.nearlyPurple,
            cancelBtnTextStyle: TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.nearlyPurple,
            ),
            showCancelBtn: true,
            confirmBtnText: 'SIM',
            onConfirmBtnTap: () {
              setState(() {
                _descDisponibilidadeController.text = "";
                descDisponibilidadeValidated = false;
                _descDisponibilidadeFildKey.currentState!.validate();
                Navigator.pop(context);
              });
            },
            cancelBtnText: 'CANCELAR',
            onCancelBtnTap: () {
              Navigator.pop(context);
              return;
            });
      }
    });
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    // _selectedItemsArrecadacoesAceitas = _descArrecadacoesAceitas;
    super.initState();
    // _nomeLocalController.text = 'TESTE UNIFAFIBE 2';
    // _emailController.text = 'email@mail.com';
    // _cnpjController.text = '81.659.896/0001-17';

    // _telefone1Controller.text = '17 91234 5678';
    // _descSobreController.text =
    //     'Sobre: Mussum Ipsum, cacilds vidis litro abertis. Mé faiz elementum girarzis, nisi eros vermeio.';
    // _descFinsBeneficentesController.text =
    //     'Fins Beneficentes: Mussum Ipsum, cacilds vidis litro abertis. Mé faiz elementum girarzis, nisi eros vermeio.';
    // _descDisponibilidadeController.text =
    //     'SEG: hh:mm às hh:mm\nTER: hh:mm às hh:mm\nQUA: hh:mm às hh:mm\nQUI: hh:mm às hh:mm\nSEX: hh:mm às hh:mm\nSAB: FECHADO\nDOM: FECHADO\n\nFERIADOS: FECHADO';
    // _descApoiadoresController.text = 'Apoiadores: Prefeitura de Bebedouro';
    // _descObservacoesController.text =
    //     'Observação: Mussum Ipsum, cacilds vidis litro abertis. Mé faiz elementum girarzis, nisi eros vermeio.';
    // _cepController.text = '14701050';
    // _logradouroController.text = '';
    // _bairroController.text = '';
    // _numeroController.text = '433';
    // _complementoController.text = 'Prédio';
    // _cidadeController.text = '';
    // _estadoController.text = '';
    // _latitudeController.text = '-20.952636021288875';
    // _longitudeController.text = '-48.48487730315029';
    // _linkFacebookController.text = 'www.facebook.com/UNIFAFIBE';
    // _linkInstagramController.text = 'www.instagram.com/unifafibe';
    // _chavePixController.text =
    //     '00020126360014BR.GOV.BCB.PIX0114+551111111111152040000530398654040.105802BR5905Teste6009Bebedouro62090505TESTE630448E4';
  }

  @override
  void dispose() {
    // _selectedItemsArrecadacoesAceitas = _descArrecadacoesAceitas;
    super.dispose();
    //Nome Local
    _nomeLocalController.dispose();
    nomeLocalFocusNode.dispose();
    //CNPJ
    _cnpjController.dispose();
    cnpjFocusNode.dispose();
    //E-mail
    _emailController.dispose();
    emailFocusNode.dispose();
    //Telefone1
    _telefone1Controller.dispose();
    telefone1FocusNode.dispose();
    //Desc Sobre
    _descSobreController.dispose();
    descSobreFocusNode.dispose();
    //Desc Fins Beneficentes
    _descFinsBeneficentesController.dispose();
    descFinsBeneficentesFocusNode.dispose();
    //Desc Disponibilidade
    _descDisponibilidadeController.dispose();
    descDisponibilidadeFocusNode.dispose();
    //Desc ArrecadacoesAceitas
    _descArrecadacoesAceitasController.dispose();
    //Desc Apoiadores
    _descApoiadoresController.dispose();
    descApoiadoresFocusNode.dispose();
    //Desc Observacoes
    _descObservacoesController.dispose();
    descObservacoesFocusNode.dispose();
    //CEP
    _cepController.dispose();
    cepFocusNode.dispose();
    //Logradouro
    _logradouroController.dispose();
    logradouroFocusNode.dispose();
    //Bairro
    _bairroController.dispose();
    bairroFocusNode.dispose();
    //Numero
    _numeroController.dispose();
    numeroFocusNode.dispose();
    //Complemento
    _complementoController.dispose();
    complementoFocusNode.dispose();
    //Cidade
    _cidadeController.dispose();
    cidadeFocusNode.dispose();
    //Estado
    _estadoController.dispose();
    estadoFocusNode.dispose();
    //Latitude
    _latitudeController.dispose();
    latitudeFocusNode.dispose();
    //Longitude
    _longitudeController.dispose();
    longitudeFocusNode.dispose();
    //Link Facebook
    _linkFacebookController.dispose();
    linkFacebookFocusNode.dispose();
    //Link Instagram
    _linkInstagramController.dispose();
    linkInstagramFocusNode.dispose();
    //Chave PIX
    _chavePixController.dispose();
    chavePixFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          // remove o teclado da tela quando não usado
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              getAppBarUI(),
              Flexible(
                flex: 1,
                child: SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 1.5, //com este height dá overflow
                    child: Form(
                      key: _solicitaPontoFormKey,
                      child: Column(
                        children: <Widget>[
                          // getFormUI(),
                          getAppForm(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   child: getSendForm(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSendForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            child: Padding(
              padding: EdgeInsets.only(bottom: 38 - (38 * 0.6)),
              child: ElevatedButton(
                onPressed: () {
                  validateForm();
                  FocusScope.of(context).unfocus();
                },
                child: const Text('ENVIAR FORMULÁRIO',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.white,
                    )),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.nearlyPurple,
                    fixedSize: Size(MediaQuery.of(context).size.width, 58),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: EdgeInsets.only(bottom: 38 - (38 * 0.6)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                },
                child: const Text('CANCELAR',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    )),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.notWhite,
                    fixedSize: Size(MediaQuery.of(context).size.width, 58),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void moveTo() {
  //   Navigator.push<dynamic>(
  //     context,
  //     MaterialPageRoute<dynamic>(
  //       builder: (BuildContext context) => CourseInfoScreen(),
  //     ),
  //   );
  // }

  Widget getAppForm() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30, left: 16.0, right: 16.0),
          child: SizedBox(
            child: Column(
              // shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Center(
                    child: new GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (context) => DraggableScrollableSheet(
                            initialChildSize: 0.28,
                            maxChildSize: 0.4,
                            minChildSize: 0.28,
                            expand: false,
                            builder: (context, scrollController) {
                              return SingleChildScrollView(
                                controller: scrollController,
                                child: SelectPhotoOptionsScreen(
                                  onTap: _pickImage,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: DottedBorder(
                        borderType: BorderType.Circle,
                        dashPattern: [10, 10],
                        strokeCap: StrokeCap.round,
                        strokeWidth: 2,
                        color: AppTheme.nearlyPurple,
                        child: Container(
                          height: 150.0,
                          width: 150.0,
                          child: Center(
                            child: _image == null
                                ? CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/pontos_de_coleta/upload-image.png"),
                                    radius: 100.0,
                                    backgroundColor: AppTheme.nearlyWhite,
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(_image!),
                                    radius: 150.0,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.0),
                  child: Center(
                    child: Text(
                      'Selecione uma imagem',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Center(
                    child: Tooltip(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      message:
                          '\nPor questões de privacidade e segurança, serão aceitos somente solicitações contendo uma imagem referente ao estabelecimento, como por exemplo:\n\n• Identidade visual (logotipo)\n• Faixada\n',
                      showDuration: Duration(seconds: 30),
                      triggerMode: TooltipTriggerMode.tap,
                      waitDuration: Duration(seconds: 20),
                      decoration: BoxDecoration(
                          color: AppTheme.nearlyPurple,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Toque aqui para ver os requisitos da imagem',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          letterSpacing: 0.2,
                          color: AppTheme.nearlyPurple,
                        ),
                      ),
                    ),
                  ),
                ),

                //Nome do Local
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _nomeLocalFildKey,
                    focusNode: nomeLocalFocusNode,
                    controller: _nomeLocalController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 100,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !nomeLocalValidated
                          ? const Icon(Icons.home_work,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.home_work,
                              color: AppTheme.nearlyPurple),

                      focusColor: AppTheme.nearlyOcean,
                      // iconColor: AppTheme.nearlyPurple,
                      // prefixIconColor: AppTheme.nearlyPurple,
                      labelText: 'Nome do Local *',
                      hintText: 'Ex: Casa de Santa Clara',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                      ),
                      labelStyle: !nomeLocalValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !nomeLocalValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _nomeLocalController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _nomeLocalController.text = "";
                                      nomeLocalValidated = false;
                                      _nomeLocalFildKey.currentState!
                                          .validate();
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.required(
                        'Nome do Local obrigatório (*).'),
                    onChanged: (value) {
                      final isNotValidNomeLocal =
                          _nomeLocalFildKey.currentState!.validate();
                      if (value.isNotEmpty && isNotValidNomeLocal == true) {
                        setState(() {
                          nomeLocalValidated = true;
                          _nomeLocalFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          nomeLocalValidated = false;
                          _nomeLocalFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                //CNPJ
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _cnpjFildKey,
                    focusNode: cnpjFocusNode,
                    controller: _cnpjController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLength: 18,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    inputFormatters: [Mask.cnpj()],
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !cnpjValidated
                          ? const Icon(Icons.manage_search,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.manage_search,
                              color: AppTheme.nearlyPurple),

                      focusColor: AppTheme.nearlyOcean,
                      // iconColor: AppTheme.nearlyPurple,
                      // prefixIconColor: AppTheme.nearlyPurple,
                      labelText: 'CNPJ *',
                      labelStyle: !cnpjValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !cnpjValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _cnpjController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _cnpjController.text = "";
                                      cnpjValidated = false;
                                      _cnpjFildKey.currentState!.validate();
                                      FocusScope.of(context).unfocus();
                                      Future.delayed(
                                        Duration.zero,
                                        () {
                                          FocusScope.of(context)
                                              .requestFocus(cnpjFocusNode);
                                        },
                                      );
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.cnpj('CNPJ inválido.'),
                      Validatorless.required('CNPJ obrigatório (*).'),
                    ]),
                    onChanged: (value) {
                      final isNotValidCnpj =
                          _cnpjFildKey.currentState!.validate();
                      if (value.isNotEmpty && isNotValidCnpj == true) {
                        setState(() {
                          cnpjValidated = true;
                          _cnpjFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          cnpjValidated = false;
                          _cnpjFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                //E-mail
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _emailFildKey,
                    focusNode: emailFocusNode,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    maxLength: 100,
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !emailValidated
                          ? const Icon(Icons.email, color: AppTheme.nearlyError)
                          : const Icon(Icons.email,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: email@outlook.com',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                      ),
                      labelText: 'E-mail *',
                      labelStyle: !emailValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !emailValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _emailController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _emailController.text = "";
                                      emailValidated = false;
                                      _emailFildKey.currentState!.validate();
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.email('E-mail inválido.'),
                      Validatorless.required('E-mail obrigatório (*).'),
                    ]),
                    onChanged: (value) {
                      final isNotValidEmail =
                          _emailFildKey.currentState!.validate();
                      if (value.isNotEmpty && isNotValidEmail == true) {
                        setState(() {
                          emailValidated = true;
                          _emailFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          emailValidated = false;
                          _emailFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                //Telefone 1
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _telefone1FildKey,
                    focusNode: telefone1FocusNode,
                    controller: _telefone1Controller,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLength: 13,
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    inputFormatters: [
                      Mask.generic(
                        masks: ['## #### ####', '## ##### ####'],
                        hashtag: Hashtag.numbers, // optional field
                      ),
                    ],
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !telefone1Validated
                          ? const Icon(Icons.phone, color: AppTheme.nearlyError)
                          : const Icon(Icons.phone,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'DDD + Número',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                      ),
                      labelText: 'Telefone/Celular *',
                      labelStyle: !telefone1Validated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !telefone1Validated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _telefone1Controller.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _telefone1Controller.text = "";
                                      telefone1Validated = false;
                                      _telefone1FildKey.currentState!
                                          .validate();

                                      FocusScope.of(context).unfocus();
                                      Future.delayed(
                                        Duration.zero,
                                        () {
                                          FocusScope.of(context)
                                              .requestFocus(telefone1FocusNode);
                                        },
                                      );
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.min(
                          12, 'Número de Telefone/Celular incompleto.'),
                      Validatorless.required(
                          'Telefone/Celular obrigatório (*).'),
                    ]),
                    onChanged: (value) {
                      final isNotValidTelefone1 =
                          _telefone1FildKey.currentState!.validate();
                      if (value.isNotEmpty && isNotValidTelefone1 == true) {
                        setState(() {
                          telefone1Validated = true;
                          _telefone1FildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          telefone1Validated = false;
                          _telefone1FildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Desc Sobre
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _descSobreFildKey,
                    focusNode: descSobreFocusNode,
                    controller: _descSobreController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 1000,
                    maxLines: 3,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !descSobreValidated
                          ? const Icon(Icons.add_comment,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.add_comment,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: Somos uma Instituição...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Sobre o Local *',
                      labelStyle: !descSobreValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !descSobreValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _descSobreController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _descSobreController.text = "";
                                      descSobreValidated = false;
                                      _descSobreFildKey.currentState!
                                          .validate();
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.max(
                          1000, 'Você atingiu o limite de caracteres.'),
                      Validatorless.min(30, 'Precisamos de mais informações.'),
                      Validatorless.required('Sobre o Local obrigatório (*).'),
                    ]),
                    onChanged: (value) {
                      final isNotValidDescSobre =
                          _descSobreFildKey.currentState!.validate();
                      if (value.isNotEmpty && isNotValidDescSobre == true) {
                        setState(() {
                          descSobreValidated = true;
                          _descSobreFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          descSobreValidated = false;
                          _descSobreFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Desc Fins Beneficentes
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _descFinsBeneficentesFildKey,
                    focusNode: descFinsBeneficentesFocusNode,
                    controller: _descFinsBeneficentesController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 1000,
                    maxLines: 3,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !descFinsBeneficentesValidated
                          ? const Icon(Icons.volunteer_activism,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.volunteer_activism,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: Em prol do hospital...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Fins Beneficentes *',
                      labelStyle: !descFinsBeneficentesValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !descFinsBeneficentesValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _descFinsBeneficentesController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _descFinsBeneficentesController.text = "";
                                      descFinsBeneficentesValidated = false;
                                      _descFinsBeneficentesFildKey.currentState!
                                          .validate();
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.max(
                          1000, 'Você atingiu o limite de caracteres.'),
                      Validatorless.min(
                          30, 'Precisamos de mais informações (*).'),
                      Validatorless.required('Fins Beneficentes obrigatório.'),
                    ]),
                    onChanged: (value) {
                      final isNotValidDescFinsBeneficentes =
                          _descFinsBeneficentesFildKey.currentState!.validate();
                      if (value.isNotEmpty &&
                          isNotValidDescFinsBeneficentes == true) {
                        setState(() {
                          descFinsBeneficentesValidated = true;
                          _descFinsBeneficentesFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          descFinsBeneficentesValidated = false;
                          _descFinsBeneficentesFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Desc Disponibilidade
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _descDisponibilidadeFildKey,
                    focusNode: descDisponibilidadeFocusNode,
                    controller: _descDisponibilidadeController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 300,
                    maxLines: 6,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !descDisponibilidadeValidated
                          ? const Icon(Icons.calendar_month,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.calendar_month,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: Segunda: 8:00 às 12:00...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Funcionamento (DD/HH) *',
                      labelStyle: !descDisponibilidadeValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !descDisponibilidadeValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _descDisponibilidadeController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _removeModeloDataHorario();
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.max(
                          300, 'Você atingiu o limite de caracteres.'),
                      Validatorless.min(15, 'Precisamos de mais informações.'),
                      Validatorless.required(
                          'Disponibilidade obrigatório (*).'),
                    ]),
                    // onTap: () {
                    //   if (_descDisponibilidadeController.text == "") {
                    //     _descDisponibilidadeController.text =
                    //         'SEG: hh:mm às hh:mm\nTER: hh:mm às hh:mm\nQUA: hh:mm às hh:mm\nQUI: hh:mm às hh:mm\nSEX: hh:mm às hh:mm\nSAB: FECHADO\nDOM: FECHADO\n\nFERIADOS: FECHADO';
                    //   }
                    // },
                    onChanged: (value) {
                      final isNotValidDescDisponibilidade =
                          _descDisponibilidadeFildKey.currentState!.validate();
                      if (value.isNotEmpty &&
                          isNotValidDescDisponibilidade == true) {
                        setState(() {
                          descDisponibilidadeValidated = true;
                          _descDisponibilidadeFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          descDisponibilidadeValidated = false;
                          _descDisponibilidadeFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                _descDisponibilidadeController.text == "" ||
                        _descDisponibilidadeController.text !=
                            modeloDiaHorarioTexto
                    ? Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16.0,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: const Icon(Icons.info,
                                  color: AppTheme.nearlyLabel),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Toque o botão abaixo para utilizar o nosso modelo de dias e horários para facilitar no preenchimento deste campo, ou informe os dados como preferir.',
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
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16.0,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: const Icon(Icons.info,
                                  color: AppTheme.nearlyLabel),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Hey, não esqueça de alterar o modelo com as informações do estabelecimento, OK?',
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
                _descDisponibilidadeController.text == "" ||
                        _descDisponibilidadeController.text !=
                            modeloDiaHorarioTexto
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              child: ElevatedButton(
                                onPressed: () {
                                  _setModeloDataHorario();
                                  FocusScope.of(context).unfocus();
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.calendar_month,
                                          color: AppTheme.white),
                                    ),
                                    Text('APLICAR MODELO DE DIA E HORÁRIO',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.white,
                                        )),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.nearlyOcean,
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width, 38),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),

                // Desc Arrecadacoes Aceitas
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: MultiSelectDialogField(
                    key: _descArrecadacoesAceitasFildKey,
                    items: _itemsArrecadacoesAceitas,
                    separateSelectedItems: false,
                    confirmText: Text(
                      'ADICIONAR',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppTheme.nearlyPurple,
                      ),
                    ),
                    cancelText: Text(
                      'CANCELAR',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppTheme.nearlyLabel,
                      ),
                    ),
                    chipDisplay: MultiSelectChipDisplay(
                      scroll: true,
                      scrollBar: HorizontalScrollBar(isAlwaysShown: true),
                      textStyle: TextStyle(
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppTheme.nearlyPurple,
                      ),
                      onTap: (item) {
                        setState(() {
                          _selectedItemsArrecadacoesAceitas.remove(item);
                        });
                        _descArrecadacoesAceitasFildKey.currentState
                            ?.validate();
                      },
                    ),
                    searchable: true,
                    searchHint: 'Pesquisar',
                    searchHintStyle: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyLabel,
                    ),
                    title: Text("Arrecadações Aceitas",
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.nearlyPurple,
                        )),
                    selectedColor: AppTheme.nearlyPurple,
                    selectedItemsTextStyle: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyLabel,
                    ),
                    itemsTextStyle: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyOcean,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: !descArrecadacoesAceitasValidated
                            ? AppTheme.nearlyError
                            : AppTheme.steps,
                        width: 1,
                      ),
                    ),
                    buttonIcon: !descArrecadacoesAceitasValidated
                        ? Icon(Icons.arrow_drop_down,
                            size: 35, color: AppTheme.nearlyError)
                        : Icon(Icons.arrow_drop_down,
                            size: 35, color: AppTheme.nearlyPurple),
                    buttonText: Text(
                      "Arrecadações Aceitas *",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: !descArrecadacoesAceitasValidated
                            ? AppTheme.nearlyError
                            : AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    onConfirm: (results) {
                      final isNotValidDescArrecadacoesAceitas =
                          _descArrecadacoesAceitasFildKey.currentState!
                              .validate();
                      if (results.isNotEmpty &&
                          isNotValidDescArrecadacoesAceitas == true) {
                        setState(() {
                          descArrecadacoesAceitasValidated = true;
                          _descArrecadacoesAceitasFildKey.currentState!
                              .validate();
                        });
                      } else {
                        setState(() {
                          descArrecadacoesAceitasValidated = false;
                          _descArrecadacoesAceitasFildKey.currentState!
                              .validate();
                        });
                      }
                      _selectedItemsArrecadacoesAceitas.clear();
                      results
                          .map((e) => _selectedItemsArrecadacoesAceitas
                              .add(e as DescArrecadacoesAceitas))
                          .cast<DescArrecadacoesAceitas>()
                          .toString();
                    },
                    // initialValue: _selectedItemsArrecadacoesAceitas,
                    // onSelectionChanged: (value) {},
                    validator: (values) {
                      if (values == null || values.isEmpty) {
                        return "  Arrecadações Aceitas obrigatório (*).";
                      }
                      return null;
                    },
                  ),
                ),
                // Desc Apoiadores
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _descApoiadoresFildKey,
                    focusNode: descApoiadoresFocusNode,
                    controller: _descApoiadoresController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLength: 500,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 3,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !descApoiadoresValidated
                          ? const Icon(Icons.add_business,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.add_business,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: Prefeitura de Bebedouro',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Apoiadores',
                      labelStyle: !descApoiadoresValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !descApoiadoresValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _descApoiadoresController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _descApoiadoresController.text = "";
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.max(
                        500, 'Você atingiu o limite de caracteres.'),
                    onChanged: (value) {
                      final isNotValidDescApoiadores =
                          _descApoiadoresFildKey.currentState!.validate();
                      if (value.length <= 200 &&
                          isNotValidDescApoiadores == true) {
                        setState(() {
                          descApoiadoresValidated = true;
                          _descApoiadoresFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          descApoiadoresValidated = false;
                          _descApoiadoresFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Desc Observações
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _descObservacoesFildKey,
                    focusNode: descObservacoesFocusNode,
                    controller: _descObservacoesController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    textCapitalization: TextCapitalization.sentences,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 1000,
                    maxLines: 3,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !descObservacoesValidated
                          ? const Icon(Icons.info, color: AppTheme.nearlyError)
                          : const Icon(Icons.info,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Informe mais destalhes',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Observações',
                      labelStyle: !descObservacoesValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !descObservacoesValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _descObservacoesController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _descObservacoesController.text = "";
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.max(
                        1000, 'Você atingiu o limite de caracteres.'),
                    onChanged: (value) {
                      final isNotValidDescObservacoes =
                          _descObservacoesFildKey.currentState!.validate();
                      if (value.length <= 1000 &&
                          isNotValidDescObservacoes == true) {
                        setState(() {
                          descObservacoesValidated = true;
                          _descObservacoesFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          descObservacoesValidated = false;
                          _descObservacoesFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // CEP
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _cepFildKey,
                    focusNode: cepFocusNode,
                    controller: _cepController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 8,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    inputFormatters: [
                      Mask.generic(
                        masks: ['########'],
                        hashtag: Hashtag.numbers, // optional field
                      ),
                    ],
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !cepValidated
                          ? const Icon(Icons.search,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.search,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Informe seu CEP',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'CEP *',
                      labelStyle: !cepValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !cepValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _cepController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _cepController.text = "";
                                      cepValidated = false;
                                      _cepFildKey.currentState!.validate();

                                      FocusScope.of(context).unfocus();
                                      Future.delayed(
                                        Duration.zero,
                                        () {
                                          FocusScope.of(context)
                                              .requestFocus(cepFocusNode);
                                        },
                                      );
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.max(
                          8, 'Você atingiu o limite de caracteres.'),
                      Validatorless.min(8, 'CEP incompleto.'),
                      Validatorless.required('CEP obrigatório (*).'),
                    ]),
                    onChanged: (_cepController) {
                      final isNotValidCep =
                          _cepFildKey.currentState!.validate();
                      if (_cepController.length >= 8 && isNotValidCep == true) {
                        _validateCep();
                        setState(() {
                          cepValidated = true;
                          _cepFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          cepValidated = false;
                          _cepFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Rua / Logradouro
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _logradouroFildKey,
                    focusNode: logradouroFocusNode,
                    controller: _logradouroController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 150,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !logradouroValidated
                          ? const Icon(Icons.location_on,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.location_on,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: Rua São João...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Logradouro *',
                      labelStyle: !logradouroValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !logradouroValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _logradouroController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _logradouroController.text = "";
                                      logradouroValidated = false;
                                      _logradouroFildKey.currentState!
                                          .validate();
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.max(
                          100, 'Você atingiu o limite de caracteres.'),
                      Validatorless.required('Logradouro obrigatório (*).'),
                    ]),
                    onChanged: (value) {
                      final isNotValidLogradouro =
                          _logradouroFildKey.currentState!.validate();
                      if (value.isNotEmpty && isNotValidLogradouro == true) {
                        setState(() {
                          logradouroValidated = true;
                          _logradouroFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          logradouroValidated = false;
                          _logradouroFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Bairro
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _bairroFildKey,
                    focusNode: bairroFocusNode,
                    controller: _bairroController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 150,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !bairroValidated
                          ? const Icon(Icons.grid_view_sharp,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.grid_view_sharp,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: Centro...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Bairro *',
                      labelStyle: !bairroValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !bairroValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _bairroController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _bairroController.text = "";
                                      bairroValidated = false;
                                      _bairroFildKey.currentState!.validate();
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.max(
                          100, 'Você atingiu o limite de caracteres.'),
                      Validatorless.required('Bairro obrigatório (*).'),
                    ]),
                    onChanged: (value) {
                      final isNotValidBairro =
                          _bairroFildKey.currentState!.validate();
                      if (value.isNotEmpty && isNotValidBairro == true) {
                        setState(() {
                          bairroValidated = true;
                          _bairroFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          bairroValidated = false;
                          _bairroFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Numero
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _numeroFildKey,
                    focusNode: numeroFocusNode,
                    controller: _numeroController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 10,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    inputFormatters: [
                      Mask.generic(
                        masks: ['##########'],
                        hashtag: Hashtag.numbers, // optional field
                      ),
                    ],
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !numeroValidated
                          ? const Icon(Icons.looks_one,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.looks_one,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Informe o nº da residência',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Número *',
                      labelStyle: !numeroValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !numeroValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _numeroController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _numeroController.text = "";
                                      numeroValidated = false;
                                      _numeroFildKey.currentState!.validate();

                                      FocusScope.of(context).unfocus();
                                      Future.delayed(
                                        Duration.zero,
                                        () {
                                          FocusScope.of(context)
                                              .requestFocus(numeroFocusNode);
                                        },
                                      );
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.max(
                          10, 'Você atingiu o limite de caracteres.'),
                      Validatorless.number('Somente números'),
                      Validatorless.required('Número obrigatório (*).'),
                    ]),
                    onChanged: (value) {
                      final isNotValidNumero =
                          _numeroFildKey.currentState!.validate();
                      if (value.length <= 10 && isNotValidNumero == true) {
                        setState(() {
                          numeroValidated = true;
                          _numeroFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          numeroValidated = false;
                          _numeroFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Complemento
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _complementoFildKey,
                    focusNode: complementoFocusNode,
                    controller: _complementoController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 50,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !complementoValidated
                          ? const Icon(Icons.add_circle,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.add_circle,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: Casa',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Complemento',
                      labelStyle: !complementoValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !complementoValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _complementoController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _complementoController.text = "";
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.max(
                        50, 'Você atingiu o limite de caracteres.'),
                    onChanged: (value) {
                      final isNotValidComplemento =
                          _complementoFildKey.currentState!.validate();
                      if (value.length <= 50 && isNotValidComplemento == true) {
                        setState(() {
                          complementoValidated = true;
                          _complementoFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          complementoValidated = false;
                          _complementoFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Cidade
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _cidadeFildKey,
                    focusNode: cidadeFocusNode,
                    controller: _cidadeController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 150,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !cidadeValidated
                          ? const Icon(Icons.location_city,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.location_city,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: Bebedouro',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Cidade *',
                      labelStyle: !cidadeValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !cidadeValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _cidadeController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _cidadeController.text = "";
                                      cidadeValidated = false;
                                      _cidadeFildKey.currentState!.validate();
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.max(
                          150, 'Você atingiu o limite de caracteres.'),
                      Validatorless.required('Cidade obrigatório (*).'),
                    ]),
                    onChanged: (value) {
                      final isNotValidCidade =
                          _cidadeFildKey.currentState!.validate();
                      if (value.isNotEmpty && isNotValidCidade == true) {
                        setState(() {
                          cidadeValidated = true;
                          _cidadeFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          cidadeValidated = false;
                          _cidadeFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Estado (UF)
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _estadoFildKey,
                    focusNode: estadoFocusNode,
                    controller: _estadoController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 2,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      Mask.generic(
                        masks: ['##'],
                        hashtag: Hashtag.letters,
                      ),
                    ],
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !estadoValidated
                          ? const Icon(Icons.travel_explore,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.travel_explore,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: SP',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Estado (UF) *',
                      labelStyle: !estadoValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !estadoValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _estadoController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _estadoController.text = "";
                                      estadoValidated = false;
                                      _estadoFildKey.currentState!.validate();
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.min(2, 'UF incompleto.'),
                      Validatorless.max(
                          2, 'Você atingiu o limite de caracteres.'),
                      Validatorless.required('Estado (UF) obrigatório (*).'),
                    ]),
                    onChanged: (value) {
                      final isNotValidEstado =
                          _estadoFildKey.currentState!.validate();

                      if (value.isNotEmpty &&
                          isNotValidEstado == true &&
                          value.length == 2) {
                        setState(() {
                          estadoValidated = true;
                          _estadoFildKey.currentState!.validate();
                        });
                      } else if (value.length > 2) {
                        _estadoController.text = '';
                        setState(() {
                          estadoValidated = false;
                          _estadoFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          estadoValidated = false;
                        });
                      }
                    },
                  ),
                ),
                // Latitude
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _latitudeFildKey,
                    focusNode: latitudeFocusNode,
                    controller: _latitudeController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 20,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[\d+\-\.]')),
                    ],
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !latitudeValidated
                          ? const Icon(Icons.panorama_horizontal_select,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.panorama_horizontal_select,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: 32.1501692',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Latitude',
                      labelStyle: !latitudeValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !latitudeValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _latitudeController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _latitudeController.text = "";
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.max(
                          20, 'Você atingiu o limite de caracteres.'),
                      Validatorless.min(2, 'Minímo 2 caracteres'),
                      Validatorless.number('Somente números')
                    ]),
                    onChanged: (value) {
                      final isNotValidLatitude =
                          _latitudeFildKey.currentState!.validate();
                      if (value.length <= 20 && isNotValidLatitude == true) {
                        setState(() {
                          latitudeValidated = true;
                          _latitudeFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          latitudeValidated = false;
                          _latitudeFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Longitude
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _longitudeFildKey,
                    focusNode: longitudeFocusNode,
                    controller: _longitudeController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 20,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[\d+\-\.]')),
                    ],
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !longitudeValidated
                          ? const Icon(Icons.panorama_vertical_select,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.panorama_vertical_select,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: -110.8377076',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Longitude',
                      labelStyle: !longitudeValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !longitudeValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _longitudeController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _longitudeController.text = "";
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.max(
                          20, 'Você atingiu o limite de caracteres.'),
                      Validatorless.min(2, 'Minímo 2 caracteres'),
                      Validatorless.number('Somente números')
                    ]),
                    onChanged: (value) {
                      final isNotValidLongitude =
                          _longitudeFildKey.currentState!.validate();
                      if (value.length <= 20 && isNotValidLongitude == true) {
                        setState(() {
                          longitudeValidated = true;
                          _longitudeFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          longitudeValidated = false;
                          _longitudeFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                _logradouroController.text.isNotEmpty ||
                        _bairroController.text.isNotEmpty ||
                        _numeroController.text.isNotEmpty ||
                        _cidadeController.text.isNotEmpty ||
                        _estadoController.text.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              child: ElevatedButton(
                                onPressed: () {
                                  _capturaLatLng();
                                  FocusScope.of(context).unfocus();
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.location_searching,
                                          color: AppTheme.white),
                                    ),
                                    Text('CAPTURAR COORDENADAS',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.white,
                                        )),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.nearlyOcean,
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width, 38),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16.0,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: const Icon(Icons.info,
                                  color: AppTheme.nearlyLabel),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Preencha todos os campos referentes ao endereço para poder capturar as coordenadas (latitude e longitude) do local.',
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
                // Link Facebook
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _linkFacebookFildKey,
                    focusNode: linkFacebookFocusNode,
                    controller: _linkFacebookController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 100,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !linkFacebookValidated
                          ? const Icon(Icons.facebook,
                              color: AppTheme.nearlyError)
                          : const Icon(Icons.facebook,
                              color: AppTheme.nearlyPurple),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: www.facebook.com/nomedoperfil',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Link de Perfil do Facebook',
                      labelStyle: !linkFacebookValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !linkFacebookValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _linkFacebookController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _linkFacebookController.text = "";
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.min(17, 'Minímo 17 caracteres'),
                    ]),
                    onChanged: (value) {
                      final isNotValidLinkFacebook =
                          _linkFacebookFildKey.currentState!.validate();
                      if (isNotValidLinkFacebook == true) {
                        setState(() {
                          linkFacebookValidated = true;
                          _linkFacebookFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          linkFacebookValidated = false;
                          _linkFacebookFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Link Instagram
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _linkInstagramFildKey,
                    focusNode: linkInstagramFocusNode,
                    controller: _linkInstagramController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 100,
                    maxLines: 1,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !linkInstagramValidated
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: const FaIcon(
                                  FontAwesomeIcons.instagramSquare,
                                  color: AppTheme.nearlyError),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: const FaIcon(
                                  FontAwesomeIcons.instagramSquare,
                                  color: AppTheme.nearlyPurple),
                            ),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Ex: www.instagram.com/nomedoperfil',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Link de Perfil do Instagram',
                      labelStyle: !linkInstagramValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !linkInstagramValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _linkInstagramController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _linkInstagramController.text = "";
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.min(17, 'Minímo 17 caracteres'),
                    ]),
                    onChanged: (value) {
                      final isNotValidLinkInstagram =
                          _linkInstagramFildKey.currentState!.validate();
                      if (isNotValidLinkInstagram == true) {
                        setState(() {
                          linkInstagramValidated = true;
                          _linkInstagramFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          linkInstagramValidated = false;
                          _linkInstagramFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                // Chave Pix
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    key: _chavePixFildKey,
                    focusNode: chavePixFocusNode,
                    controller: _chavePixController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 1000,
                    maxLines: 8,
                    minLines: 1,
                    cursorColor: AppTheme.nearlyOcean,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.nearlyPurple,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppTheme.steps),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 1, color: AppTheme.nearlyPurple),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 2, color: AppTheme.nearlyError),
                      ),
                      errorStyle: TextStyle(
                        color: AppTheme.nearlyError,
                        fontSize: 13,
                      ),
                      counterStyle: TextStyle(
                        color: AppTheme.nearlyPurple,
                      ),
                      prefixIcon: !chavePixValidated
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: const FaIcon(FontAwesomeIcons.pix,
                                  color: AppTheme.nearlyError),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: const FaIcon(FontAwesomeIcons.pix,
                                  color: AppTheme.nearlyPurple),
                            ),
                      focusColor: AppTheme.nearlyOcean,
                      hintText: 'Para doações em R\$',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: AppTheme.nearlyLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelText: 'Chave PIX',
                      labelStyle: !chavePixValidated
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyError,
                            )
                          : const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.nearlyLabel,
                            ),
                      suffixIcon: !chavePixValidated
                          ? const Icon(Icons.error_outline_rounded,
                              color: AppTheme.nearlyError)
                          : _chavePixController.text != ""
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _chavePixController.text = "";
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: AppTheme.nearlyLabel),
                                )
                              : SizedBox(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.min(10, 'Minímo 10 caracteres'),
                    ]),
                    onChanged: (value) {
                      final isNotValidChavePix =
                          _chavePixFildKey.currentState!.validate();
                      if (isNotValidChavePix == true) {
                        setState(() {
                          chavePixValidated = true;
                          _chavePixFildKey.currentState!.validate();
                        });
                      } else {
                        setState(() {
                          chavePixValidated = false;
                          _chavePixFildKey.currentState!.validate();
                        });
                      }
                    },
                  ),
                ),
                getSendForm(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // validação dos campos do formulário
  validateForm() async {
    final isValidForm = _solicitaPontoFormKey.currentState!.validate();
    final isValidNomeLocal = _nomeLocalFildKey.currentState!.validate();
    final isValidCnpj = _cnpjFildKey.currentState!.validate();
    final isValidEmail = _emailFildKey.currentState!.validate();
    final isValidTelefone1 = _telefone1FildKey.currentState!.validate();
    final isValidDescSobre = _descSobreFildKey.currentState!.validate();
    final isValidDescFinsBeneficentes =
        _descFinsBeneficentesFildKey.currentState!.validate();
    final isValidDescDisponibilidade =
        _descDisponibilidadeFildKey.currentState!.validate();
    final isValidDescArrecadacoesAceitas =
        _descArrecadacoesAceitasFildKey.currentState!.validate();
    final isValidDescApoiadores =
        _descApoiadoresFildKey.currentState!.validate();
    final isValidDescObservacoes =
        _descObservacoesFildKey.currentState!.validate();
    final isValidCep = _cepFildKey.currentState!.validate();
    final isValidLogradouro = _logradouroFildKey.currentState!.validate();
    final isValidBairro = _bairroFildKey.currentState!.validate();
    final isValidNumero = _numeroFildKey.currentState!.validate();
    final isValidComplemento = _complementoFildKey.currentState!.validate();
    final isValidCidade = _cidadeFildKey.currentState!.validate();
    final isValidEstado = _estadoFildKey.currentState!.validate();
    final isValidLatitude = _latitudeFildKey.currentState!.validate();
    final isValidLongitude = _longitudeFildKey.currentState!.validate();
    final isValidLinkFacebook = _linkFacebookFildKey.currentState!.validate();
    final isValidLinkInstagram = _linkInstagramFildKey.currentState!.validate();
    final isValidChavePix = _chavePixFildKey.currentState!.validate();

    setState(() {
      FullLoading.show(context);
    });
    if (isValidForm == false) {
      if (isValidNomeLocal == false) {
        setState(() {
          nomeLocalValidated = false;
        });
      } else {
        setState(() {
          nomeLocalValidated = true;
        });
      }

      if (isValidCnpj == false) {
        setState(() {
          cnpjValidated = false;
        });
      } else {
        setState(() {
          cnpjValidated = true;
        });
      }

      if (isValidEmail == false) {
        setState(() {
          emailValidated = false;
        });
      } else {
        setState(() {
          emailValidated = true;
        });
      }

      if (isValidTelefone1 == false) {
        setState(() {
          telefone1Validated = false;
        });
      } else {
        setState(() {
          telefone1Validated = true;
        });
      }

      if (isValidDescSobre == false) {
        setState(() {
          descSobreValidated = false;
        });
      } else {
        setState(() {
          descSobreValidated = true;
        });
      }

      if (isValidDescFinsBeneficentes == false) {
        setState(() {
          descFinsBeneficentesValidated = false;
        });
      } else {
        setState(() {
          descFinsBeneficentesValidated = true;
        });
      }

      if (isValidDescDisponibilidade == false) {
        setState(() {
          descDisponibilidadeValidated = false;
        });
      } else {
        setState(() {
          descDisponibilidadeValidated = true;
        });
      }

      if (isValidDescArrecadacoesAceitas == false) {
        setState(() {
          descArrecadacoesAceitasValidated = false;
        });
      } else {
        setState(() {
          descArrecadacoesAceitasValidated = true;
        });
      }

      if (isValidDescApoiadores == false) {
        setState(() {
          descApoiadoresValidated = false;
        });
      } else {
        setState(() {
          descApoiadoresValidated = true;
        });
      }

      if (isValidDescObservacoes == false) {
        setState(() {
          descObservacoesValidated = false;
        });
      } else {
        setState(() {
          descObservacoesValidated = true;
        });
      }

      if (isValidCep == false) {
        setState(() {
          cepValidated = false;
        });
      } else {
        setState(() {
          cepValidated = true;
        });
      }

      if (isValidLogradouro == false) {
        setState(() {
          logradouroValidated = false;
        });
      } else {
        setState(() {
          logradouroValidated = true;
        });
      }

      if (isValidBairro == false) {
        setState(() {
          bairroValidated = false;
        });
      } else {
        setState(() {
          bairroValidated = true;
        });
      }

      if (isValidNumero == false) {
        setState(() {
          numeroValidated = false;
        });
      } else {
        setState(() {
          numeroValidated = true;
        });
      }

      if (isValidComplemento == false) {
        setState(() {
          complementoValidated = false;
        });
      } else {
        setState(() {
          complementoValidated = true;
        });
      }

      if (isValidCidade == false) {
        setState(() {
          cidadeValidated = false;
        });
      } else {
        setState(() {
          cidadeValidated = true;
        });
      }

      if (isValidEstado == false) {
        setState(() {
          estadoValidated = false;
        });
      } else {
        setState(() {
          estadoValidated = true;
        });
      }

      if (isValidLatitude == false) {
        setState(() {
          latitudeValidated = false;
        });
      } else {
        setState(() {
          latitudeValidated = true;
        });
      }

      if (isValidLongitude == false) {
        setState(() {
          longitudeValidated = false;
        });
      } else {
        setState(() {
          longitudeValidated = true;
        });
      }

      if (isValidLinkFacebook == false) {
        setState(() {
          linkFacebookValidated = false;
        });
      } else {
        setState(() {
          linkFacebookValidated = true;
        });
      }

      if (isValidLinkInstagram == false) {
        setState(() {
          linkInstagramValidated = false;
        });
      } else {
        setState(() {
          linkInstagramValidated = true;
        });
      }

      if (isValidChavePix == false) {
        setState(() {
          chavePixValidated = false;
        });
      } else {
        setState(() {
          chavePixValidated = true;
        });
      }
      setState(() {
        FullLoading.hide(context);
      });
    } else {
      setState(() {
        nomeLocalValidated = true;
      });
      setState(() {
        cnpjValidated = true;
      });
      setState(() {
        emailValidated = true;
      });
      setState(() {
        telefone1Validated = true;
      });
      setState(() {
        descSobreValidated = true;
      });
      setState(() {
        descFinsBeneficentesValidated = true;
      });
      setState(() {
        descDisponibilidadeValidated = true;
      });
      setState(() {
        descArrecadacoesAceitasValidated = true;
      });
      setState(() {
        descApoiadoresValidated = true;
      });
      setState(() {
        descObservacoesValidated = true;
      });
      setState(() {
        cepValidated = true;
      });
      setState(() {
        logradouroValidated = true;
      });
      setState(() {
        bairroValidated = true;
      });
      setState(() {
        numeroValidated = true;
      });
      setState(() {
        complementoValidated = true;
      });
      setState(() {
        cidadeValidated = true;
      });
      setState(() {
        estadoValidated = true;
      });
      setState(() {
        latitudeValidated = true;
      });
      setState(() {
        longitudeValidated = true;
      });
      setState(() {
        linkFacebookValidated = true;
      });
      setState(() {
        linkInstagramValidated = true;
      });
      setState(() {
        chavePixValidated = true;
      });

      // await Future.delayed(const Duration(milliseconds: 1000));

      var arrecadacoesAceitas = "";
      _selectedItemsArrecadacoesAceitas.forEach((element) {
        arrecadacoesAceitas += "${element.name}, ";
      });
      arrecadacoesAceitas =
          arrecadacoesAceitas.substring(0, arrecadacoesAceitas.length - 2);

      var telefoneFormatado = _telefone1Controller.text;
      telefoneFormatado = telefoneFormatado.trim();
      telefoneFormatado = telefoneFormatado.replaceAll(' ', '');

      _cnpjController.text = _cnpjController.text.replaceAll('.', '');
      _cnpjController.text = _cnpjController.text.replaceAll('-', '');
      _cnpjController.text = _cnpjController.text.replaceAll('/', '');

      var imgUploaded = new RespostaApi(false, []);
      if (_image != null) {
        imgUploaded =
            await baseService.uploadImagem(usuarioApi, _image!, _image!.path);
      }

      var instituicao = new Instituicao(
        idInstituicao: 0,
        nome: _nomeLocalController.text,
        cnpj: _cnpjController.text,
        email: _emailController.text,
        telefone1: telefoneFormatado,
        telefone2: "",
        descSobre: _descSobreController.text,
        descFinsBeneficentes: _descFinsBeneficentesController.text,
        descDisponibilidade: _descDisponibilidadeController.text,
        descArrecadacoesAceitas: arrecadacoesAceitas,
        descApoiadores: _descApoiadoresController.text,
        descObservacoes: _descObservacoesController.text,
        cidade: _cidadeController.text,
        estado: _estadoController.text,
        cep: _cepController.text,
        logradouro: _logradouroController.text,
        bairro: _bairroController.text,
        numero: _numeroController.text.isNotEmpty
            ? int.parse(_numeroController.text)
            : int.parse(_numeroController.text = "0"),
        complemento: _complementoController.text,
        latitude: _latitudeController.text.isNotEmpty
            ? double.parse(_latitudeController.text)
            : double.parse(_latitudeController.text = '00'),
        longitude: _longitudeController.text.isNotEmpty
            ? double.parse(_longitudeController.text)
            : double.parse(_longitudeController.text = '00'),
        flAprovado: false,
        urlImagem: imgUploaded.sucess ? imgUploaded.errors.first : "",
        urlFacebook: _linkFacebookController.text,
        urlInstagram: _linkInstagramController.text,
        chavePix: _chavePixController.text,
      );

      var cadastrou =
          await baseService.cadastrarInstituicao(usuarioApi, instituicao);

      var errosFormatado = "";
      cadastrou.errors.forEach((element) {
        errosFormatado += "${element.toString()} \n";
      });

      // o cadastro vai retornar um sucess com true ou false indicando se deu certo.
      // também tem uma lista de errors, trazendo os erros que retornou da api.
      if (cadastrou.sucess) {
        setState(() {
          FullLoading.hide(context);
        });
        await QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Solicitação enviada com sucesso!',
            text:
                'Dentro de 3 dias estaremos analisando seu registro. Após a analise, enviaremos uma resposta para o e-mail cadastrado.',
            animType: QuickAlertAnimType.scale,
            confirmBtnTextStyle: TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.white,
            ),
            confirmBtnColor: AppTheme.nearlyPurple,
            titleColor: AppTheme.nearlyPurple,
            confirmBtnText: 'OK',
            onConfirmBtnTap: () {
              setState(() {
                Navigator.pop(context);
              });
            });

        setState(() {
          Navigator.pop(context);
        });
      } else {
        setState(() {
          FullLoading.hide(context);
        });
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Opa, algo deu errado!',
          text: '${errosFormatado}',
          animType: QuickAlertAnimType.scale,
          confirmBtnTextStyle: TextStyle(
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppTheme.white,
          ),
          confirmBtnColor: AppTheme.nearlyPurple,
          titleColor: AppTheme.nearlyPurple,
          confirmBtnText: 'OK',
        );
      }
    }

    print(isValidForm);
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 38,
              width: 38,
              child: InkWell(
                highlightColor: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: AppTheme.grey,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Formulário',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: AppTheme.grey,
                  ),
                ),
                Text(
                  'Solicitar Ponto de Coleta',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: AppTheme.nearlyPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
