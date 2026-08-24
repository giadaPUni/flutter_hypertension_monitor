import 'package:flutter/material.dart';

// color palette for the application 

class AppColors {

    AppColors._(); 

    // Primary colors 
    static const Color primary = Color(0xFF1565C0);
    static const Color primaryLight = Color(0xFFE3F0FF); // 0xFF5E92F3
    static const Color primaryDark = Color(0xFF0D47A1); //0xFF003C8F

    // Secondary colors 
    static const Color secondary = Color(0xFF26A69A); 
    static const Color secondaryLight = Color(0xFFE2F4F1);
    static const Color secondaryDark = Color(0xFF00796B);

    // Backgrounds
    static const Color background = Color(0xFFF6F8FB);  // 0xFFF5F7FA
    static const Color surface = Colors.white; 
    static const Color surfaceSecondary = Color(0xFFF9FAFC);

    // Text 
    static const Color textPrimary = Color(0xFF17202A);  //0xFF212121
    static const Color textSecondary = Color(0xFF616161);  //0xFF616161
    static const Color textTertiary = Color(0xFF94A3B8);

    // Divider - Border 
    static const Color divider = Color(0xFFE5EAF0);  //0xFFE0E0E0
    static const Color outline = Color(0xFFDCE3EA);

    // Status colors
    static const Color success = Color(0xFF2E7D32); 
    static const Color successLight = Color(0xFFE8F5E9);
    static const Color warning = Color(0xFFF9A825); 
    static const Color warningLight = Color(0xFFFFF8E1);    
    static const Color error = Color(0xFFC62828); 
    static const Color errorLight = Color(0xFFFFEBEE);    

    // Blood pressure colors 
    static const pressureOptimal = Color(0xFF2E7D32);
    static const pressureNormal = Color(0xFF43A047);
    static const pressureHighNormal = Color(0xFFF9A825);
    static const pressureGrade1 = Color(0xFFFB8C00);
    static const pressureGrade2 = Color(0xFFF4511E);
    static const pressureGrade3 = Color(0xFFC62828);
    static const pressureCrisis = Color(0xFF6A1B9A);    


    // Heart rate color 
    static const Color heartRate = Color(0xFFE53935);

    // Misc 
    static const Color disabled = Color(0xFFB0B8C1); //0xFFBDBDBD
}