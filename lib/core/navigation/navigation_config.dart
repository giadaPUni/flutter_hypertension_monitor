import 'package:flutter_hypertension_monitor/core/navigation/app_navigation_destination.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_destinations.dart';
import 'package:flutter_hypertension_monitor/core/user/app_user.dart';

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

                AppDestinations.measurements,

                AppDestinations.statistics,

                AppDestinations.profile,

                AppDestinations.settings,

            ];

        }


        if (user.isDoctor) {

            return [

                AppDestinations.home,

                AppDestinations.patients,

                AppDestinations.measurements,

                AppDestinations.statistics,

                AppDestinations.profile,

                AppDestinations.settings,

            ];

        }


        return AppDestinations.rail;

    }

}