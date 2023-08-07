import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';

import '../entities/activity.dart';
import '../repositories/activity_repository.dart';

class GetActivity implements UseCase<Activity, String> {
  final ActivityRepository repository;

  GetActivity(this.repository);

  @override
  Future<Either<Failure, Activity>> call(String type) async {
    return await repository.getByType(type);
  }
}
