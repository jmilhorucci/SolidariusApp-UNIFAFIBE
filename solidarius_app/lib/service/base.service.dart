import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:solidarius_app/model/instituicao.dart';
import 'package:solidarius_app/model/resposta_api.dart';
import 'package:solidarius_app/model/usuario_api.dart';

final credenciais = jsonEncode(
    //Para ter acesso a API, por favor, entrar em contato pelo e-mail: "solidariusapp@outlook.com".
    {"Email": "###########", "Senha": "###########"});

const urlApi = 'http://3.209.132.93:9812';

Map<String, String> headers = {
  'content-type': 'application/json',
};

Future<UsuarioApi> autenticarApi() async {
  var url = Uri.parse("${urlApi}/api/login");
  var resposta = await http.post(url, headers: headers, body: credenciais);

  var usuario = new UsuarioApi();
  var jsonResposta = jsonDecode(resposta.body);
  if (resposta.statusCode == 200) {
    usuario.authenticated = jsonResposta["Authenticated"];
    usuario.acessToken = jsonResposta["AcessToken"];
    usuario.expiration = DateTime.parse(jsonResposta["Expiration"]);
    usuario.errors = jsonResposta["errors"];
  } else {
    usuario.authenticated = false;
    usuario.errors = jsonResposta["errors"];
  }

  return usuario;
}

Future<List<Instituicao>> obterInstituicoesCadastroAprovado(
    UsuarioApi usuarioApi) async {
  headers.addAll({'authorization': 'Bearer ${usuarioApi.acessToken}'});
  var url = Uri.parse(
      '${urlApi}/instituicao/pesquisar-instituicoes?queryField=&situacaoCadastro=1');
  var resposta = await http.get(url, headers: headers);

  List<Instituicao> listaInstituicoes = [];

  if (resposta.statusCode == 200) {
    listaInstituicoes = ListaInstituicaoFromJson(jsonDecode(resposta.body));
  }

  return listaInstituicoes;
}

Future<RespostaApi> cadastrarInstituicao(
    UsuarioApi usuarioApi, Instituicao instituicao) async {
  headers.addAll({'authorization': 'Bearer ${usuarioApi.acessToken}'});
  var url = Uri.parse('${urlApi}/instituicao/adicionar');

  var resposta = await http.post(url,
      headers: headers, body: jsonEncode(InstituicaoToJson(instituicao)));

  var retorno = new RespostaApi(false, []);

  if (resposta.statusCode == 200) {
    retorno.sucess = true;
    return retorno;
  } else if (resposta.statusCode == 403) {
    return retorno;
  } else {
    retorno.errors = jsonDecode(resposta.body)["errors"];
    return retorno;
  }
}

Future<List<Instituicao>> obterInstituicoesProximasPorLatitudeLongitude(
    UsuarioApi usuarioApi,
    double latitude,
    double longitude,
    double raio,
    int take) async {
  headers.addAll({'authorization': 'Bearer ${usuarioApi.acessToken}'});
  var url = Uri.parse(
      '${urlApi}/instituicao/obter-proximas?latitude=${latitude}&longitude=${longitude}&distancia=${raio}&take=${take}');
  var resposta = await http.get(url, headers: headers);

  List<Instituicao> listaInstituicoes = [];

  if (resposta.statusCode == 200) {
    listaInstituicoes = ListaInstituicaoFromJson(jsonDecode(resposta.body));
  }

  return listaInstituicoes;
}

Future<RespostaApi> uploadImagem(
    UsuarioApi usuarioApi, File file, String fileName) async {
  ///MultiPart request
  var request =
      http.MultipartRequest('POST', Uri.parse('${urlApi}/s3/upload/'));

  Map<String, String> headers = {
    "Authorization": "Bearer ${usuarioApi.acessToken}",
    "Content-type": "multipart/form-data"
  };

  request.files.add(
    http.MultipartFile(
      'file',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: fileName,
      contentType: MediaType('image', 'jpeg'),
    ),
  );
  request.headers.addAll(headers);

  print("request: " + request.toString());
  var res = await request.send();

  var resposta = await http.Response.fromStream(res);
  var retorno = new RespostaApi(false, []);

  if (resposta.statusCode == 200) {
    retorno.sucess = true;
    retorno.errors.add(jsonDecode(resposta.body)["Message"]);
    return retorno;
  } else if (resposta.statusCode == 403) {
    return retorno;
  } else {
    retorno.errors = jsonDecode(resposta.body)["errors"];
    return retorno;
  }
}
