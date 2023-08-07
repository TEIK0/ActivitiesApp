import 'package:activities_app/features/activity/domain/entities/activity.dart';
import 'package:activities_app/features/activity/presentation/provider/activities_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/page_state.dart';
import '../../../../core/services/notifications_service.dart';
import '../widgets/activity_page_loaded.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  static const routeName = 'home';

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    final activityProvider = context.watch<ActivityProvider>();
    final state = activityProvider.state;

    if (state is Empty) {
      activityProvider.getActivity();
      return Container();
    }

    if (state is Error) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => NotificationsService.showSnackBar(state.message),
      );
    }

    if (state is Loading) {
      return Scaffold(
          backgroundColor: Color.fromARGB(212, 255, 255, 255),
          body: Center(child: CircularProgressIndicator()));
    }

    if (state is Loaded) {
      final activity = activityProvider.activity!;

      return ActivityPageLoaded(
        activity: activity,
      );
    }
    return Container();
  }
}
