class UsuarioApi {
  bool authenticated = false;
  late DateTime expiration;
  String acessToken = "";
  List<dynamic> errors = List.empty();
}
