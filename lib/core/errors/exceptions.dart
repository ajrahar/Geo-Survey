/// Base exception class
class AppException implements Exception {
  final String message;
  final dynamic error;

  AppException(this.message, [this.error]);

  @override
  String toString() =>
      'AppException: $message${error != null ? ' ($error)' : ''}';
}

/// Database exceptions
class DatabaseException extends AppException {
  DatabaseException(super.message, [super.error]);
}

/// File system exceptions
class FileSystemException extends AppException {
  FileSystemException(super.message, [super.error]);
}

/// Validation exceptions
class ValidationException extends AppException {
  ValidationException(super.message, [super.error]);
}

/// Permission exceptions
class PermissionException extends AppException {
  PermissionException(super.message, [super.error]);
}

/// Network exceptions
class NetworkException extends AppException {
  NetworkException(super.message, [super.error]);
}

/// Cache exceptions
class CacheException extends AppException {
  CacheException(super.message, [super.error]);
}
