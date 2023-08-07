import 'package:activities_app/features/activity/domain/entities/activity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:activities_app/features/activity/data/models/activity_model.dart';

void main() {
  const tryActivityModel = ActivityModel(
      accessibility: 0.1,
      activity: 'Start a blog for something youre passionate about',
      participants: 1,
      key: '8364626',
      type: 'recreational',
      link: '');

  test(
    'should be a subclass of Activity entity',
    () async {
      // assert
      expect(tryActivityModel, isA<Activity>());
    },
  );

  group('fromEntity', () {
    const tryActivity = Activity(
        accessibility: 0.1,
        activity: 'Start a blog for something youre passionate about',
        participants: 1,
        key: '8364626',
        type: 'recreational',
        link: '');

    test(
      'should return an ActivityModel',
      () async {
        // act
        final result = ActivityModel.fromEntity(tryActivity);

        // assert
        expect(result, isA<ActivityModel>());
      },
    );

    test(
      'should contain the same data as the Activity',
      () async {
        // act
        final result = ActivityModel.fromEntity(tryActivity);

        // assert
        expect(result.type, tryActivity.type);
        expect(result.key, tryActivity.key);
        expect(result.activity, tryActivity.activity);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tryActivityModel.toJson();

        // assert
        final expectedMap = {
          'activity': 'Start a blog for something youre passionate about',
          'type': 'recreational',
          'participants': 1,
          'link': '',
          'key': '8364626',
          'accessibility': 0.1
        };

        expect(result, expectedMap);
      },
    );
  });
}
