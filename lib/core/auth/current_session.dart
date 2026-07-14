import 'package:hive_ce/hive.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// It manages the authenticated user session

/// The User's information is loaded from the UserRepository

class CurrentSession {

    static const _boxName = 'settings'; 

    static const _currentUserKey = 'current_user_id'; 

    Box get _box => Hive.box(_boxName); 


    // savesthe user identifier 
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