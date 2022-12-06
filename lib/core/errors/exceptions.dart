class ConnectionException implements Exception {
  late String errorMessage;

  ConnectionException({this.errorMessage = "No Network Access"});
  @override
  String toString() => errorMessage;
}

class ApiException implements Exception {
  late String errorMessage;

  ApiException({this.errorMessage = "Api Error"});
  @override
  String toString() => errorMessage;
}
