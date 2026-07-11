import 'package:uuid/uuid.dart'; 
import 'package:hive_ce/hive.dart'; 

part 'blood_pressure_measurement.g.dart'; 

// measurements 

@HiveType(typeId: 3)
class BloodPressureMeasurement {

    BloodPressureMeasurement({

        String? id, 

        required this.patientId, 
        required this.systolicPressure, 
        required this.diastolicPressure, 
        required this.heartRate, 
        DateTime? measurementDateTime, 
        this.notes = '', 

    }) : id = id ?? const Uuid().v4(), 
        measurementDateTime = measurementDateTime ?? DateTime.now(); 

    @HiveField(0)
    final String id; 

    @HiveField(1)
    final String patientId;


    // both pressures are integer values 
    @HiveField(2)
    int systolicPressure; 

    @HiveField(3)
    int diastolicPressure; 

    @HiveField(4)
    int heartRate; 

    @HiveField(5)
    DateTime measurementDateTime; 

    @HiveField(6)
    String notes; 

}