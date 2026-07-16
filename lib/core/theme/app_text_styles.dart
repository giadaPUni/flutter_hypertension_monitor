import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart'; 

// text styles used in the application 

class AppTextStyles {
    
    AppTextStyles._(); 

    static final TextStyle displayLarge = GoogleFonts.poppins(
        fontSize: 32, 
        fontWeight: FontWeight.bold, 
        color: AppColors.textPrimary, 
    ); 

    static final TextStyle headlineLarge = GoogleFonts.poppins(
        fontSize: 24, 
        fontWeight: FontWeight.w700, 
        color: AppColors.textPrimary, 
    ); 

    static final TextStyle headlineMedium = GoogleFonts.poppins(
        fontSize: 20, 
        fontWeight: FontWeight.w600, 
        color: AppColors.textPrimary, 
    ); 

    static final TextStyle titleLarge = GoogleFonts.poppins(
        fontSize: 18, 
        fontWeight: FontWeight.w600, 
        color: AppColors.textPrimary,
    ); 

    static final TextStyle titleMedium = GoogleFonts.poppins(
        fontSize: 16, 
        fontWeight: FontWeight.w600, 
        color: AppColors.textPrimary,
    ); 

    static final TextStyle bodyLarge = GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400, 
        color: AppColors.textPrimary, 
        height: 1.4, 
    ); 

    static final TextStyle bodyMedium = GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400, 
        color: AppColors.textPrimary, 
        height: 1.4, 
    ); 

    static final TextStyle bodySmall = GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400, 
        color: AppColors.textSecondary, 
    );     

    static final TextStyle labelLarge = GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600, 
        color: AppColors.primary, 
    );     

}