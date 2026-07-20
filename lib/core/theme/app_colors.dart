import 'package:flutter/material.dart';

// color palette for the application 

class AppColors {

    AppColors._(); 

    // Primary colors 
    static const Color primary = Color(0xFF1565C0);
    static const Color primaryLight = Color(0xFF5E92F3); 
    static const Color primaryDark = Color(0xFF003C8F); 

    // Secondary colors 
    static const Color secondary = Color(0xFF26A69A); 

    // Backgrounds
    static const Color background = Color(0xFFF5F7FA);  
    static const Color surface = Colors.white; 

    // Text 
    static const Color textPrimary = Color(0xFF212121); 
    static const Color textSecondary = Color(0xFF616161); 

    // Divider - Border 
    static const Color divider = Color(0xFFE0E0E0); 

    // Status colors
    static const Color success = Color(0xFF2E7D32); 
    static const Color warning = Color(0xFFF9A825); 
    static const Color error = Color(0xFFC62828); 

    // Blood pressure colors 
    static const pressureOptimal = Color(0xFF2E7D32);
    static const pressureNormal = Color(0xFF43A047);
    static const pressureHighNormal = Color(0xFFF9A825);
    static const pressureGrade1 = Color(0xFFFB8C00);
    static const pressureGrade2 = Color(0xFFF4511E);
    static const pressureGrade3 = Color(0xFFC62828);
    static const pressureCrisis = Color(0xFF6A1B9A);    


    // Heart rate color 
    static const heartRate = Color(0xFFE53935);

    // Misc 
    static const Color disabled = Color(0xFFBDBDBD); 
}