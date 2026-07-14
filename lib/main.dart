import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/core/theme/app_theme.dart';
import 'package:flutter_hypertension_monitor/data/hive/hive_initializer.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_route_generator.dart'; 
import 'package:flutter_hypertension_monitor/core/navigation/app_routes.dart'; 
import 'package:flutter_hypertension_monitor/core/navigation/navigation_service_provider.dart'; 
import 'package:flutter_hypertension_monitor/core/auth/current_session.dart';
import 'package:flutter_hypertension_monitor/data/repositories/user_repository_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';

Future<String> getInitialRoute() async {

  final currentSession = CurrentSession();

  final userId = currentSession.getCurrentUserId();

  if (userId != null) {
    return AppRoutes.home;
  }

  return AppRoutes.login;

}


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await HiveInitializer.initialize();

  final container = ProviderContainer(); 

  final appUser = await CurrentSession()
    .restoreSession(
      container.read(
        userRepositoryProvider, 
      ),
    ); 

  if (appUser != null) {

    container.read(
      currentUserProvider.notifier, 
    )
    .login(
      appUser, 
    ); 

  }

  final initialRoute = 
    appUser != null
      ? AppRoutes.home
      : AppRoutes.login; 

  runApp(

    UncontrolledProviderScope(

      container: container, 

      child: HypertensionMonitorApp(

        initialRoute: initialRoute,

      ),
    ),
  );
}

class HypertensionMonitorApp extends ConsumerStatefulWidget {

  const HypertensionMonitorApp({
    super.key, 
    required this.initialRoute, 
  }); 

  final String initialRoute; 

  @override
  ConsumerState<HypertensionMonitorApp> createState() =>
      _HypertensionMonitorAppState();

} 



class _HypertensionMonitorAppState extends ConsumerState<HypertensionMonitorApp> {

  @override 
  Widget build(
    BuildContext context, 
  ) {

    final navigationService =
      ref.read(
        navigationServiceProvider,
      );

    return MaterialApp(
      
      debugShowCheckedModeBanner: false, 

      title: 'Hypertension Monitor', 

      theme: AppTheme.lightTheme, 

      //home: const HomePage(), 

      navigatorKey: navigationService.navigationKey, 

      //initialRoute: AppRoutes.login, 
      initialRoute: widget.initialRoute, 

      onGenerateRoute: AppRouteGenerator.generateRoute, 

    ); 

  }

}
