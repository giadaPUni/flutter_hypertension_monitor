import 'package:flutter/material.dart'; 

import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart'; 
import 'package:flutter_hypertension_monitor/shared/layout/main_layout.dart'; 
import 'package:flutter_hypertension_monitor/features/patients/patient_page.dart'; 
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_page.dart'; 
import 'package:flutter_hypertension_monitor/features/measurements/measurements_page.dart'; 
import 'package:flutter_hypertension_monitor/features/statistics/statistics_page.dart'; 
import 'package:flutter_hypertension_monitor/features/settings/settings_page.dart'; 
import 'package:flutter_hypertension_monitor/features/profile/profile_page.dart'; 
import 'package:flutter_hypertension_monitor/core/navigation/app_navigation_destination.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_routes.dart';

class HomePage extends StatefulWidget {

    const HomePage({
        super.key, 
    }); 

    @override
    State<HomePage> createState() => _HomePageState(); 

}

class _HomePageState extends State<HomePage> {

    NavigationSection _currentSection = NavigationSection.home; 

    @override
    Widget build(BuildContext context) {

        return MainLayout(

            title: const Text(
                'Hypertension Monitor', 
            ),  

            currentSection: _currentSection, 

            onSectionSelected: (section) {

                setState(() {

                    _currentSection = section; 

                });

            },

            body: _buildBody(), 

            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    Navigator.of(context).pushNamed(
                        AppRoutes.addMeasurement, 
                    ); 
                },
                child: const Icon(Icons.add),
            ),    

            actions: [
                IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'New Measurement',
                    onPressed: () {

                        Navigator.of(context).pushNamed(
                            AppRoutes.addMeasurement,
                        );

                    },
                ),
            ],                    

        ); 

    }

    Widget _buildBody() {

        switch (_currentSection) {

            case NavigationSection.home:
                return _buildHomeContent(context); 

            case NavigationSection.patients: 
                return const PatientPage(); 

            case NavigationSection.medicalHistory: 
                return const MedicalHistoryPage(); 

            case NavigationSection.measurements: 
                return const MeasurementsPage(); 

            case NavigationSection.statistics:
                return const StatisticsPage(); 

            case NavigationSection.profile:
                return const ProfilePage();
            
            case NavigationSection.settings: 
                return const SettingsPage(); 

            default: 
                return const Center(
                    child: Text(
                        'Section not available', 
                    ),
                ); 

        }

    }


    Widget _buildHomeContent(BuildContext context) {

        return Padding(

            padding: const EdgeInsets.all(16),

            child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                    Text(
                        'Welcome',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium,
                    ),


                    const SizedBox(
                        height: 24,
                    ),


                    Card(

                        child: ListTile(

                            leading: const Icon(
                                Icons.favorite,
                            ),

                            title: const Text(
                                'Add blood pressure measurement',
                            ),

                            subtitle: const Text(
                                'Record a new blood pressure value',
                            ),

                            trailing: const Icon(
                                Icons.arrow_forward,
                            ),

                            onTap: () {

                                Navigator.of(context).pushNamed(
                                    AppRoutes.addMeasurement,
                                );

                            },

                        ),

                    ),


                    const SizedBox(
                        height: 24,
                    ),


                    Card(

                        child: ListTile(

                            leading: const Icon(
                                Icons.history,
                            ),

                            title: const Text(
                                'Recent measurements',
                            ),

                            subtitle: const Text(
                                'No measurements available',
                            ),

                        ),

                    ),

                ],

            ),

        );

    }    

}