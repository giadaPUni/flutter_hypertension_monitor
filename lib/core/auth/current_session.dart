import 'package:hive_ce/hive.dart'; 

/// Stores info about the current session
/// The User's information is loaded from the UserRepository
/// It stores the current session id 

class CurrentSession {

    static const _boxName = 'settings'; 

    static const _currentUserKey = 'current_user_id'; 

    Box get _box => Hive.box(_boxName); 

    Future<void> saveCurrentUserId(
        String userId, 
    ) async {

        await _box.put(
            _currentUserKey, 
            userId, 
        ); 

    }

    String? getCurrentUserId() {

        return _box.get(
            _currentUserKey, 
        ) as String?; 
    }

    Future<void> clearSession() async {

        await _box.delete(
            _currentUserKey, 
        ); 

    }

}