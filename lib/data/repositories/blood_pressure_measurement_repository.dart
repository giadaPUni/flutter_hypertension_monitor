import 'package:hive_ce/hive.dart'; 

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';

class BloodPressureMeasurementRepository {

    static const String _boxName = 'blood_pressure_measurements'; 

    Box<BloodPressureMeasurement> get _box => Hive.box<BloodPressureMeasurement>(_boxName); 

    Future<void> save(BloodPressureMeasurement measurement) async {
        await _box.put(measurement.id, measurement);
    }

    Future<void> update(BloodPressureMeasurement measurement) async {
        await _box.put(measurement.id, measurement);
    }

    Future<void> delete(String measurementId) async {
        await _box.delete(measurementId);
    }

    BloodPressureMeasurement? findById(String measurementId) {
        return _box.get(measurementId); 
    }

    List<BloodPressureMeasurement> findByPatientId(String patientId) {
        return _box.values
            .where(
                (measurement) => measurement.patientId == patientId,
            )
            .toList(); 
    }

    List<BloodPressureMeasurement> findAll() {
        return _box.values.toList();
    }

    Future<void> clear() async {
        await _box.clear(); 
    }

    int count() {
        return _box.length; 
    }
}