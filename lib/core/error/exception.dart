class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class TimeoutException implements Exception {
  final String message;
  const TimeoutException(this.message);
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException(this.message);
}

class NotFoundException implements Exception {
  final String message;
  const NotFoundException(this.message);
}

class BadRequestException implements Exception {
  final String message;
  const BadRequestException(this.message);
}

class DataParsingException implements Exception {
  final String message;
  const DataParsingException(this.message);
}

class UnknownException implements Exception {
  final String message;
  const UnknownException(this.message);
}
