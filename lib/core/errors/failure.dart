import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? errorMessage;
  final String? code;

  const Failure({this.errorMessage, this.code});

  const Failure.generic({this.errorMessage ="An error has occurred", this.code});

  @override
  List<Object?> get props => [errorMessage, code];
}

////////////////////////////////////////////////////////////
// class FirebaseFailure implements Failure {
//   @override
//   final String? errorMessage;
//   @override
//   final String? code;
//
//   const FirebaseFailure({this.errorMessage, this.code});
//
//   @override
//   List<Object?> get props => [errorMessage, code];
//
//   @override
//   bool? get stringify => true;
// }
//
// class LocalStorageFailure implements Failure {
//   @override
//   final String? errorMessage;
//   @override
//   final String? code;
//
//   const LocalStorageFailure({this.errorMessage, this.code});
//
//   @override
//   List<Object?> get props => [errorMessage, code];
//
//   @override
//   bool? get stringify => true;
// }
//
// class NetworkFailure implements Failure {
//   @override
//   final String? errorMessage;
//   @override
//   final String? code;
//
//   const NetworkFailure({this.errorMessage, this.code});
//
//   @override
//   List<Object?> get props => [errorMessage, code];
//
//   @override
//   bool? get stringify => true;
// }
//
// class ApiFailure implements Failure {
//   @override
//   final String? errorMessage;
//   @override
//   final String? code;
//
//   const ApiFailure({this.errorMessage, this.code});
//
//   @override
//   List<Object?> get props => [errorMessage, code];
//
//   @override
//   bool? get stringify => true;
// }
