import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:activities_app/core/error/exceptions.dart';

import 'package:activities_app/features/activity/data/models/activity_model.dart';
import 'package:activities_app/features/activity/data/datasources/activity_remote_datasource.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'activity_remote_datasource_test.mocks.dart';

void main() {
  late MockClient client;
  late ActivityRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockClient();
    dataSourceImpl = ActivityRemoteDataSourceImpl(client: client);
  });

  const tryActivityModel = ActivityModel(
      accessibility: 0.1,
      activity: 'Start a blog for something youre passionate about',
      participants: 1,
      key: '8364626',
      type: 'recreational',
      link: '');

  void setUpMockHttpClientGet(String response, [int statusCode = 200]) {
    when(
      client.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        response,
        statusCode,
      ),
    );
  }

  void setUpMockHttpClientGetException(Exception exception) {
    when(
      client.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenThrow(exception);
  }

  group('getActivity', () {
    test(
      'should perform a GET request with the application/json header',
      () async {
        // arrange
        setUpMockHttpClientGet(fixture('activity.json'), 200);

        // act
        dataSourceImpl.getActivity();

        // assert
        verify(
          client.get(
            Uri.parse('https://www.boredapi.com/api/activity/'),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
      },
    );

    test(
      'should return a ActivityModel when status code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientGet(fixture('activity.json'), 200);

        // act
        final result = await dataSourceImpl.getActivity();

        // assert
        expect(result, isA<ActivityModel>());
      },
    );

    test(
      'should throw NotFoundException when status code is 404',
      () async {
        // arrange
        setUpMockHttpClientGet('Error', 404);

        // act
        final call = dataSourceImpl.getActivity();

        // assert
        expect(
          () => call,
          throwsA(const TypeMatcher<NotFoundException>()),
        );
      },
    );

    test(
      'should throw ServerException when status code is other than 200 and 404',
      () async {
        // arrange
        setUpMockHttpClientGet('Error', 500);

        // act
        final call = dataSourceImpl.getActivity();

        // assert
        expect(
          () => call,
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw ServerException when ClientException occurs',
      () async {
        // arrange
        setUpMockHttpClientGetException(http.ClientException(''));

        // act
        final call = dataSourceImpl.getActivity();

        // assert
        expect(
          () => call,
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
