import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';

import 'package:activities_app/features/activity/domain/repositories/activity_repository.dart';
import 'package:activities_app/features/activity/domain/entities/activity.dart';

class GetActivity implements UseCase<Activity, NoParams> {
  final ActivityRepository repository;

  GetActivity(this.repository);

  @override
  Future<Either<Failure, Activity>> call(NoParams noParams) async {
    return await repository.getActivity();
  }
}
