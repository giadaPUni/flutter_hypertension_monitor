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

            // ---- Color Scheme ----
            colorScheme: ColorScheme.light(

                //brightness: Brightness.light, 

                primary: AppColors.primary, 
                onPrimary: Colors.white, 

                primaryContainer: AppColors.primaryLight, 
                onPrimaryContainer: AppColors.textPrimary, 

                secondary: AppColors.secondary, 
                onSecondary: Colors.white, 

                /*
                secondaryContainer: AppColors.secondary.withValues(
                    alpha: 0.15,
                ), 
                onSecondaryContainer: AppColors.textPrimary, 
                */
                secondaryContainer: AppColors.secondaryLight,
                onSecondaryContainer: AppColors.secondaryDark,


                error: AppColors.error, 
                onError: Colors.white, 

                surface: AppColors.surface, 
                onSurface: AppColors.textPrimary, 

                //outline: AppColors.divider, 
                outline: AppColors.outline,

                shadow: Colors.black, 

                surfaceTint: Colors.transparent,
            ), 


            // ---- General ---- 
            scaffoldBackgroundColor: AppColors.background, 
            splashFactory: InkSparkle.splashFactory,

            // ---- Text ---- 
            textTheme: TextTheme(

                displayLarge: AppTextStyles.displayLarge, 

                headlineLarge: AppTextStyles.headlineLarge, 
                headlineMedium: AppTextStyles.headlineMedium, 
                headlineSmall: AppTextStyles.headlineSmall,

                titleLarge: AppTextStyles.titleLarge, 
                titleMedium: AppTextStyles.titleMedium, 
                titleSmall: AppTextStyles.titleSmall,

                bodyLarge: AppTextStyles.bodyLarge, 
                bodyMedium: AppTextStyles.bodyMedium, 
                bodySmall: AppTextStyles.bodySmall, 

                labelLarge: AppTextStyles.labelLarge, 
                labelMedium: AppTextStyles.labelMedium,

            ), 

            // ----- App Bar -----
            appBarTheme: AppBarTheme(
                //backgroundColor: AppColors.primary, 
                backgroundColor: AppColors.background, 
                //foregroundColor: Colors.white, 
                foregroundColor: AppColors.textPrimary, 
                surfaceTintColor: Colors.transparent, 

                elevation: 0, 

                scrolledUnderElevation: 0,

                centerTitle: false, 

                titleSpacing: 20,

                toolbarHeight: 64,

                titleTextStyle: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary, 
                ), 

                iconTheme: const IconThemeData(
                    color: AppColors.textPrimary, 
                    size: 22, 
                ), 
            ), 

            // ----- Card ---- 
            cardTheme: CardThemeData(

                color: AppColors.surface, 

                elevation: 0, 
                
                shadowColor: Colors.black12,
                
                surfaceTintColor: Colors.transparent,

                clipBehavior: Clip.antiAlias,

                margin: const EdgeInsets.symmetric(
                    vertical: 6, 
                ),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        //AppRadius.lg, 
                        AppRadius.xl, 
                    ), 
                    /*
                    side: const BorderSide(
                        color: AppColors.divider, 
                    ),
                    */
                ), 
            ), 


            // ---- Input -----
            inputDecorationTheme: InputDecorationTheme(

                filled: true, 

                fillColor: AppColors.surface, 

                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
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
                        color: AppColors.outline, 
                    ), 
                ), 

                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        AppRadius.md, 
                    ), 

                    borderSide: BorderSide(
                        color: AppColors.primary, 
                        width: 1.5, 
                    ), 
                ),

                errorBorder: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(
                        AppRadius.md,
                    ),

                    borderSide: const BorderSide(
                        color: AppColors.error,
                    ),
                ),

                focusedErrorBorder: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(
                        AppRadius.md,
                    ),

                    borderSide: const BorderSide(
                        color: AppColors.error,
                        width: 1.5,
                    ),
                ),


                labelStyle: AppTextStyles.bodyMedium, 
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                ),

                floatingLabelStyle: AppTextStyles.labelLarge,

                prefixIconColor: AppColors.textSecondary,

                suffixIconColor: AppColors.textSecondary,                
            ), 

            // ------ Filled Button ----

            filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary, 

                    foregroundColor: Colors.white, 
                    
                    disabledBackgroundColor: AppColors.disabled,

                    elevation: 0, 

                    textStyle: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white, 
                    ),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppRadius.md, 
                        ), 
                    ), 

                    padding: const EdgeInsets.symmetric(
                        vertical: 22, //14, 
                        horizontal: 14, //24, 
                    ), 

                    minimumSize: const Size(
                        0, 
                        48,
                    ), 
                ),
            ), 


            // ---- Outlined button --- 
            outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary, 
                    backgroundColor: Colors.transparent,

                    elevation: 0,

                    minimumSize: const Size(
                        0,
                        48,
                    ),

                    padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                    ),

                    textStyle: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primary,
                    ),

                    side: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                    ),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppRadius.md, 
                        ), 
                    ), 
                ), 
            ), 

            // --- Text Button --- 
            textButtonTheme: TextButtonThemeData(

                style: TextButton.styleFrom(

                    foregroundColor: AppColors.primary,

                    padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                    ),

                    textStyle: AppTextStyles.labelLarge,

                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(
                            AppRadius.sm,
                        ),
                    ),
                ),
            ),

            // --- Floating Action Button ---- 
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                    
                    backgroundColor: AppColors.primary,

                    foregroundColor: Colors.white,

                    elevation: 3,

                    highlightElevation: 4,

                    //shape: CircleBorder(),

                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(
                            AppRadius.lg,
                        ),
                    ),

                    extendedPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                    ),

                    extendedTextStyle: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                    ),

                ),

            // ---- Navigation Bar ---- 

            navigationBarTheme: NavigationBarThemeData(

                backgroundColor: AppColors.surface,

                surfaceTintColor: Colors.transparent,

                elevation: 0,

                height: 72,

                indicatorColor: AppColors.primaryLight,

                labelTextStyle: WidgetStatePropertyAll(
                    AppTextStyles.labelMedium,
                ),

                iconTheme: const WidgetStatePropertyAll(
                    IconThemeData(
                        size: 23,
                    ),
                ),
            ),


            // ---- Navigation Rail ---
            
            navigationRailTheme: NavigationRailThemeData(

                backgroundColor: AppColors.surface,

                elevation: 0,

                indicatorColor: AppColors.primaryLight,

                selectedIconTheme: const IconThemeData(
                    color: AppColors.primaryDark,
                    size: 23,
                ),

                unselectedIconTheme: const IconThemeData(
                    color: AppColors.textSecondary,
                    size: 22,
                ),

                selectedLabelTextStyle:
                    AppTextStyles.labelLarge.copyWith(
                        color: AppColors.primaryDark,
                    ),

                unselectedLabelTextStyle:
                    AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                    ),

                groupAlignment: -0.8,

                useIndicator: true,
            ), 

            // ---- Drawer ---- 

            drawerTheme: DrawerThemeData(

                backgroundColor: AppColors.surface,

                surfaceTintColor: Colors.transparent,

                elevation: 1,

                width: 300,

                shape: const RoundedRectangleBorder(

                    borderRadius: BorderRadius.only(

                        topRight: Radius.circular(
                            AppRadius.xl,
                        ),

                        bottomRight: Radius.circular(
                            AppRadius.xl,
                        ),
                    ),
                ),
            ),

            // --- List tile ---- 
            listTileTheme: ListTileThemeData(

                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                ),

                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(
                        AppRadius.md,
                    ),
                ),

                iconColor: AppColors.textSecondary,

                textColor: AppColors.textPrimary,

                titleTextStyle: AppTextStyles.titleMedium,

                subtitleTextStyle: AppTextStyles.bodySmall,

                selectedColor: AppColors.primaryDark,

                selectedTileColor: AppColors.primaryLight,
            ),


            // ---- Snack Bar ---- 
            snackBarTheme: SnackBarThemeData(

                behavior: SnackBarBehavior.floating,
                
                backgroundColor: AppColors.textPrimary,
                
                contentTextStyle:
                    AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                    ),

                elevation: 3,

                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(
                        AppRadius.md,
                    ),

                ),

            ),
            
            // --- Dialog ---- 
            dialogTheme: DialogThemeData(

                backgroundColor: AppColors.surface,

                surfaceTintColor: Colors.transparent,

                elevation: 8,

                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(
                        AppRadius.lg,
                    ),

                ),

                titleTextStyle: AppTextStyles.headlineSmall,

                contentTextStyle: AppTextStyles.bodyMedium,

            ),            


            // ----- Divider ---
            dividerTheme: const DividerThemeData(
                color: AppColors.divider, 
                thickness: 0.7, 
                space: 1, 
            ), 


            // ---- Icons ---- 
            iconTheme: const IconThemeData(
                color: AppColors.textSecondary, 
                size: 22, 
            ), 

        );   

    } // end lightTheme 
}