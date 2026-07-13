import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/data/repositories/blood_pressure_measurement_repository.dart';
import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';

final bloodPressureMeasurementRepositoryProvider =
        Provider<BloodPressureMeasurementRepository>((ref) {

    return BloodPressureMeasurementRepository();

});

final bloodPressureMeasurementsProvider =
    Provider<List<BloodPressureMeasurement>>((ref) {

    final repository = ref.watch(
        bloodPressureMeasurementRepositoryProvider,
    );

    return repository.findAll();

});