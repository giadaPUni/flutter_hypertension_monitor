import 'package:flutter/material.dart';

import 'package:flutter_hypertension_monitor/features/auth/login_page.dart';
import 'package:flutter_hypertension_monitor/features/auth/register_page.dart'; 
import 'package:flutter_hypertension_monitor/features/dashboard/dashboard_page.dart'; 
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_page.dart'; 
import 'package:flutter_hypertension_monitor/features/measurements/measurements_page.dart'; 
import 'package:flutter_hypertension_monitor/features/patients/patient_page.dart'; 
import 'package:flutter_hypertension_monitor/features/profile/profile_page.dart';
import 'package:flutter_hypertension_monitor/features/settings/settings_page.dart';
import 'package:flutter_hypertension_monitor/features/statistics/statistics_page.dart';

import 'app_routes.dart'; 

/*
 * mapping Route name -> Widget (for example: /login -> LoginPage())
*/

class AppRouteGenerator {

    static Route<dynamic> generateRoute(
        RouteSettings settings,
    ) {

        switch (settings.name) {

            case AppRoutes.login:
                return MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                );

            case AppRoutes.register: 
                return MaterialPageRoute(
                    builder: (_) => const RegisterPage(),
                );

            case AppRoutes.dashboard: 
                return MaterialPageRoute(
                    builder: (_) => DashboardPage(), 
                ); 
            
            case AppRoutes.patients: 
                return MaterialPageRoute(
                    builder: (_) => PatientPage(), 
                ); 

            case AppRoutes.medicalHistory: 
                return MaterialPageRoute(
                    builder: (_) => MedicalHistoryPage(), 
                ); 

            case AppRoutes.measurements: 
                return MaterialPageRoute(
                    builder: (_) => MeasurementsPage(),
                ); 
        
            case AppRoutes.statistics: 
                return MaterialPageRoute(
                    builder: (_) => StatisticsPage(), 
                );

            case AppRoutes.profile: 
                return MaterialPageRoute(
                    builder: (_) => ProfilePage(), 
                ); 

            case AppRoutes.settings: 
                return MaterialPageRoute(
                    builder:(_) => SettingsPage(),
                ); 

            default: 
                return MaterialPageRoute(
                    builder: (_) => const Scaffold(
                        body: Center(
                            child: Text(
                                'Route not found',
                            ),
                        ),
                    ),
                );
                
        }
    }

}