import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'app_user.dart'; 
import 'user_role.dart'; 

final currentUserProvider = Provider<AppUser?>(

    (ref) {

        return const AppUser(
            id: '001', 
            name: 'Mario Rossi', 
            email: 'mario@gmail.com', 
            role: UserRole.patient, 
            patientId: 'patient_001', 
        ); 

    },

); 