import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'current_session.dart'; 

final currentSessionProvider = 
    Provider<CurrentSession>(

        (ref) {

            return CurrentSession(); 

        },

    ); 