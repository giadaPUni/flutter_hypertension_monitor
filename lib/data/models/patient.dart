import 'package:uuid/uuid.dart'; 
import 'package:hive_ce/hive.dart'; 


part 'patient.g.dart'; 

// Anagraphic Data 

@HiveType(typeId: 1)        // class identifier 
class Patient {

    Patient({
        String? id, 
        required this.ownerId, 
        required this.firstName, 
        required this.lastName,
        required this.birthDate, 
        required this.sex, 
        required this.height, 
        required this.weight, 
    }) : id = id ?? const Uuid().v4(); 

    @HiveField(0)
    final String id; 

    @HiveField(1)
    final String ownerId; 

    @HiveField(2)
    String firstName; 

    @HiveField(3)
    String lastName; 

    @HiveField(4)
    DateTime birthDate; 

    @HiveField(5)
    String sex; 

    @HiveField(6)
    double height; 

    @HiveField(7)
    double weight; 


    // Body Mass Index (BMI)
    // height is stored in cm not meters. 
    // getter 
    double get bmi {

        if (height <= 0 || weight <= 0) {
            return 0;
        }

        final heightInMeters = height / 100; 

        return weight / (heightInMeters * heightInMeters); 
    }

}