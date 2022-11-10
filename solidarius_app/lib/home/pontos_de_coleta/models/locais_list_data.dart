import 'package:flutter/material.dart';

class LocaisListData {
  String foto;
  String nome;
  String cnpj;
  String email;
  String telefone;
  String sobreLocal;
  String fimBeneficente;
  String funcionamento;
  String apoiadores;
  String observacoes;
  String cep;
  String endereco;
  String cidade;
  String estado;
  List<String>? itens;
  double latitude;
  double longitude;
  String urlFacebook;
  String urlInstagram;
  String chavePix;
  String startColor;
  String endColor;

  LocaisListData({
    this.foto = '',
    this.nome = '',
    this.cnpj = '',
    this.email = '',
    this.telefone = '',
    this.sobreLocal = '',
    this.fimBeneficente = '',
    this.funcionamento = '',
    this.apoiadores = '',
    this.observacoes = '',
    this.cep = '',
    this.endereco = '',
    this.cidade = '',
    this.estado = '',
    this.itens,
    this.latitude = 0,
    this.longitude = 0,
    this.urlFacebook = '',
    this.urlInstagram = '',
    this.chavePix = '',
    this.startColor = '',
    this.endColor = '',
  });
}

class LocaisRepository extends ChangeNotifier {
  List<LocaisListData> locaisList_ = [];
  List<LocaisListData> get locaisList => locaisList_;
}
