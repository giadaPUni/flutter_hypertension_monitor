import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/core/responsive/breakpoints.dart';
import 'package:flutter_hypertension_monitor/core/responsive/navigation_type.dart';
import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_destinations.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_navigation_destination.dart';
import 'package:flutter_hypertension_monitor/core/responsive/adaptive_scaffold.dart';

class AdaptiveScaffold extends StatelessWidget {

    const AdaptiveScaffold({
        super.key, 
        required this.title, 
        required this.body, 
        required this.selectedSection, 
        required this.onSectionSelected,
        required this.destinations, 
        required this.bottomDestinations, 
        this.floatingActionButton, 
        this.actions, 
    }); 

    final Widget? title; 

    final Widget body;

    final NavigationSection selectedSection; 

    final List<AppNavigationDestination> destinations;

    final List<AppNavigationDestination> bottomDestinations;

    final ValueChanged<NavigationSection> onSectionSelected; 

    final Widget? floatingActionButton; 

    final List<Widget>? actions; 

    @override
    Widget build(BuildContext context) {

        


        final navigationType = _navigationType(context); 

        /*
        final destinations = _destinationsFor(
            navigationType,
        );    

        */ 



        switch (navigationType) {
            case NavigationType.bottomNavigationBar:
                return _buildMobileScaffold(
                    context, 
                    destinations,
                ); 

            case NavigationType.navigationRail:
                return _buildTabletScaffold(
                    context,
                    destinations, 
                ); 
            
            case NavigationType.navigationRailExtended:
                return _buildDesktopScaffold(
                    context, 
                    destinations, 
                ); 
        }
    }

    NavigationType _navigationType(BuildContext context) {
        

        if (!AppBreakpoints.canShowNavigationRail(context)) {
            return NavigationType.bottomNavigationBar;
        }        

        if (AppBreakpoints.isDesktop(context)) {
            return NavigationType.navigationRailExtended;
        }

        if (AppBreakpoints.isTablet(context)) {
            return NavigationType.navigationRail; 
        }

        return NavigationType.bottomNavigationBar; 
    }

/*
    List<AppNavigationDestination> _destinationsFor(
        NavigationType type,
    ) {

        switch(type){

            case NavigationType.bottomNavigationBar:
                return AppDestinations.mobileBottom;

            case NavigationType.navigationRail:
            case NavigationType.navigationRailExtended:
                return AppDestinations.rail;
        }

    }
*/

    int _selectedIndex(
        List<AppNavigationDestination> destinations,
    ) {

        return destinations.indexWhere(
            (destination) =>
                destination.section == selectedSection,
        );

    }

    Widget _buildMobileScaffold(
        BuildContext context, 
        List<AppNavigationDestination> destinations, 
    ) {
        return Scaffold(

            resizeToAvoidBottomInset: true,

            appBar: AppBar(
                title: title, 
                actions: actions, 
            ), 

            drawer: _buildDrawer(
                context, 
                destinations,
            ), 

            body: body,

            floatingActionButton: floatingActionButton, 

            bottomNavigationBar: MediaQuery.sizeOf(context).height > 250
                ? _buildBottomNavigationBar(bottomDestinations)
                : null,
            
        ); 
    }

    Widget _buildTabletScaffold(
        BuildContext context, 
        List<AppNavigationDestination> destinations,
    ) {
        return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: title, 
                actions: actions, 
            ), 
            drawer: _buildDrawer(
                context, 
                destinations, 
            ), 

            body: Row(
                children: [

                    SizedBox(
                        height: double.infinity,
                        child: _buildNavigationRail(
                            extended: false,
                            destinations: destinations, 
                        ),
                    ),

                    const VerticalDivider(width: 1), 

                    Expanded(
                        child: body, 
                    ),
                ],
            ),

            floatingActionButton: null, 
        ); 
    }

    Widget _buildDesktopScaffold(
        BuildContext context, 
        List<AppNavigationDestination> destinations,
    ) {
        return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: title, 
                actions: actions, 
            ), 
            
            body: Row(
                children: [

                    SizedBox(
                        height: double.infinity,
                        child: _buildNavigationRail(
                            extended: true,
                            destinations: destinations, 
                        ),
                    ),

                    const VerticalDivider(width: 1), 

                    Expanded(
                        child: body, 
                    ),
                ],
            ),

            floatingActionButton: null, 
        ); 
    }


    Widget _buildDrawer(
        BuildContext context, 
        List<AppNavigationDestination> destinations,
    ) {
        return Drawer(
            child: SafeArea(
                child: ListView.builder(
                    itemCount: destinations.length, 
                    itemBuilder: (context, index) {
                        final destination = destinations[index]; 

                        return ListTile(

                            leading: Icon(
                                destination.section == selectedSection
                                    ? destination.selectedIcon ?? destination.icon
                                    : destination.icon, 
                            ), 

                            title: Text(destination.label), 

                            selected: destination.section == selectedSection,
                            
                            onTap: () {
                                Navigator.of(context).pop(); 
                                onSectionSelected(destination.section); 
                            },
                        );
                    },
                ),
            ),
        );
    }


    Widget _buildNavigationRail({
        required bool extended, 
        required List<AppNavigationDestination> destinations,
    }) {
        return NavigationRail(
            extended: extended,

            selectedIndex: _selectedIndex(destinations), 

            onDestinationSelected: (index) {

                onSectionSelected(
                    destinations[index].section, 
                );
            },

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

    BottomNavigationBar _buildBottomNavigationBar(
        List<AppNavigationDestination> destinations, 
    ) {
        
        return BottomNavigationBar(

            currentIndex: _selectedIndex(destinations) >= 0
                ? _selectedIndex(destinations)
                : 0,

            onTap: (index){

                onSectionSelected(
                    destinations[index].section, 
                ); 

            }, 

            type: BottomNavigationBarType.fixed, 

            items: destinations.map(

                (destination) {

                    return BottomNavigationBarItem(

                        icon: Icon(destination.icon), 

                        activeIcon: Icon(
                            destination.selectedIcon ?? destination.icon, 
                        ), 

                        label: destination.label, 
                    
                    );
                    
                },
            
            ).toList(), 

        );
    }

}