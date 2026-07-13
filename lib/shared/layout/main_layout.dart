import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart'; 
import 'package:flutter_hypertension_monitor/core/responsive/adaptive_scaffold.dart'; 
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/core/navigation/navigation_config.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_navigation_destination.dart';

class MainLayout extends ConsumerWidget {

    const MainLayout({
        super.key, 
        required this.title, 
        required this.currentSection, 
        required this.onSectionSelected, 
        required this.body, 
        this.bottomDestinations, 
        this.floatingActionButton, 
    }); 

    final Widget title; 
    
    final NavigationSection currentSection; 

    final ValueChanged<NavigationSection> onSectionSelected; 

    final Widget body; 

    final List<AppNavigationDestination>? bottomDestinations;

    final Widget? floatingActionButton;

    @override 
    Widget build(
        BuildContext context, 
        WidgetRef ref, 
    ) {

        final user = ref.watch(
            currentUserProvider, 
        ); 

        final destinations = NavigationConfig.forUser(
            user,
        );

        final bottomDestinations = NavigationConfig.bottom(
            user,
        );        

        return AdaptiveScaffold(

            title: title, 

            destinations: destinations, 

            bottomDestinations: bottomDestinations,

            selectedSection: currentSection, 

            onSectionSelected: onSectionSelected, 

            body: body, 

            floatingActionButton: floatingActionButton, 

        );

    }

}