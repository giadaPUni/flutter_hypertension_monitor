import 'package:flutter_hypertension_monitor/core/user/app_user.dart';
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';
import 'package:flutter_hypertension_monitor/data/models/user.dart';
import 'package:flutter_hypertension_monitor/data/repositories/user_repository.dart';

/*
 * Authentication Service 
 * Functionalities: 
 * verify username/password 
 * create AppUser
 * handle login
 * register new username/users
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

            email: user.email, 

            role: user.role, 

            patientId: user.patientId, 

        ); 

    }

    Future<AppUser?> register({

        required String username, 

        required String email, 

        required String password, 

        required UserRole role, 

        String? patientId, 

    }) async {

        // to avoid accounts with the same username or the same email 

        final existingUser = userRepository.findByUsername(
            username,
        ); 

        if (existingUser != null) {
            return null; 
        }


        final existingEmail = userRepository.findByEmail(
            email, 
        ); 

        if (existingEmail != null) {
            return null;
        }


        final user = User(

            username: username,

            email: email, 
            
            passwordHash: password, 

            registrationDate: DateTime.now(), 

            role: role, 

            patientId: patientId,
        ); 

        await userRepository.save(
            user,
        ); 
    

        return AppUser(

            id: user.id, 

            name: user.username, 

            email: user.email, 

            role: user.role, 

            patientId: user.patientId,

        ); 

    }

}