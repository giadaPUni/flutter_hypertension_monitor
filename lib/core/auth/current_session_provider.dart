import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'current_session.dart'; 

final currentSessionProvider = 
    Provider<SessionManager>(

        (ref) {

            return CurrentSession(); 

        },

    ); 