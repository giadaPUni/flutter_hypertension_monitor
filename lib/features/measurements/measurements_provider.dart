import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/data/repositories/blood_pressure_measurement_repository_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';

class BloodPressureMeasurementsNotifier
    extends Notifier<List<BloodPressureMeasurement>> {


    @override
    List<BloodPressureMeasurement> build() {

        final repository = ref.read(
            bloodPressureMeasurementRepositoryProvider,
        );

        final user = ref.watch(
            currentUserProvider, 
        ); 

        if (user == null) {
            return []; 
        }

        // Case Patient
        if (user.isPatient) {

            if (user.patientId == null) {
                return [];
            }

            return repository.findByPatientId(
                user.patientId!,
            );
        }
        

        // Case User 
        if (user.isUser) {

            final patients = ref.watch(
                patientsProvider, 
            ); 

            final patientIds = patients
                .map(
                    (p) => p.id, 
                )
                .toSet(); 

            return repository.findAll() 
                .where(
                    (measurement) => 
                        patientIds.contains(
                            measurement.patientId, 
                        ),
                )
                .toList(); 
        }

        return []; 

    }


    Future<void> add(
        BloodPressureMeasurement measurement,
    ) async {

        final repository = ref.read(
            bloodPressureMeasurementRepositoryProvider,
        );


        await repository.save(
            measurement,
        );


        state = [
            ...state,
            measurement,
        ];

    }


    Future<void> delete(
        String id,
    ) async {

        final repository = ref.read(
            bloodPressureMeasurementRepositoryProvider,
        );


        await repository.delete(
            id,
        );


        state = [
            for (final measurement in state)
                if (measurement.id != id)
                    measurement,
        ];

    }

}


final bloodPressureMeasurementsProvider =
    NotifierProvider<
        BloodPressureMeasurementsNotifier,
        List<BloodPressureMeasurement>
    >(
        BloodPressureMeasurementsNotifier.new,
    );