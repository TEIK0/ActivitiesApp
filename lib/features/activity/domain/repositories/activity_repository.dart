import 'package:dartz/dartz.dart';

import 'package:activities_app/core/error/failures.dart';

import 'package:activities_app/features/activity/domain/entities/activity.dart';

abstract class ActivityRepository {
  /// Gets a random activity [Activity].
  Future<Either<Failure, Activity>> getActivity();
  Future<Either<Failure, Activity>> getByType(String type);
}
