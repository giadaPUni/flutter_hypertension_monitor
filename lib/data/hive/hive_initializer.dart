import 'package:hive_ce_flutter/hive_flutter.dart';

import '../models/user.dart'; 
import '../models/patient.dart'; 
import '../models/medical_history.dart'; 
import '../models/blood_pressure_measurement.dart'; 
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';

class HiveInitializer {

    static Future<void> initialize() async {

        await Hive.initFlutter(); 

        Hive.registerAdapter(UserRoleAdapter());
        Hive.registerAdapter(UserAdapter()); 
        Hive.registerAdapter(PatientAdapter()); 
        Hive.registerAdapter(MedicalHistoryAdapter()); 
        Hive.registerAdapter(BloodPressureMeasurementAdapter());

        await _openBoxes(); 

        await _createInitialData();

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

    static Future<void> _createInitialData() async {

        final patientBox = Hive.box<Patient>(
            'patients',
        );


        if (patientBox.isEmpty) {

            final patient = Patient(
                id: 'patient_001',
                firstName: 'Mario',
                lastName: 'Rossi',
                birthDate: DateTime(1980,5,10),
                sex: 'M',
                height: 180,
                weight: 80,
            );


            await patientBox.put(
                patient.id,
                patient,
            );

        }

    }

}