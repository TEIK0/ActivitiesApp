import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

import 'package:activities_app/core/network/network_info.dart';

import 'package:activities_app/features/activity/data/datasources/activity_remote_datasource.dart';
import 'package:activities_app/features/activity/data/datasources/activity_local_datasource.dart';
import 'package:activities_app/features/activity/domain/entities/activity.dart';
import 'package:activities_app/features/activity/domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remote;

  final ActivityLocalDataSource local;

  final NetworkInfo network;

  ActivityRepositoryImpl(
      {required this.remote, required this.local, required this.network});

  @override
  Future<Either<Failure, Activity>> getActivity() async {
    final isConnected = await network.isConnected;

    if (!isConnected) return _getLocalActivity();

    try {
      final activity = await remote.getActivity();

      await local.cacheActivity(activity);

      return Right(activity);
    } on ServerException {
      return _getLocalActivity();
    }
  }

  Future<Either<Failure, Activity>> _getLocalActivity() async {
    try {
      final activity = await local.getLastActivity();

      return Right(activity);
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Activity>> getByType(String type) async {
    final isConnected = await network.isConnected;

    if (!isConnected) return Left(ServerFailure());

    try {
      return Right(await remote.getActivity());
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
