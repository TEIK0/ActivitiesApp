import 'dart:convert';

import 'package:activities_app/features/activity/data/datasources/activity_local_datasource.dart';
import 'package:activities_app/features/activity/data/models/activity_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:activities_app/core/network/network_info.dart';

import 'package:activities_app/features/activity/data/datasources/activity_remote_datasource.dart';
import 'package:activities_app/features/activity/data/repositories/activity_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([
  MockSpec<ActivityRemoteDataSource>(),
  MockSpec<ActivityLocalDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'activity_repository_impl_test.mocks.dart';

void main() {
  late ActivityRepositoryImpl repository;
  late MockActivityRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockActivityLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockActivityLocalDataSource();
    mockRemoteDataSource = MockActivityRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ActivityRepositoryImpl(
        remote: mockRemoteDataSource,
        network: mockNetworkInfo,
        local: mockLocalDataSource);
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group('get activity', () {
    final activityjson =
        ActivityModel.fromJson(json.decode(fixture('activity.json')));

    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getActivity();

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test('Should return remote data when the call is successfull', () async {
        when(mockRemoteDataSource.getActivity())
            .thenAnswer((_) async => activityjson);

        final result = await repository.getActivity();

        verify(mockRemoteDataSource.getActivity());

        expect(result, equals(Right(activityjson)));
      });
    });
  });
}
