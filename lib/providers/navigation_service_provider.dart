import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/core/navigation/navigation_service.dart';


/*
* NavigationService Provider
* (to avoid "NavigationService()" manually created in more points)
*/


final navigationServiceProvider = 
    Provider<NavigationService>(
        (ref) {
            return NavigationService(); 
        },
    );


