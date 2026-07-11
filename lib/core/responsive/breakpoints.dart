import 'package:flutter/material.dart'; 

/// Defines the application's responsive breakpoints

/// The layout is determined by the available width

abstract final class AppBreakpoints {

    static const double mobile = 600; 

    static const double table = 840; 

    static const double desktop = 1200; 

    static bool isMobile(BuildContext context) {
        return MediaQuery.sizeOf(context).width < mobile; 
    }

    static bool isTablet(BuildContext context) {
        
        final width = MediaQuery.sizeOf(context).width; 

        return width >= mobile && width < desktop; 
    }

    static bool isDesktop(BuildContext context) {
        return MediaQuery.sizeOf(context).width >= desktop;
    }

    static bool isPortrait(BuildContext context) {
        return MediaQuery.orientationOf(context) == Orientation.portrait;
    }

    static bool isLandscape(BuildContext context) {
        return MediaQuery.orientationOf(context) == Orientation.landscape;
    }

}