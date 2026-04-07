abstract class Failure {
  final String message ;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.massage);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.massage);
}

class AuthFailure extends Failure {
  AuthFailure(super.massage);
}