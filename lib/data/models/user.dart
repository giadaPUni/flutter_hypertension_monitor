import 'package:uuid/uuid.dart'; 
import 'package:hive_ce/hive.dart'; 

import 'package:flutter_hypertension_monitor/core/user/user_role.dart';

part 'user.g.dart'; 

@HiveType(typeId: 0)
class User {

    User({

        String? id, 
        required this.username, 
        required this.email, 
        required this.passwordHash, 
        required this.registrationDate, 
        required this.role, 
        this.patientId, 

    }) : id = id ?? const Uuid().v4(); 

    @HiveField(0)
    final String id; 

    @HiveField(1)
    String username; 

    @HiveField(2)
    String email; 

    @HiveField(3)
    String passwordHash; 

    @HiveField(4)
    DateTime registrationDate; 

    @HiveField(5)
    final String? patientId; 

    @HiveField(6)
    UserRole role; 

}