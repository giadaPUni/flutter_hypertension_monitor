import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/data/repositories/patient_repository_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';


class PatientsNotifier
extends Notifier<List<Patient>> {


@override
List<Patient> build(){


    final user = ref.watch(
        currentUserProvider,
    );


    if(user == null){
        return [];
    }


    final repository = ref.read(
        patientRepositoryProvider,
    );


    return repository.findByOwner(
        user.id,
    );

}



Future<void> add(
    Patient patient,
) async {


    final repository = ref.read(
        patientRepositoryProvider,
    );


    await repository.save(
        patient,
    );


    state = [
        ...state,
        patient
    ];

}

Future<void> delete(
    String id,
) async {

    final repository = ref.read(
        patientRepositoryProvider,
    );


    await repository.delete(
        id,
    );


    state = [
        for (final patient in state)
            if (patient.id != id)
                patient,
    ];

}


}

final patientsProvider =
    NotifierProvider<
        PatientsNotifier,
        List<Patient>
    >(
        PatientsNotifier.new,
    );