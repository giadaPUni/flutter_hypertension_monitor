import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart'; 

// text styles used in the application 

class AppTextStyles {
    
    AppTextStyles._(); 

    // ---- Display ---- 

    static final TextStyle displayLarge = GoogleFonts.poppins(
        fontSize: 32, 
        fontWeight: FontWeight.bold, 
        color: AppColors.textPrimary, 
        height: 1.15,
    ); 

    // ---- Headlines ----

    static final TextStyle headlineLarge = GoogleFonts.poppins(
        fontSize: 24, 
        fontWeight: FontWeight.w700, 
        color: AppColors.textPrimary,
        height: 1.2, 
    ); 

    static final TextStyle headlineMedium = GoogleFonts.poppins(
        fontSize: 20, 
        fontWeight: FontWeight.w600, 
        color: AppColors.textPrimary, 
        height: 1.25,
    ); 

    static final TextStyle headlineSmall = GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
    );


    // ---- Titles --- 

    static final TextStyle titleLarge = GoogleFonts.poppins(
        fontSize: 18, 
        fontWeight: FontWeight.w600, 
        color: AppColors.textPrimary,
        height: 1.3,
    ); 

    static final TextStyle titleMedium = GoogleFonts.poppins(
        fontSize: 16, 
        fontWeight: FontWeight.w600, 
        color: AppColors.textPrimary,
        height: 1.3,
    ); 

    static final TextStyle titleSmall = GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        height: 1.3,
    );


    // ---- Body ---- 

    static final TextStyle bodyLarge = GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400, 
        color: AppColors.textPrimary, 
        height: 1.4, 
    ); 

    static final TextStyle bodyMedium = GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400, 
        color: AppColors.textSecondary, 
        height: 1.4, 
    ); 

    static final TextStyle bodySmall = GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400, 
        color: AppColors.textTertiary, 
        height: 1.4, 
    );     


    // ---- Labels --- 

    static final TextStyle labelLarge = GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600, 
        color: AppColors.primary, 
        height: 1.2, 
    );   

    static final TextStyle labelMedium = GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        height: 1.2,
    );

    // ---- Clinical / metric values ----

    static final TextStyle metricLarge = GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.1,
    );

    static final TextStyle metricMedium = GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.1,
    );

    static final TextStyle metricUnit = GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.2,
    );

}