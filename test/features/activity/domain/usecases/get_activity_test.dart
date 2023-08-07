import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:activities_app/core/use_cases/use_case.dart';

import 'package:activities_app/features/activity/domain/repositories/activity_repository.dart';
import 'package:activities_app/features/activity/domain/usecases/get_activity.dart';
import 'package:activities_app/features/activity/domain/entities/activity.dart';

@GenerateNiceMocks([MockSpec<ActivityRepository>()])
import 'get_activity_test.mocks.dart';

void main() {
  late MockActivityRepository mockActivityRepository;
  late GetActivity useCase;

  setUp(() {
    mockActivityRepository = MockActivityRepository();
    useCase = GetActivity(mockActivityRepository);
  });

  const tryActivity = Activity(
      accessibility: 0.1,
      activity: 'Start a blog for something youre passionate about',
      participants: 1,
      key: '8364626',
      type: 'recreational',
      link: '');

  test(
    'should get the activity from the repository',
    () async {
      // arrange
      when(mockActivityRepository.getActivity())
          .thenAnswer((_) async => const Right(tryActivity));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Right(tryActivity));
      verify(mockActivityRepository.getActivity());
      verifyNoMoreInteractions(mockActivityRepository);
    },
  );
}
