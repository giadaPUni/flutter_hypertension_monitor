import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/data/repositories/blood_pressure_measurement_repository_provider.dart';


class BloodPressureMeasurementsNotifier
    extends Notifier<List<BloodPressureMeasurement>> {


    @override
    List<BloodPressureMeasurement> build() {

        final repository = ref.read(
            bloodPressureMeasurementRepositoryProvider,
        );

        return repository.findAll();

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


        state = repository.findAll();

    }

}


final bloodPressureMeasurementsProvider =
    NotifierProvider<
        BloodPressureMeasurementsNotifier,
        List<BloodPressureMeasurement>
    >(
        BloodPressureMeasurementsNotifier.new,
    );