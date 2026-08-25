import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';


class BloodPressureStatistics {

    const BloodPressureStatistics({
        required this.measurementCount,
        required this.averageSystolic,
        required this.averageDiastolic,
        required this.averageHeartRate,
        required this.minSystolic,
        required this.maxSystolic,
        required this.minDiastolic,
        required this.maxDiastolic,        
    });

    final int measurementCount; 

    final double? averageSystolic; 
    final double? averageDiastolic; 
    final double? averageHeartRate; 

    final int? minSystolic; 
    final int? maxSystolic; 

    final int? minDiastolic;
    final int? maxDiastolic; 
}


class SelectedStatisticsPatientNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void select(String? patientId) {
    state = patientId;
  }

  void clear() {
    state = null; 
  }
}

final selectedStatisticsPatientProvider =
    NotifierProvider<SelectedStatisticsPatientNotifier, String?>(
  SelectedStatisticsPatientNotifier.new,
);


final bloodPressureStatisticsProvider = 
    Provider.family<BloodPressureStatistics, String>(
        (ref, patientId) {

        final measurements = ref.watch(
            patientMeasurementsProvider(patientId),
        ); 

        if (measurements.isEmpty) {
            return const BloodPressureStatistics(
                measurementCount: 0, 
                averageSystolic: null,
                averageDiastolic: null,
                averageHeartRate: null,
                minSystolic: null,
                maxSystolic: null,
                minDiastolic: null,
                maxDiastolic: null,
            ); 
        }

        final systolicSum = measurements.fold<int>(
            0, 
            (sum, measurement) => sum + measurement.systolicPressure, 
        ); 


        final diastolicSum = measurements.fold<int>(
            0,
            (sum, measurement) => sum + measurement.diastolicPressure,
        );

        final heartRateSum = measurements.fold<int>(
            0,
            (sum, measurement) => sum + measurement.heartRate,
        );    

        final systolicValues = measurements
            .map((measurement) => measurement.systolicPressure)
            .toList();

        final diastolicValues = measurements
            .map((measurement) => measurement.diastolicPressure)
            .toList();

        return BloodPressureStatistics(
            measurementCount: measurements.length, 

            averageSystolic: systolicSum / measurements.length, 
            
            averageDiastolic: diastolicSum / measurements.length, 

            averageHeartRate: heartRateSum / measurements.length, 

            minSystolic: systolicValues.reduce((a, b) => a < b ? a : b),

            maxSystolic: systolicValues.reduce((a, b) => a > b ? a : b), 

            minDiastolic: diastolicValues.reduce((a, b) => a < b ? a : b), 

            maxDiastolic: diastolicValues.reduce((a, b) => a > b ? a : b), 
        ); 
    }
    
); 