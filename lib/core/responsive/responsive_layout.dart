import 'package:flutter/material.dart';

import 'package:flutter_hypertension_monitor/core/responsive/breakpoints.dart';


/// Displays different layouts based on the current screen size.
///
/// If a tablet or desktop layout is not provided, the widget
/// automatically falls back to the next available layout.

class ResponsiveLayout extends StatelessWidget {

    const ResponsiveLayout({

        super.key, 

        required this.mobile, ////

        this.tablet, 

        this.desktop,

    }); 

    final Widget mobile;

    final Widget? tablet; 

    final Widget? desktop; 

    @override 
    Widget build(BuildContext context) {

        if (AppBreakpoints.isDesktop(context)) {
            return desktop ?? tablet ?? mobile; 
        }

        if (AppBreakpoints.isTablet(context)) {
            return tablet ?? mobile; 
        }

        return mobile; 
    }

}
