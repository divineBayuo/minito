// base class for all domain-layer failure
// failures are returned rather than thrown
// keeping use-case logic clean and testable without try/catch

sealed class Failure {
  final String message;
  const Failure(this.message);
}

// the remote API returned an error response
class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
}

// the device is offline
class NetworkFailure extends Failure {
  const NetworkFailure() : super('No internet connection.');
}

// a local db or file-system operation failed
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// a microphone, file-read, or format error during audio handling
class AudioFailure extends Failure {
  const AudioFailure(super.message);
}

// the req resource was not found locally or remotely
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

// the user is unauthenticated or the token has expired
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

// the ai transcription or generation step failed
class ProcessingFailure extends Failure {
  const ProcessingFailure(super.message);
}
