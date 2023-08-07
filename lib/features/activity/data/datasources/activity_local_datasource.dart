import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:activities_app/features/activity/data/models/activity_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class ActivityLocalDataSource {
  /// Gets the cached [ActivityModel] which was stored the last time
  /// the user loaded its profile.
  ///
  /// Throws [NotFoundException] if user is not found.
  ///
  /// Otherwise it throws [CacheException].
  Future<ActivityModel> getLastActivity();

  /// Stores the [activity] locally.
  Future<void> cacheActivity(ActivityModel activity);
}

class ActivityLocalDataSourceImpl implements ActivityLocalDataSource {
  final SharedPreferences sharedP;

  ActivityLocalDataSourceImpl({required this.sharedP});

  @override
  Future<void> cacheActivity(ActivityModel activity) {
    return sharedP.setString(
        'CACHED_NUMBER_TRIVIA', json.encode(activity.toJson()));
  }

  @override
  Future<ActivityModel> getLastActivity() {
    final activityJson = sharedP.getString('CACHED_NUMBER_TRIVIA');

    if (activityJson == null) {
      throw CacheException();
    }

    return Future.value(ActivityModel.fromJson(json.decode(activityJson)));
  }
}
