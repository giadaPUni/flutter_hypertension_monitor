import 'package:flutter/material.dart'; 

import 'package:flutter_hypertension_monitor/core/navigation/app_destinations.dart'; 
import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart'; 
import 'package:flutter_hypertension_monitor/core/responsive/adaptive_scaffold.dart'; 


class MainLayout extends StatelessWidget {

    const MainLayout({
        super.key, 
        required this.title, 
        required this.currentSection, 
        required this.onSectionSelected, 
        required this.body, 
    }); 

    final Widget title; 
    
    final NavigationSection currentSection; 

    final ValueChanged<NavigationSection> onSectionSelected; 

    final Widget body; 

    static const List<NavigationSection> _sections = [
        NavigationSection.dashboard,
        NavigationSection.patients, 
        NavigationSection.measurements, 
        NavigationSection.statistics, 
        NavigationSection.medicalHistory, 
        NavigationSection.profile, 
        NavigationSection.settings, 
    ]; 

    int get _selectedIndex => _sections.indexOf(currentSection); 

    @override 
    Widget build(BuildContext context) {

        return AdaptiveScaffold(

            title: title, 

            destinations: AppDestinations.all, 

            selectedIndex: _selectedIndex, 

            onDestinationSelected: (index) {
                onSectionSelected(
                    _sections[index], 
                );
            },

            body: body, 

        );

    }

}