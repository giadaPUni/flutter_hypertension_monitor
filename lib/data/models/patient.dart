import 'package:uuid/uuid.dart'; 


// Anagraphic Data 

class Patient {
    Patient({
        String? id, 
        required this.firstName, 
        required this.lastName,
        required this.birthDate, 
        required this.sex, 
        required this.height, 
        required this.weight, 
    }) : id = id ?? const Uuid().v4(); 

    final String id; 

    String firstName; 

    String lastName; 

    DateTime birthDate; 

    String sex; 

    double height; 

    double weight; 

    // Body Mass Index (BMI)

    // aggiungere if or case -> in base a come vengono 
    // inserite le misure 

    // height is stored in cm not meters. 

    // getter 
    double get bmi {
        final heightInMeters = height / 100; 

        return weight / (heightInMeters * heightInMeters); 
    }

}