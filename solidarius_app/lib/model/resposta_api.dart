class RespostaApi {
  late bool sucess;
  late List<dynamic> errors = [];

  RespostaApi(bool success, List<dynamic> errors) {
    this.sucess = success;
    this.errors = errors;
  }
}
