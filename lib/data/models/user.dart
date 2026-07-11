import 'package:uuid/uuid.dart'; 

class User {

    User({

        String? id, 
        required this.username, 
        required this.passwordHash, 
        required this.registrationDate, 
        required this.patientId, 

    }) : id = id ?? const Uuid().v4(); 

    final String id; 

    String username; 

    String passwordHash; 

    DateTime registrationDate; 

    final String patientId; 

}