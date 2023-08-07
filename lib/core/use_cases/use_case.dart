import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<ReturnType, ParamsType> {
  Future<Either<Failure, ReturnType>> call(ParamsType params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
