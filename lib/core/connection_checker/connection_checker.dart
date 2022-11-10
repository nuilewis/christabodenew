import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImplementation implements ConnectionChecker {
  final InternetConnectionChecker internetConnectionChecker;

  ConnectionCheckerImplementation(this.internetConnectionChecker);

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
