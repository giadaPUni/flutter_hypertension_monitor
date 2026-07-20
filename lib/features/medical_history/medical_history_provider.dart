import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/medical_history.dart';
import 'package:flutter_hypertension_monitor/data/repositories/medical_history_repository_provider.dart';

class MedicalHistoryNotifier extends Notifier<List<MedicalHistory>> {

    @override
    List<MedicalHistory> build() {

        return ref
            .read(
                medicalHistoryRepositoryProvider,
            )
            .findAll(); 
    }

    Future<void> save(MedicalHistory history) async {
        
        final repository = ref.read(
            medicalHistoryRepositoryProvider,
        ); 

        await repository.saveOrUpdate(
            history, 
        ); 

        state = repository.findAll(); 

        print("notifier updated"); 
    }


    Future<void> delete(String id) async {

        final repository = ref.read(
            medicalHistoryRepositoryProvider, 
        ); 

        await repository.delete(id); 

        state = repository.findAll(); 
    }


    MedicalHistory? findByPatient(String patientId) {
        
        for (final history in state) {

            if (history.patientId == patientId) {
                return history; 
            }
            
        }

        return null; 

    }

}

final medicalHistoryProvider = 
    NotifierProvider<
        MedicalHistoryNotifier, 
        List<MedicalHistory>
    >(
        MedicalHistoryNotifier.new, 
    ); 
