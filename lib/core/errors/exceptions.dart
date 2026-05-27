// throw when http or api call fails
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException($statusCode): $message';
}

// throw when the device has no internet connection
class NetworkException implements Exception {
  const NetworkException();

  @override
  String toString() => 'NetworkException: no internet connection';
}

// throw when reading from or writing to local storage
class CacheException implements Exception {
  final String message;
  const CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

// throw when audio recording or file operations fail
class AudioException implements Exception {
  final String message;
  const AudioException({required this.message});

  @override
  String toString() => 'AudioException: $message';
}

// throw when requested resource does not exist
class NotFoundException implements Exception {
  final String resource;
  const NotFoundException({required this.resource});

  @override
  String toString() => 'NotFoundException: $resource not found';
}

// throw when user is not authenticated or session has expired
class AuthException implements Exception {
  final String message;
  const AuthException({required this.message});

  @override
  String toString() => 'AuthException: $message';
}
