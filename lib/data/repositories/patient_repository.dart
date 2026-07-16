import 'package:hive_ce/hive.dart'; 

import '../models/patient.dart'; 

class PatientRepository {

    static const String _boxName = 'patients'; 

    Box<Patient> get _box => Hive.box<Patient>(_boxName); 

    Future<void> save(Patient patient) async {
        await _box.put(patient.id, patient); 
    }

    Future<void> update(Patient patient) async {
        await _box.put(patient.id, patient);
    }

    Future<void> delete(String patientId) async {
        await _box.delete(patientId);
    }

    Patient? findById(String patientId) {
        return _box.get(patientId); 
    }


    List<Patient> findByOwnerId(String ownerId) {
        return _box.values
            .where(
                (patient) => patient.ownerId == ownerId,
            )
            .toList();
    }

    List<Patient> findAll() {
        return _box.values.toList(); 
    }

    bool exists(String patientId) {
        return _box.containsKey(patientId); 
    }

    Future<void> clear() async {
        await _box.clear(); 
    }

    int count() {
        return _box.length; 
    }

}