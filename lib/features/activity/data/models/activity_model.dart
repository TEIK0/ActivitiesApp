// To parse this JSON data, do
//
//     final activityModel = activityModelFromJson(jsonString);

import 'dart:convert';

import 'package:activities_app/features/activity/domain/entities/activity.dart';

ActivityModel activityModelFromJson(String str) =>
    ActivityModel.fromJson(json.decode(str));

String activityModelToJson(ActivityModel data) => json.encode(data.toJson());

class ActivityModel extends Activity {
  const ActivityModel({
    required super.activity,
    required super.type,
    required super.participants,
    required super.link,
    required super.key,
    required super.accessibility,
  });

  factory ActivityModel.fromEntity(Activity newActivity) {
    return ActivityModel(
        activity: newActivity.activity,
        accessibility: newActivity.accessibility,
        key: newActivity.key,
        link: newActivity.link,
        participants: newActivity.participants,
        type: newActivity.type);
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        activity: json["activity"],
        type: json["type"],
        participants: json["participants"],
        link: json["link"],
        key: json["key"],
        accessibility: json["accessibility"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "activity": activity,
        "type": type,
        "participants": participants,
        "link": link,
        "key": key,
        "accessibility": accessibility,
      };
}
