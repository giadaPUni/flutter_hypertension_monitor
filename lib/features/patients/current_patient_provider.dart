import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/data/repositories/patient_repository_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';


class CurrentPatientNotifier extends Notifier<Patient?> {

    @override
    Patient? build() {

        final currentUser = ref.watch(
            currentUserProvider, 
        ); 

        if (currentUser == null) {
            return null; 
        }

        if (currentUser.patientId == null) {
            return null; 
        }

        final repository = ref.read(
            patientRepositoryProvider, 
        ); 

        return repository.findById(
            currentUser.patientId!, 
        ); 

    }

    void refresh() {

        state = build(); 
    }


}

final currentPatientProvider = 
    NotifierProvider<CurrentPatientNotifier, Patient?>(
        CurrentPatientNotifier.new, 
    ); 