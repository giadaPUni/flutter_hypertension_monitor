import 'package:flutter/material.dart';

import 'app_colors.dart'; 

// text styles used in the application 

class AppTextStyles {
    
    AppTextStyles._(); 

    static const TextStyle displayLarge = TextStyle(
        fontSize: 32, 
        fontWeight: FontWeight.bold, 
        color: AppColors.textPrimary, 
    ); 

    static const TextStyle headlineLarge = TextStyle(
        fontSize: 24, 
        fontWeight: FontWeight.w700, 
        color: AppColors.textPrimary, 
    ); 

    static const TextStyle headlineMedium = TextStyle(
        fontSize: 20, 
        fontWeight: FontWeight.w600, 
        color: AppColors.textPrimary, 
    ); 

    static const TextStyle titleLarge = TextStyle(
        fontSize: 18, 
        fontWeight: FontWeight.w600, 
        color: AppColors.textPrimary,
    ); 

    static const TextStyle titleMedium = TextStyle(
        fontSize: 16, 
        fontWeight: FontWeight.w600, 
        color: AppColors.textPrimary,
    ); 

    static const TextStyle bodyLarge = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400, 
        color: AppColors.textPrimary, 
        height: 1.4, 
    ); 

    static const TextStyle bodyMedium = TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400, 
        color: AppColors.textPrimary, 
        height: 1.4, 
    ); 

    static const TextStyle bodySmall = TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400, 
        color: AppColors.textSecondary, 
    );     

    static const TextStyle labelLarge = TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600, 
        color: AppColors.primary, 
    );     

}