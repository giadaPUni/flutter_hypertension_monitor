import 'package:hive_ce/hive.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/core/user/app_user.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/data/repositories/user_repository.dart';


/// Handles persistence and restoration of the authenticated session
/// The User's information is loaded from the UserRepository

class CurrentSession {

    static const _boxName = 'settings'; 

    static const _currentUserKey = 'current_user_id'; 

    Box get _box => Hive.box(_boxName); 


    // saves the user identifier 
    Future<void> saveCurrentUserId(
        String userId, 
    ) async {

        await _box.put(
            _currentUserKey, 
            userId, 
        ); 

    }

    // return the user identifier is a session already exists 
    String? getCurrentUserId() {

        return _box.get(
            _currentUserKey, 
        ) as String?; 
    }


    Future<AppUser?> restoreSession(
        UserRepository repository, 
    ) async {

        final userId = getCurrentUserId(); 

        if (userId == null) {
            return null; 
        }

        final user = repository.findById(
            userId, 
        ); 

        if (user == null) {

            await clearSession(); 

            return null; 

        }

        return AppUser(

            id: userId, 

            name: user.username, 

            email: user.email, 

            role: user.role, 

            patientId: user.patientId, 
        
        ); 

    }


    // remove the current session 
    Future<void> clearSession() async {

        await _box.delete(
            _currentUserKey, 
        ); 

    }

}

final currentSessionProvider = 
    Provider<CurrentSession>(

        (ref) {

            return CurrentSession(); 

        },

    ); 