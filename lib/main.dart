import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

import 'data/hive/hive_initializer.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await HiveInitializer.initialize();

  runApp(
    const HypertensionMonitorApp(),
  );
}

class HypertensionMonitorApp extends StatelessWidget {

  const HypertensionMonitorApp({
    super.key
  }); 

  @override 
  Widget build(BuildContext context) {

    return MaterialApp(
      
      debugShowCheckedModeBanner: false, 

      title: 'Hypertension Monitor', 

      theme: AppTheme.lightTheme, 

      home: const HomePage(), 

    ); 

  }

} 


class HomePage extends StatelessWidget {
  const HomePage({
    super.key
  }); 

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Hypertension Monitor', 
        ), 
      ), 

      body: Center(
        child: Text(
          'Benvenuto', 
          style: Theme.of(context)
            .textTheme
            .headlineMedium, 
        ), 
      ), 

    ); 
  }

}