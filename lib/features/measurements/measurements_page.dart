import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurement_detail_page.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';

import 'package:flutter_hypertension_monitor/shared/widgets/blood_pressure_card.dart'; 

class MeasurementsPage extends ConsumerWidget {

  const MeasurementsPage({
    super.key,
    this.patientId, 
  });

  final String? patientId; 

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
  ) {

        /*
        final measurements = List<BloodPressureMeasurement>.from(
            ref.watch(
                bloodPressureMeasurementsProvider,
            ),
        )
        ..sort(
            (a,b) => b.measurementDateTime
                .compareTo(a.measurementDateTime),
        );
        */

        final allMeasurements = ref.watch(
            bloodPressureMeasurementsProvider, 
        ); 

        final measurements = allMeasurements
            .where(
                (m) => 
                    patientId == null || 
                    m.patientId == patientId, 
            )
            .toList()

            ..sort(
                (a, b) => b.measurementDateTime.compareTo(
                    a.measurementDateTime,
                ), 
            ); 



        if (measurements.isEmpty) {

          return Center(
              child: Column(
                  
                    mainAxisAlignment: MainAxisAlignment.center, 

                    children: [

                        Icon(

                            Icons.monitor_heart_outlined, 

                            size: 70, 

                            color: Colors.grey.shade400, 
                        ), 

                        const SizedBox(height: 20), 

                        Text(

                            'Non sono presenti misurazioni', 

                            style: Theme.of(context)
                                .textTheme
                                .titleMedium, 
                        ), 

                        const SizedBox(height: 8), 

                        Text(
                            'Aggiungi la prima misurazione.', 

                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium, 
                        ), 
                    ],
              ),
          );

        }

        final patients = ref.watch(
            patientsProvider, 
        ); 

        final currentUser = ref.watch(
            currentUserProvider,
        );

        if (currentUser == null) {
            return const Center(
                child: Text('Nessun utente autenticato'), 
            );
        }

        // case Patient: it's not necessary to show patientName at every measurement
        // case User: show every patientName of the patients (if it's in the main global page)
        final showPatientName = 
            currentUser.role == UserRole.user && patientId == null; 


        return ListView.builder(

            padding: const EdgeInsets.all(16),

            itemCount: measurements.length,

            itemBuilder: (context, index) {

                final measurement = measurements[index];

                final patientName = patients
                    .where(
                        (patient) => 
                            patient.id == measurement.patientId, 
                    )
                    .map(
                        (patient) => 
                            '${patient.firstName} ${patient.lastName}', 
                    )
                    .firstOrNull; 


                return BloodPressureCard(

                    measurement: measurement, 

                    patientName: patientName, 

                    showPatientName: showPatientName,  

                    onTap: () {

                        Navigator.push(
                            context, 

                            MaterialPageRoute(
                                builder: (_) => MeasurementDetailPage(
                                    measurement: measurement, 
                                ), 
                            ), 
                        ); 
                    }, 
                ); 

            },

        );

    }

    String _formatDate(DateTime dateTime) {

        return DateFormat(
            'dd/MM/yyyy HH:mm',
        ).format(dateTime);

    }

    // parameters classification  / da modificare 
    String _pressureStatus(
        BloodPressureMeasurement measurement,
    ) {

        final systolic = measurement.systolicPressure;
        final diastolic = measurement.diastolicPressure;


        if (systolic < 120 && diastolic < 80) {
            return 'Normale';
        }


        if (systolic < 130 && diastolic < 80) {
            return 'Elevata';
        }


        if (systolic < 140 || diastolic < 90) {
            return 'Ipertensione';
        }


        return 'Classificazione';

    }

Widget _pressureChip(
    BloodPressureMeasurement measurement,
) {

    final status = _pressureStatus(
        measurement,
    );

    Color color;

    switch (status) {

        case 'Normale':
            color = Colors.green;
            break;

        case 'Elevata':
            color = Colors.orange;
            break;

        case 'Alta':
            color = Colors.deepOrange;
            break;

        default:
            color = Colors.red;

    }

    return Chip(

        backgroundColor:
            color.withValues(
                alpha: 0.15,
            ),

        side: BorderSide.none,

        label: Text(

            status,

            style: TextStyle(

                color: color,

                fontWeight:
                    FontWeight.bold,

            ),

        ),

    );

}




}