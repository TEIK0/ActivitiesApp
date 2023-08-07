import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// General failures.
class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NoInternetConnectionFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NotFoundFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UserNotFoundFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NotAuthorizedFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NotEnrolledFailure extends Failure {
  @override
  List<Object> get props => [];
}

// Login failures
class UserCredentialsMismatchFailure extends Failure {
  @override
  List<Object> get props => [];
}
