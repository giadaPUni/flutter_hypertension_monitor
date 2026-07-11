import 'package:flutter/material.dart'; 

import 'app_colors.dart'; 
import 'app_radius.dart'; 
import 'app_text_styles.dart'; 

class AppTheme {

    AppTheme._(); 

    static ThemeData get lightTheme {
        return ThemeData(
            
            useMaterial3: true, 

            colorScheme: ColorScheme(
                brightness: Brightness.light, 

                primary: AppColors.primary, 
                onPrimary: Colors.white, 

                primaryContainer: AppColors.primaryLight, 
                onPrimaryContainer: AppColors.textPrimary, 

                secondary: AppColors.secondary, 
                onSecondary: Colors.white, 

                secondaryContainer: AppColors.secondary.withValues(
                    alpha: 0.15,
                ), 
                onSecondaryContainer: AppColors.textPrimary, 

                error: AppColors.error, 
                onError: Colors.white, 

                surface: AppColors.surface, 
                onSurface: AppColors.textPrimary, 

                outline: AppColors.divider, 

                shadow: Colors.black, 
            ), // end ColorScheme 

            scaffoldBackgroundColor: AppColors.background, 

            textTheme: TextTheme(

                displayLarge: AppTextStyles.displayLarge, 

                headlineLarge: AppTextStyles.headlineLarge, 
                headlineMedium: AppTextStyles.headlineMedium, 

                titleLarge: AppTextStyles.titleLarge, 
                titleMedium: AppTextStyles.titleMedium, 

                bodyLarge: AppTextStyles.bodyLarge, 
                bodyMedium: AppTextStyles.bodyMedium, 
                bodySmall: AppTextStyles.bodySmall, 

                labelLarge: AppTextStyles.labelLarge, 

            ), // end textTheme

            // ----- APP BAR -----
            appBarTheme: AppBarTheme(
                backgroundColor: AppColors.primary, 
                foregroundColor: Colors.white, 

                elevation: 0, 

                centerTitle: true, 

                titleTextStyle: AppTextStyles.titleLarge.copyWith(
                    color: Colors.white, 
                ), 
            ), // end appBarTheme

            // ----- CARD ---- 
            cardTheme: CardThemeData(
                color: AppColors.surface, 

                elevation: 2, 

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        AppRadius.lg, 
                    ), 
                ), 
            ), // end CardThemeData


            // ---- INPUT -----
            inputDecorationTheme: InputDecorationTheme(
                filled: true, 

                fillColor: AppColors.surface, 

                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        AppRadius.md, 
                    ),

                    borderSide: BorderSide.none, 
                ), 

                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        AppRadius.md, 
                    ), 

                    borderSide: BorderSide(
                        color: AppColors.divider, 
                    ), 
                ), 

                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        AppRadius.md, 
                    ), 

                    borderSide: BorderSide(
                        color: AppColors.primary, 
                        width: 2, 
                    ), 
                ),

                labelStyle: AppTextStyles.bodyMedium, 
            ), 

            // ------ BUTTON ----
            filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary, 

                    foregroundColor: Colors.white, 

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppRadius.md, 
                        ), 
                    ), 

                    padding: const EdgeInsets.symmetric(
                        vertical: 14, 
                        horizontal: 24, 
                    ), 
                ),
            ), 

            outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary, 

                    side: const BorderSide(
                        color: AppColors.primary, 
                    ), 

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppRadius.md, 
                        ), 
                    ), 
                ), 
            ), 


            // ----- DIVIDER ---
            dividerTheme: const DividerThemeData(
                color: AppColors.divider, 
                thickness: 1, 
            ), 

        );  // end return 

    } // end lightTheme 
}