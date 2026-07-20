import 'package:hive_ce/hive.dart'; 

import 'package:flutter_hypertension_monitor/data/models/medical_history.dart';

class MedicalHistoryRepository {

    static const String _boxName = 'medical_histories'; 

    Box<MedicalHistory> get _box => Hive.box<MedicalHistory>(_boxName); 

    Future<void> save(MedicalHistory history) async {
        await _box.put(history.id, history); 
    }

    Future<void> update(MedicalHistory history) async {
        await _box.put(history.id, history); 
    }

    Future<void> saveOrUpdate(MedicalHistory history) async {
        await _box.put(history.id, history); 
    }

    Future<void> delete(String historyId) async {
        await _box.delete(historyId); 
    }

    MedicalHistory? findById(String historyId) {
        return _box.get(historyId); 
    }

    MedicalHistory? findByPatientId(String patientId) {
        return _box.values.where(
            (history) => history.patientId == patientId,
        )
        .firstOrNull; 
    }

    List<MedicalHistory> findAll() {
        return _box.values.toList(); 
    }

    Future<void> clear() async {
        await _box.clear(); 
    }

    int count() {
        return _box.length;
    }
}