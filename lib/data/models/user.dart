import 'package:uuid/uuid.dart'; 
import 'package:hive_ce/hive.dart'; 

part 'user.g.dart'; 

@HiveType(typeId: 0)
class User {

    User({

        String? id, 
        required this.username, 
        required this.passwordHash, 
        required this.registrationDate, 
        required this.patientId, 

    }) : id = id ?? const Uuid().v4(); 

    @HiveField(0)
    final String id; 

    @HiveField(1)
    String username; 

    @HiveField(2)
    String passwordHash; 

    @HiveField(3)
    DateTime registrationDate; 

    @HiveField(4)
    final String patientId; 

}