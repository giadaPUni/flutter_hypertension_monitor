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

        this.smoker = false, 

        this.alcoholConsumption = false, 

        this.sedentaryLifestyle = false,

        this.highSaltDiet = false, 

        this.dyslipidemia = false, 

        this.previousStroke = false, 

        this.sleepApnea = false, 

        this.currentTherapy = '', 

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
    bool smoker;

    @HiveField(8)
    bool alcoholConsumption;

    @HiveField(9)
    bool sedentaryLifestyle;

    @HiveField(10)
    bool highSaltDiet;

    @HiveField(11)
    bool dyslipidemia;

    @HiveField(12)
    bool previousStroke;

    @HiveField(13)
    bool sleepApnea;

    @HiveField(14)
    String currentTherapy;    

    @HiveField(15)
    String allergies; 

    @HiveField(16)
    String notes; 


    MedicalHistory copyWith({

        bool? familyHistoryHypertension,
        bool? diabetes,
        bool? cardiovascularDisease,
        bool? kidneyDisease,
        bool? antihypertensiveTherapy,

        bool? smoker,
        bool? alcoholConsumption,
        bool? sedentaryLifestyle,
        bool? highSaltDiet,
        bool? dyslipidemia,
        bool? previousStroke,
        bool? sleepApnea,

        String? currentTherapy,
        String? allergies,
        String? notes,

        }) {

        return MedicalHistory(

            id: id,
            patientId: patientId,

            familyHistoryHypertension:
                familyHistoryHypertension ?? this.familyHistoryHypertension,

            diabetes:
                diabetes ?? this.diabetes,

            cardiovascularDisease:
                cardiovascularDisease ?? this.cardiovascularDisease,

            kidneyDisease:
                kidneyDisease ?? this.kidneyDisease,

            antihypertensiveTherapy:
                antihypertensiveTherapy ?? this.antihypertensiveTherapy,

            smoker:
                smoker ?? this.smoker,

            alcoholConsumption:
                alcoholConsumption ?? this.alcoholConsumption,

            sedentaryLifestyle:
                sedentaryLifestyle ?? this.sedentaryLifestyle,

            highSaltDiet:
                highSaltDiet ?? this.highSaltDiet,

            dyslipidemia:
                dyslipidemia ?? this.dyslipidemia,

            previousStroke:
                previousStroke ?? this.previousStroke,

            sleepApnea:
                sleepApnea ?? this.sleepApnea,

            currentTherapy:
                currentTherapy ?? this.currentTherapy,

            allergies:
                allergies ?? this.allergies,

            notes:
                notes ?? this.notes,

        );

    }


}