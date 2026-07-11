import 'package:flutter/material.dart'; 

import 'package:flutter_hypertension_monitor/core/navigation/app_navigation_destination.dart';


abstract final class AppDestinations {

    static const dashboard = AppNavigationDestination(
        label: 'Dashboard', 
        icon: Icons.dashboard_outlined, 
        selectedIcon: Icons.dashboard,
    ); 

    static const patient = AppNavigationDestination(
        label: 'Patient', 
        icon: Icons.person_outline, 
        selectedIcon: Icons.person, 
    ); 

    static const medicalHistory = AppNavigationDestination(
        label: 'Medical History', 
        icon: Icons.assignment_outlined, 
        selectedIcon: Icons.assignment, 
    ); 

    static const bloodPressure = AppNavigationDestination(
        label: 'Blood Pressure', 
        icon: Icons.favorite_outline, 
        selectedIcon: Icons.favorite, 
    ); 

    static const statistics = AppNavigationDestination(
        label: 'Statistics', 
        icon: Icons.bar_chart_outlined,
        selectedIcon: Icons.bar_chart, 
    ); 

    static const settings = AppNavigationDestination(
        label: 'Settings', 
        icon: Icons.settings_outlined, 
        selectedIcon: Icons.settings, 
    ); 

    static const all = [

        dashboard, 
        patient, 
        medicalHistory, 
        bloodPressure, 
        statistics, 
        settings, 
    ]; 

}