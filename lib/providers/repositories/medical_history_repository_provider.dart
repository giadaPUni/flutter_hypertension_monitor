import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/data/repositories/medical_history_repository.dart';

final medicalHistoryRepositoryProvider =
        Provider<MedicalHistoryRepository>((ref) {

    return MedicalHistoryRepository();

});