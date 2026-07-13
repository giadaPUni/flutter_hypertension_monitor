import 'package:flutter_hypertension_monitor/core/user/app_user.dart';
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';
//import 'package:flutter_hypertension_monitor/data/models/user.dart';
import 'package:flutter_hypertension_monitor/data/repositories/user_repository.dart';


/*
 * Authentication Service 
 * Functionalities: 
 * verify username/password 
 * create AppUser
 * handling login
*/

class AuthService {

    AuthService({
        required this.userRepository, 
    }); 

    final UserRepository userRepository; 

    AppUser? login(
        String username, 
        String password, 
    ) {

        final user = userRepository.findByUsername(
            username,
        ); 

        if (user == null) {
            return null; 
        }

        if (user.passwordHash != password) {
            return null; 
        }

        return AppUser(

            id: user.id, 

            name: user.username, 

            email: user.username, 

            role: user.patientId != null
                ? UserRole.patient
                : UserRole.doctor, 

            patientId: user.patientId, 

        ); 

    }

}