import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/activity.dart';
import '../provider/activities_provider.dart';

class ActivityPageLoaded extends StatelessWidget {
  const ActivityPageLoaded({
    super.key,
    required this.activity,
  });

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Color typeColor = Colors.black;
    Color typeIconColor = Colors.white;
    final activityProvider = context.watch<ActivityProvider>();

    IconData typeIcon = Icons.abc;
    if (activity.type == 'education') {
      typeColor = Colors.green;
      typeIcon = Icons.book;
      typeIconColor = Colors.black;
    } else if (activity.type == 'recreational') {
      typeColor = Colors.blue;
      typeIcon = Icons.gamepad;
      typeIconColor = Colors.black;
    } else if (activity.type == 'social') {
      typeColor = Colors.red;
      typeIcon = Icons.group;
      typeIconColor = Colors.white;
    } else if (activity.type == 'diy') {
      typeColor = Colors.purple;
      typeIcon = Icons.cut;
      typeIconColor = Colors.black;
    } else if (activity.type == 'charity') {
      typeColor = Colors.pink;
      typeIcon = Icons.healing;
      typeIconColor = Colors.white;
    } else if (activity.type == 'cooking') {
      typeColor = Colors.yellow;
      typeIcon = Icons.dining_outlined;
      typeIconColor = Colors.black;
    } else if (activity.type == 'relaxation') {
      typeColor = Colors.greenAccent.shade400;
      typeIcon = Icons.self_improvement_sharp;
      typeIconColor = Colors.black;
    } else if (activity.type == 'music') {
      typeColor = Colors.blue.shade900;
      typeIcon = Icons.music_note;
      typeIconColor = Colors.white;
    } else if (activity.type == 'busywork') {
      typeColor = Colors.deepOrange;
      typeIcon = Icons.work;
      typeIconColor = Colors.black;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text(
              activity.activity,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: typeColor,
                  ),
                  child: Icon(typeIcon, color: typeIconColor, size: 80),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  activity.type,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: typeColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          GestureDetector(
            onTap: () {
              activityProvider.getActivity();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 20.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  'Get a new task!!',
                  style: textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
