import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/core/theme/app_theme.dart';
import 'package:flutter_hypertension_monitor/data/hive/hive_initializer.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_route_generator.dart'; 
import 'package:flutter_hypertension_monitor/core/navigation/app_routes.dart'; 
import 'package:flutter_hypertension_monitor/providers/navigation_service_provider.dart'; 

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await HiveInitializer.initialize();

  runApp(
    const ProviderScope(
      child: HypertensionMonitorApp(),
    ),
  );
}

class HypertensionMonitorApp extends ConsumerWidget {

  const HypertensionMonitorApp({
    super.key
  }); 

  @override 
  Widget build(
    BuildContext context, 
    WidgetRef ref, 
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

      initialRoute: AppRoutes.login, 

      onGenerateRoute: AppRouteGenerator.generateRoute, 

    ); 

  }

} 
