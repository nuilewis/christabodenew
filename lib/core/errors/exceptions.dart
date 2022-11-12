class NoInternetException implements Exception {
  late String errorMessage;
  @override
  String toString() => errorMessage;
}
