import 'package:flutter/material.dart'; 

/// Represents a navigation destination used throughout the app
/// the same model is shared by the BottomNavigationBar
/// NavigationRail and Drawer to avoid duplication 

@immutable 
class AppNavigationDestination {

    const AppNavigationDestination({
        required this.label, 
        required this.icon, 
        this.selectedIcon, 
    }); 

    final String label; 

    final IconData icon; 

    final IconData? selectedIcon; 
    
}