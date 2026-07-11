import 'package:uuid/uuid.dart'; 
import 'package:hive_ce/hive.dart'; 

part 'medical_history.g.dart'; 


@HiveType(typeId: 2)
class MedicalHistory {

    MedicalHistory({

        String? id, 
        
        required this.patientId, 

        this.familyHistoryHypertension = false, 

        this.diabetes = false, 

        this.cardiovascularDisease = false, 

        this.kidneyDisease = false, 

        this.antihypertensiveTherapy = false, 

        this.allergies = '', 

        this.notes = '', 

    }) : id = id ?? const Uuid().v4(); 

    @HiveField(0)
    final String id; 

    @HiveField(1)
    final String patientId; 

    @HiveField(2)
    bool familyHistoryHypertension; 

    @HiveField(3)
    bool diabetes; 

    @HiveField(4)
    bool cardiovascularDisease; 

    @HiveField(5)
    bool kidneyDisease; 

    @HiveField(6)
    bool antihypertensiveTherapy; 

    @HiveField(7)
    String allergies; 

    @HiveField(8)
    String notes; 

}