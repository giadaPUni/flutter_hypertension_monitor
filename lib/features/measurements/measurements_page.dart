import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurement_detail_page.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';

class MeasurementsPage extends ConsumerWidget {
  const MeasurementsPage({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
  ) {

      final measurements = List<BloodPressureMeasurement>.from(
          ref.watch(
              bloodPressureMeasurementsProvider,
          ),
      )
      ..sort(
          (a,b) => b.measurementDateTime
              .compareTo(a.measurementDateTime),
      );

      if (measurements.isEmpty) {

          return const Center(
              child: Text(
                  'No measurements available',
              ),
          );

      }


      return ListView.builder(

          padding: const EdgeInsets.all(16),

          itemCount: measurements.length,

          itemBuilder: (context, index) {

              final measurement = measurements[index];


              return Card(

                  child: ListTile(

                      onTap: () {

                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      MeasurementDetailPage(
                                          measurement: measurement,
                                      ),
                              ),
                          );

                      },

                      leading: const Icon(
                          Icons.favorite,
                      ),

                      title: Row(
                          children: [

                              Expanded(
                                  child: Text(
                                      '${measurement.systolicPressure}/'
                                      '${measurement.diastolicPressure} mmHg',
                                  ),
                              ),


                              Text(
                                  _pressureStatus(
                                      measurement,
                                  ),
                              ),

                          ],
                      ),

                      subtitle: Text(
                          'Heart rate: '
                          '${measurement.heartRate} bpm\n'
                          '${_formatDate(
                              measurement.measurementDateTime,
                          )}',
                      ),

                  ),

              );

          },

      );

  }

  String _formatDate(DateTime dateTime) {

      return DateFormat(
          'dd/MM/yyyy HH:mm',
      ).format(dateTime);

  }

  // parameters classification 
  String _pressureStatus(
      BloodPressureMeasurement measurement,
  ) {

      final systolic = measurement.systolicPressure;
      final diastolic = measurement.diastolicPressure;


      if (systolic < 120 && diastolic < 80) {
          return 'Normal';
      }


      if (systolic < 130 && diastolic < 80) {
          return 'Elevated';
      }


      if (systolic < 140 || diastolic < 90) {
          return 'High';
      }


      return 'Hypertension';

  }



}