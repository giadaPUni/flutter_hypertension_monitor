import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/data/repositories/blood_pressure_measurement_repository.dart';


final bloodPressureMeasurementRepositoryProvider =
        Provider<BloodPressureMeasurementRepository>((ref) {

    return BloodPressureMeasurementRepository();

});
