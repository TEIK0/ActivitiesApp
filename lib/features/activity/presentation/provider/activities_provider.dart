import 'package:activities_app/core/use_cases/use_case.dart';
import 'package:activities_app/features/activity/domain/entities/activity.dart';
import 'package:activities_app/features/activity/domain/usecases/get_activity.dart';

import '../../../../core/providers/base_provider.dart';
import '../../../../core/providers/page_state.dart';
import '../../../../core/utils/utils.dart';

class ActivityProvider extends BaseProvider {
  final GetActivity _getactivity;

  ActivityProvider({
    required GetActivity getactivity,
  }) : _getactivity = getactivity;

  Activity? activity;

  Future<void> getActivity() async {
    state = Loading();
    final failureOrCourses = await _getactivity(NoParams());

    // Handle success or error
    failureOrCourses.fold(
      (failure) {
        state = Error(message: Utils.getErrorMessage(failure));
      },
      (getResult) {
        state = const Loaded();
        activity = getResult;
      },
    );
  }
}
