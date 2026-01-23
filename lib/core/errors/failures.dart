import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Database-related failures
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

/// File system failures (export/import)
class FileSystemFailure extends Failure {
  const FileSystemFailure(super.message);
}

/// Calculation failures
class CalculationFailure extends Failure {
  const CalculationFailure(super.message);
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Permission failures
class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

/// Network failures (tile download)
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Cache/Storage failures
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
