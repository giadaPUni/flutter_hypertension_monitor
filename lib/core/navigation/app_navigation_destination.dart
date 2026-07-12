import 'package:flutter/material.dart'; 

import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart';

/// Represents a navigation destination used throughout the app
/// the same model is shared by the BottomNavigationBar
/// NavigationRail and Drawer to avoid duplication 

@immutable 
class AppNavigationDestination {

    const AppNavigationDestination({
        required this.section, 
        required this.label, 
        required this.icon, 
        this.selectedIcon, 
    }); 

    final NavigationSection section; 

    final String label; 

    final IconData icon; 

    final IconData? selectedIcon; 
    
}