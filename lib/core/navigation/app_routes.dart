
/*
 * Route names used in the application. 
 * the route paths are all placed here to avoid string duplication and mistakes
*/


abstract final class AppRoutes {

    const AppRoutes._(); 

    static const String login = '/login';

    static const String register = '/register'; 

    static const String home = '/home'; 

    static const String patients = '/patients'; 

    static const String medicalHistory = '/medical-history'; 

    static const String measurements = '/measurements';

    static const String addMeasurement = 'add-measurement';

    static const String statistics = '/statistics'; 

    static const String profile = '/profile'; 

    static const String settings = '/settings'; 


}