import 'package:flutter/material.dart'; 

import 'package:flutter_hypertension_monitor/core/navigation/app_navigation_destination.dart';
import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart';

abstract final class AppDestinations {

    static const home = AppNavigationDestination(
        section: NavigationSection.home, 
        label: 'Home', 
        icon: Icons.home_outlined, 
        selectedIcon: Icons.home,
    ); 

    static const patients = AppNavigationDestination(
        section: NavigationSection.patients,
        label: 'Patients', 
        icon: Icons.person_outline, 
        selectedIcon: Icons.person, 
    ); 

    static const medicalHistory = AppNavigationDestination(
        section: NavigationSection.medicalHistory,
        label: 'Medical History', 
        icon: Icons.assignment_outlined, 
        selectedIcon: Icons.assignment, 
    ); 

    static const measurements = AppNavigationDestination(
        section: NavigationSection.measurements,
        label: 'Measurements', 
        icon: Icons.favorite_outline, 
        selectedIcon: Icons.favorite, 
    ); 

    static const statistics = AppNavigationDestination(
        section: NavigationSection.statistics,
        label: 'Statistics', 
        icon: Icons.bar_chart_outlined,
        selectedIcon: Icons.bar_chart, 
    ); 

    static const settings = AppNavigationDestination(
        section: NavigationSection.settings,
        label: 'Settings', 
        icon: Icons.settings_outlined, 
        selectedIcon: Icons.settings, 
    ); 


    // BottomNavigationBar (smartphone)
    static const mobileBottom = [
        home, 
        statistics, 
    ]; 

    // Drawer (smartphone)
    static const drawer = [
        home, 
        patients, 
        measurements, 
        medicalHistory,
        statistics,  
        settings, 
    ]; 

    // NavigationRail (tablet/desktop/web)
    static const rail = [
        home, 
        patients, 
        medicalHistory, 
        statistics, 
        settings, 
    ]; 
/** 
    static const mobileBottom = [
        home, 
        patients, 
        measurements,
        statistics, 
        medicalHistory, 
        settings, 
    ]; 
*/

}