import 'package:hive_ce_flutter/hive_flutter.dart';

import '../models/user.dart'; 
import '../models/patient.dart'; 
import '../models/medical_history.dart'; 
import '../models/blood_pressure_measurement.dart'; 

class HiveInitializer {

    static Future<void> initialize() async {

        await Hive.initFlutter(); 

        Hive.registerAdapter(UserAdapter()); 
        Hive.registerAdapter(PatientAdapter()); 
        Hive.registerAdapter(MedicalHistoryAdapter()); 
        Hive.registerAdapter(BloodPressureMeasurementAdapter());

        await _openBoxes(); 

    }

    static Future<void> _openBoxes() async {

        // credentials and link to the patient
        await Hive.openBox<User>('users'); 

        // anagraphic 
        await Hive.openBox<Patient>('patients'); 

        // clinical data and medical history 
        await Hive.openBox<MedicalHistory>('medical_histories'); 

        // measurements 
        await Hive.openBox<BloodPressureMeasurement>('blood_pressure_measurements'); 

        // settings 
        await Hive.openBox('settings');

    }

}