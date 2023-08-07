import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final String activity;
  final String type;
  final int participants;
  final String? link;
  final String key;
  final double accessibility;

  const Activity(
      {required this.activity,
      required this.type,
      required this.participants,
      this.link,
      required this.key,
      required this.accessibility});

  @override
  List<Object?> get props =>
      [activity, type, participants, link, key, accessibility];
}
