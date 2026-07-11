import 'package:flutter/material.dart'; 

import 'package:flutter_hypertension_monitor/core/navigation/app_navigation_destination.dart';
import 'package:flutter_hypertension_monitor/core/responsive/breakpoints.dart';
import 'package:flutter_hypertension_monitor/core/responsive/navigation_type.dart';


class AdaptiveScaffold extends StatelessWidget {

    const AdaptiveScaffold({
        super.key, 
        required this.title, 
        required this.body, 
        required this.destinations, 
        required this.selectedIndex, 
        required this.onDestionationSelected, 
        this.floatingActionButton, 
        this.actions, 
    }); 

    final String title; 

    final Widget body;

    final List<AppNavigationDestination> destinations; 

    final int selectedIndex; 

    final ValueChanged<int> onDestionationSelected; 

    final Widget? floatingActionButton; 

    final List<Widget>? actions; 

    @override
    Widget build(BuildContext context) {
        final navigationType = _navigationType(context); 

        switch (navigationType) {
            case NavigationType.bottomNavigationBar:
                return _buildMobileScaffold(context); 

            case NavigationType.navigationRail:
                return _buildTabletScaffold(context); 
            
            case NavigationType.navigationRailExtended:
                return _buildDesktopScaffold(context); 
        }
    }

    NavigationType _navigationType(BuildContext context) {
        if (AppBreakpoints.isDesktop(context)) {
            return NavigationType.navigationRailExtended;
        }

        if (AppBreakpoints.isTablet(context)) {
            return NavigationType.navigationRail; 
        }

        return NavigationType.bottomNavigationBar; 
    }

    Widget _buildMobileScaffold(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(title), 
                actions: actions, 
            ), 
            body: body, 
            floatingActionButton: floatingActionButton, 
        ); 
    }

    Widget _buildTabletScaffold(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(title), 
                actions: actions, 
            ), 
            body: body, 
            floatingActionButton: floatingActionButton, 
        ); 
    }

    Widget _buildDesktopScaffold(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(title), 
                actions: actions, 
            ), 
            body: body, 
            floatingActionButton: floatingActionButton, 
        ); 
    }

}