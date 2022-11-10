class Instituicao {
  late int? idInstituicao;
  late String? nome;
  late String? cnpj;
  late String? email;
  late String? telefone1;
  late String? telefone2;
  late String? descSobre;
  late String? descFinsBeneficentes;
  late String? descDisponibilidade;
  late String? descArrecadacoesAceitas;
  late String? descApoiadores;
  late String? descObservacoes;
  late String? cidade;
  late String? estado;
  late String? cep;
  late String? logradouro;
  late String? bairro;
  late int? numero;
  late String? complemento;
  late double? latitude;
  late double? longitude;
  late bool? flAprovado;
  late String? urlImagem;
  late String? urlFacebook;
  late String? urlInstagram;
  late String? chavePix;

  Instituicao(
      {this.idInstituicao,
      this.nome,
      this.cnpj,
      this.email,
      this.telefone1,
      this.telefone2,
      this.descSobre,
      this.descFinsBeneficentes,
      this.descDisponibilidade,
      this.descArrecadacoesAceitas,
      this.descApoiadores,
      this.descObservacoes,
      this.cidade,
      this.estado,
      this.cep,
      this.logradouro,
      this.bairro,
      this.numero,
      this.complemento,
      this.latitude,
      this.longitude,
      this.flAprovado,
      this.urlImagem,
      this.urlFacebook,
      this.urlInstagram,
      this.chavePix});
}

List<Instituicao> ListaInstituicaoFromJson(List<dynamic> parsedJson) {
  List<Instituicao> listaInstituicoes = [];

  for (var item in parsedJson) {
    listaInstituicoes.add(new Instituicao(
        idInstituicao: item["IdInstituicao"],
        nome: item["Nome"],
        cnpj: item["Cnpj"],
        email: item["Email"],
        telefone1: item["Telefone1"],
        telefone2: item["Telefone2"],
        descSobre: item["DescSobre"],
        descFinsBeneficentes: item["DescFinsBeneficentes"],
        descDisponibilidade: item["DescDisponibilidade"],
        descArrecadacoesAceitas: item["DescArrecadacoesAceitas"],
        descApoiadores: item["DescApoiadores"],
        descObservacoes: item["DescObservacoes"],
        cidade: item["Cidade"],
        estado: item["Estado"],
        cep: item["Cep"],
        logradouro: item["Logradouro"],
        bairro: item["Bairro"],
        numero: item["Numero"],
        complemento: item["Complemento"],
        latitude: item["Latitude"],
        longitude: item["Longitude"],
        flAprovado: item["FlAprovado"],
        urlImagem: item["UrlImagem"],
        urlFacebook: item["UrlFacebook"],
        urlInstagram: item["UrlInstagram"],
        chavePix: item["ChavePix"]));
  }

  return listaInstituicoes;
}

Map<String, dynamic> InstituicaoToJson(Instituicao instituicao) => {
      "idInstituicao": instituicao.idInstituicao,
      "nome": instituicao.nome,
      "cnpj": instituicao.cnpj,
      "email": instituicao.email,
      "telefone1": instituicao.telefone1,
      "telefone2": instituicao.telefone2,
      "descSobre": instituicao.descSobre,
      "descFinsBeneficentes": instituicao.descFinsBeneficentes,
      "descDisponibilidade": instituicao.descDisponibilidade,
      "descArrecadacoesAceitas": instituicao.descArrecadacoesAceitas,
      "descApoiadores": instituicao.descApoiadores,
      "descObservacoes": instituicao.descObservacoes,
      "cidade": instituicao.cidade,
      "estado": instituicao.estado,
      "cep": instituicao.cep,
      "logradouro": instituicao.logradouro,
      "bairro": instituicao.bairro,
      "numero": instituicao.numero,
      "complemento": instituicao.complemento,
      "latitude": instituicao.latitude,
      "longitude": instituicao.longitude,
      "flAprovado": instituicao.flAprovado,
      "urlImagem": instituicao.urlImagem,
      "urlFacebook": instituicao.urlFacebook,
      "urlInstagram": instituicao.urlInstagram,
      "chavePix": instituicao.chavePix
    };
