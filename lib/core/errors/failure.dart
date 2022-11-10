import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? errorMessage;
  final String? code;

  const Failure({this.errorMessage, this.code});

  @override
  List<Object?> get props => [errorMessage, code];
}
