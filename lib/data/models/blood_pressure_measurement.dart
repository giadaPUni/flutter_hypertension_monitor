import 'package:uuid/uuid.dart'; 

// measurements 

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

    final String id; 

    final String patientId;


    // both pressures are integer values 
    int systolicPressure; 

    int diastolicPressure; 

    int heartRate; 

    DateTime measurementDateTime; 

    String notes; 

}