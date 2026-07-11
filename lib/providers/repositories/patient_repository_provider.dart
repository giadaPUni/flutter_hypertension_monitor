import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/data/repositories/patient_repository.dart';


final patientRepositoryProvider = 
        Provider<PatientRepository>((ref) {
        
    return PatientRepository(); 
}); 