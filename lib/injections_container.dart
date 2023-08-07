import 'package:activities_app/core/network/network_info.dart';
import 'package:activities_app/features/activity/presentation/provider/activities_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:activities_app/features/activity/data/datasources/activity_remote_datasource.dart';
import 'package:activities_app/features/activity/data/repositories/activity_repository_impl.dart';
import 'package:activities_app/features/activity/domain/repositories/activity_repository.dart';
import 'package:activities_app/features/activity/domain/usecases/get_activity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/activity/data/datasources/activity_local_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //* Features - Auth.
  // Use Cases.
  sl.registerLazySingleton(() => GetActivity(sl()));

  // Repository.
  sl.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(network: sl(), remote: sl(), local: sl()),
  );

  // Data sources.
  sl.registerLazySingleton<ActivityRemoteDataSource>(
    () => ActivityRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ActivityLocalDataSource>(
    () => ActivityLocalDataSourceImpl(sharedP: sl()),
  );

  // Providers
  sl.registerLazySingleton(() => ActivityProvider(getactivity: sl()));

  //* Core

  //* External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );
}
