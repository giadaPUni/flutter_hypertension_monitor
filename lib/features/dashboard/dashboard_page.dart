import 'package:flutter/material.dart'; 

import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart'; 
import 'package:flutter_hypertension_monitor/shared/layout/main_layout.dart'; 


class DashboardPage extends StatefulWidget {

    const DashboardPage({
        super.key, 
    }); 

    @override
    State<DashboardPage> createState() => _DashboardPageState(); 

}

class _DashboardPageState extends State<DashboardPage> {

    NavigationSection _currentSection = NavigationSection.dashboard; 

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

            case NavigationSection.dashboard: 
                return const Center(
                    child: Text(
                        'Dashboard',
                    ), 
                ); 

            case NavigationSection.patients: 
                return const Center(
                    child: Text(
                        'Patients',
                    ),
                );

            case NavigationSection.medicalHistory: 
                return const Center(
                    child: Text(
                        'Medical History', 
                    ),
                ); 

            case NavigationSection.measurements: 
                return const Center(
                    child: Text(
                        'Measurements', 
                    ), 
                ); 

            case NavigationSection.statistics:
                return const Center(
                    child: Text(
                        'Statistics', 
                    ),
                ); 
            
            case NavigationSection.settings: 
                return const Center(
                    child: Text(
                        'Settings', 
                    ), 
                ); 

            default: 
                return const SizedBox(); 

        }

    }

}