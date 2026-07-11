import 'package:uuid/uuid.dart'; 

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

    final String id; 

    final String patientId; 

    bool familyHistoryHypertension; 

    bool diabetes; 

    bool cardiovascularDisease; 

    bool kidneyDisease; 

    bool antihypertensiveTherapy; 

    String allergies; 

    String notes; 

}