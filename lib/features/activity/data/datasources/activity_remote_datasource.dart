import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

import 'package:activities_app/features/activity/data/models/activity_model.dart';

abstract class ActivityRemoteDataSource {
  /// Calls the `/activity/` endpoint.

  Future<ActivityModel> getActivity();

  Future<ActivityModel> getByType(String type);
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  final http.Client client;

  ActivityRemoteDataSourceImpl({required this.client});

  @override
  Future<ActivityModel> getActivity() async {
    try {
      final response = await client.get(
        Uri.parse('https://www.boredapi.com/api/activity/'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 404) throw NotFoundException();

      if (response.statusCode != 200) throw ServerException();

      return ActivityModel.fromJson(json.decode(response.body));
    } on http.ClientException {
      throw ServerException();
    }
  }

  @override
  Future<ActivityModel> getByType(String type) async {
    try {
      final response = await client.get(
        Uri.parse('http://www.boredapi.com/api/activity?type=$type'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 404) throw NotFoundException();

      if (response.statusCode != 200) throw ServerException();

      return ActivityModel.fromJson(json.decode(response.body));
    } on http.ClientException {
      throw ServerException();
    }
  }
}
