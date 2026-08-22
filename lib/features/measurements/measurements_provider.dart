import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/data/repositories/blood_pressure_measurement_repository_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';


// Provides all the measurements that the current user is allowed to see. 
// Case Patient Account: only their own measurements 
// Case User Account: measurements belonging to their patients 

class BloodPressureMeasurementsNotifier extends Notifier<List<BloodPressureMeasurement>> {


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

        // Case Patient Account 
        if (user.isPatient) {

            if (user.patientId == null) {
                return [];
            }

            return repository.findByPatientId(
                user.patientId!,
            );
        }
        

        // Case User Account 
        if (user.isUser) {

            final patients = ref.watch(
                patientsProvider, 
            ); 

            final patientIds = patients
                .map((p) => p.id)
                .toSet(); 

            return repository
                .findAll() 
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


    // Add 
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


    // Delete 
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


// All measurements the current user has access to 
final bloodPressureMeasurementsProvider =
    NotifierProvider<
        BloodPressureMeasurementsNotifier,
        List<BloodPressureMeasurement>
    >(
        BloodPressureMeasurementsNotifier.new,
    );



// Sorted Measurements (from newest to oldest) 
final sortedBloodPressureMeasurementsProvider = Provider<List<BloodPressureMeasurement>>((ref) {

    final measurements = ref.watch(
        bloodPressureMeasurementsProvider, 
    ); 

    final sorted = [
        ...measurements, 
    ]; 

    sorted.sort(
        (a, b) => b.measurementDateTime.compareTo(
            a.measurementDateTime, 
        ), 
    );

    return sorted; 

}); 


// Sorted measurements of the passed patientId 
final patientMeasurementsProvider = 
    Provider.family<
        List<BloodPressureMeasurement>, 
        String
    >(
        (ref, patientId) {
            
            final measurements = ref.watch(
                bloodPressureMeasurementsProvider,
            ); 

            final result = measurements
                .where(
                    (measurement) => 
                        measurement.patientId == patientId, 
                )
                .toList(); 

            result.sort(
                (a, b) => b.measurementDateTime.compareTo(
                    a.measurementDateTime, 
                ), 
            ); 

            return result; 
        }, 
    ); 
