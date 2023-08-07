import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/services/notifications_service.dart';

import 'package:activities_app/features/activity/presentation/pages/activity_page.dart';
import 'package:activities_app/features/activity/presentation/provider/activities_provider.dart';

import 'package:activities_app/injections_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inject dependencies.
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<ActivityProvider>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'When Bored',
        scaffoldMessengerKey: NotificationsService.messengerKey,
        initialRoute: ActivityPage.routeName,
        routes: {ActivityPage.routeName: (_) => const ActivityPage()},
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
      ),
    );
  }
}
