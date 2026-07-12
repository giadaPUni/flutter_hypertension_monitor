import 'package:flutter/material.dart'; 

import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart'; 
import 'package:flutter_hypertension_monitor/shared/layout/main_layout.dart'; 
import 'package:flutter_hypertension_monitor/features/patients/patient_page.dart'; 
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_page.dart'; 
import 'package:flutter_hypertension_monitor/features/measurements/measurements_page.dart'; 
import 'package:flutter_hypertension_monitor/features/statistics/statistics_page.dart'; 
import 'package:flutter_hypertension_monitor/features/settings/settings_page.dart'; 



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

        ); 

    }

    Widget _buildBody() {

        switch (_currentSection) {

            case NavigationSection.home:
                return const Center(
                    child: Text(
                        'Home',
                    ),
                );

            case NavigationSection.patients: 
                return const PatientPage(); 

            case NavigationSection.medicalHistory: 
                return const MedicalHistoryPage(); 

            case NavigationSection.measurements: 
                return const MeasurementsPage(); 

            case NavigationSection.statistics:
                return const StatisticsPage(); 
            
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

}