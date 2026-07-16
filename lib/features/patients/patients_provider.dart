import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/data/repositories/patient_repository.dart';
import 'package:flutter_hypertension_monitor/data/repositories/patient_repository_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/app_user.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';


class PatientsNotifier extends Notifier<List<Patient>> {

    PatientRepository get repository => ref.read(patientRepositoryProvider); 

    AppUser? get currentUser => ref.read(currentUserProvider); 

    @override
    List<Patient> build() {

        final user = ref.watch(currentUserProvider);  

        if (user == null) {
            return []; 
        }

        return repository.findByOwnerId(user.id); 
    }

    void _reload() {

        final user = currentUser; 

        if (user == null) {

            state = []; 

            return; 
        }

        state = repository.findByOwnerId(
            user.id, 
        ); 
    }

    Future<void> add(Patient patient) async {

        await repository.save(patient);

        _reload(); 

    }


    Future<void> update(Patient patient) async {

        await repository.update(patient);

        _reload(); 

    }


    Future<void> delete(String patientId) async {

        await repository.delete(patientId);

        _reload(); 

    }

}


final patientsProvider =
    NotifierProvider<PatientsNotifier, List<Patient>>(
        PatientsNotifier.new,
);