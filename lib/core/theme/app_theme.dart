import 'package:flutter/material.dart'; 

import 'app_colors.dart'; 
import 'app_radius.dart'; 
import 'app_text_styles.dart'; 

class AppTheme {

    AppTheme._(); 

    static ThemeData get lightTheme {
        return ThemeData(
            
            useMaterial3: true, 

            visualDensity: VisualDensity.adaptivePlatformDensity,

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

                surfaceTint: Colors.transparent,
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
                surfaceTintColor: Colors.transparent, 

                elevation: 0, 

                centerTitle: true, 

                titleTextStyle: AppTextStyles.titleLarge.copyWith(
                    color: Colors.white, 
                ), 
            ), // end appBarTheme

            // ----- CARD ---- 
            cardTheme: CardThemeData(

                color: AppColors.surface, 

                elevation: 0, 
                
                shadowColor: Colors.black12,
                
                clipBehavior: Clip.antiAlias,

                margin: const EdgeInsets.symmetric(
                    vertical: 8, 
                ),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        AppRadius.lg, 
                    ), 
                    side: const BorderSide(
                        color: AppColors.divider, 
                    ),
                ), 
            ), // end CardThemeData


            // ---- INPUT -----
            inputDecorationTheme: InputDecorationTheme(
                filled: true, 

                fillColor: AppColors.surface, 

                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                ),

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

                    textStyle: AppTextStyles.titleMedium,

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


            floatingActionButtonTheme:
                const FloatingActionButtonThemeData(

                    elevation: 2,

                    shape: CircleBorder(),

                ),

            snackBarTheme: SnackBarThemeData(

                behavior: SnackBarBehavior.floating,

                shape: RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            AppRadius.md,
                        ),

                ),

            ),
            
            dialogTheme: DialogThemeData(

                shape: RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            AppRadius.lg,
                        ),

                ),

            ),            


            // ----- DIVIDER ---
            dividerTheme: const DividerThemeData(
                color: AppColors.divider, 
                thickness: .7, 
            ), 

        );  // end return 

    } // end lightTheme 
}