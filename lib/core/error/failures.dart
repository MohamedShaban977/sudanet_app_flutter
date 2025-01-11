import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? error;

  const Failure([this.error]);

  @override
  List<Object?> get props => [error];
}

class ServerFailure extends Failure {
  const ServerFailure([String? error]) : super(error);
}

class CacheFailure extends Failure {
  const CacheFailure([String? error]) : super(error);
}

class HandleFailure {
  static String mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.error!;
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'UnExpected Error';
    }
  }
}
