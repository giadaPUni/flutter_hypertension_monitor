import 'package:hive_ce/hive.dart'; 

import 'package:flutter_hypertension_monitor/data/models/user.dart';


class UserRepository {

    static const String _boxName = 'users'; 

    Box<User> get _box => Hive.box<User>(_boxName); 

    Future<void> save(User user) async {
        await _box.put(user.id, user); 
    }

    Future<void> update(User user) async {
        await _box.put(user.id, user); 
    }

    Future<void> updatePatientId(
        String userId,
        String patientId,
    ) async {


        final user = _box.get(
            userId,
        );


        if(user == null){

            return;

        }


        user.patientId = patientId;


        await _box.put(
            user.id,
            user,
        );

    }


    Future<void> delete(String userId) async {
        await _box.delete(userId); 
    }

    User? findById(String userId) {
        return _box.get(userId); 
    }

    User? findByUsername(String username) {
        return _box.values
            .where(
                (user) => user.username == username,
            )
            .firstOrNull; 
    }

    User? findByEmail(String email) {

        return _box.values
            .where(
                (user) => user.email == email, 
            )
            .firstOrNull; 
            
    }



    User? login(
        String username,
        String passwordHash,
    ) {


    for(final user in _box.values){

        if(user.username == username &&
        user.passwordHash == passwordHash){

            return user;

        }

    }


    return null;


    }


    List<User> findAll() {
        return _box.values.toList(); 
    }

    Future<void> clear() async {
        await _box.clear(); 
    }

    int count() {
        return _box.length; 
    }

}