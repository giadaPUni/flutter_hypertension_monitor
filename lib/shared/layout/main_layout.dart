import 'package:flutter/material.dart'; 

import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart'; 
import 'package:flutter_hypertension_monitor/core/responsive/adaptive_scaffold.dart'; 


class MainLayout extends StatelessWidget {

    const MainLayout({
        super.key, 
        required this.title, 
        required this.currentSection, 
        required this.onSectionSelected, 
        required this.body, 
        this.floatingActionButton, 
    }); 

    final Widget title; 
    
    final NavigationSection currentSection; 

    final ValueChanged<NavigationSection> onSectionSelected; 

    final Widget body; 

    final Widget? floatingActionButton;

    @override 
    Widget build(BuildContext context) {

        return AdaptiveScaffold(

            title: title, 

            selectedSection: currentSection, 

            onSectionSelected: onSectionSelected, 

            body: body, 

            floatingActionButton: floatingActionButton, 

        );

    }

}