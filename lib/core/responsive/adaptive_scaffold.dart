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

    final Widget? title; 

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
                title: title, 
                actions: actions, 
            ), 
            drawer: _buildDrawer(context), 
            body: body, 
            floatingActionButton: floatingActionButton, 
        ); 
    }

    Widget _buildTabletScaffold(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: title, 
                actions: actions, 
            ), 
            drawer: _buildDrawer(context), 

            body: Row(

                children: [
                    _buildNavigationRail(
                        extended: false,
                    ), 

                    const VerticalDivider(width: 1),

                    Expanded(
                        child: body, 
                    ), 
                ],
            ),

            floatingActionButton: floatingActionButton, 
        ); 
    }

    Widget _buildDesktopScaffold(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: title, 
                actions: actions, 
            ), 
            /// drawer: null, 
            body: Row(
                children: [

                    _buildNavigationRail(
                        extended: true, 
                    ),

                    const VerticalDivider(width: 1), 

                    Expanded(
                        child: body, 
                    ),
                ],
            ),

            floatingActionButton: floatingActionButton, 
        ); 
    }


    Widget _buildDrawer(BuildContext context) {
        return Drawer(
            child: SafeArea(
                child: ListView.builder(
                    itemCount: destinations.length, 
                    itemBuilder: (context, index) {
                        final destionation = destinations[index]; 

                        return ListTile(
                            leading: Icon(
                                index == selectedIndex
                                    ? destination.selectedIcon ?? destination.icon
                                    : destination.icon, 
                            ), 
                            title: Text(destination.label), 
                            selected: index == selectedIndex, 
                            onTap: () {
                                Navigator.of(context).pop(); 
                                onDestionationSelected(index); 
                            },
                        );
                    },
                ),
            ),
        );
    }


    Widget _buildNavigationRail({
        required bool extended, 
    }) {
        return NavigationRail(
            extended: extended,

            selectedIndex: selectedIndex, 

            onDestionationSelected: onDestionationSelected, 

            destinations: destinations
                .map(
                    (destination) => NavigationRailDestination(
                        icon: Icon(destination.icon), 

                        selectedIcon: Icon(
                            destination.selectedIcon ?? destination.icon, 
                        ), 

                        label: Text(destination.label),
                    ), 
                )
                .toList(),
        ); 
    }

}