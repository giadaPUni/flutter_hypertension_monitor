import 'package:flutter_hypertension_monitor/core/navigation/app_navigation_destination.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_destinations.dart';
import 'package:flutter_hypertension_monitor/core/user/app_user.dart';


/*
* Menu structure according to the User (simple user or user AND patient)
*/

abstract final class NavigationConfig {


    static List<AppNavigationDestination> bottom(
        AppUser? user,
    ) {

        return [
            AppDestinations.home,
            AppDestinations.measurements,
            AppDestinations.statistics,
        ];

    }

    static List<AppNavigationDestination> drawer(
        AppUser? user,
    ) {
        return AppDestinations.rail;
    }   




    static List<AppNavigationDestination> forUser(
        AppUser? user,
    ) {

        if (user == null) {

            return AppDestinations.rail;

        }


        if (user.isPatient) {

            return [

                AppDestinations.home,

                AppDestinations.patients, 

                //AppDestinations.personalInformation, 

                AppDestinations.measurements,

                AppDestinations.medicalHistory, 

                AppDestinations.statistics,

                AppDestinations.profile,

                AppDestinations.settings,
                
                AppDestinations.logout,

            ];

        }


        if (user.isUser) {

            return [

                AppDestinations.home,

                AppDestinations.patients,

                AppDestinations.measurements,
                
                AppDestinations.medicalHistory,

                AppDestinations.statistics,

                AppDestinations.profile,

                AppDestinations.settings,

                AppDestinations.logout,

            ];

        }


        return AppDestinations.rail;

    }

}