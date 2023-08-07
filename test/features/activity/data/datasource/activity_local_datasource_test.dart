import 'dart:convert';

import 'package:activities_app/core/error/exceptions.dart';
import 'package:activities_app/features/activity/data/models/activity_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:activities_app/features/activity/data/datasources/activity_local_datasource.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<SharedPreferences>()])
import 'activity_local_datasource_test.mocks.dart';

void main() {
  late ActivityLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();

    dataSource = ActivityLocalDataSourceImpl(sharedP: mockSharedPreferences);
  });

  group('getLastActivity', () {
    const tryActivityModel = ActivityModel(
        accessibility: 0.1,
        activity: 'Start a blog for something youre passionate about',
        participants: 1,
        key: '8364626',
        type: 'recreational',
        link: '');
    test('should return activity from cache', () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('activity.json'));

      final result = await dataSource.getLastActivity();

      verify(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));
      expect(result, isA<ActivityModel>());
    });

    test('should throw a Cache Exception when there is no cache', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = dataSource.getLastActivity;

      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cache the Activity', () {
    const tryActivityModel = ActivityModel(
        accessibility: 0.1,
        activity: 'Start a blog for something youre passionate about',
        participants: 1,
        key: '8364626',
        type: 'recreational',
        link: '');
    test('should call SharedPreferences to cache the data', () async {
      dataSource.cacheActivity(tryActivityModel);

      final expectedJson = json.encode(tryActivityModel.toJson());

      verify(mockSharedPreferences.setString(
          'CACHED_NUMBER_TRIVIA', expectedJson));
    });
  });
}
