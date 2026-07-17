import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurement_detail_page.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';

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


                return Card(

                    elevation: 2, 

                    margin: const EdgeInsets.only(bottom:14), 
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

                        leading: CircleAvatar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primaryContainer, 
                            
                            child: Icon(
                                Icons.favorite,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary, 
                            ), 
                        ),

                        title: Column(

                            crossAxisAlignment: CrossAxisAlignment.start, 

                            children: [

                                if (currentUser?.isUser == true && patientName != null) 
                                    Text(
                                        patientName, 
                                        style:Theme.of(context)
                                            .textTheme
                                            .titleMedium, 
                                    ), 
                                

                                Row(

                                    children: [

                                        Expanded(
                                            child: Text(
                                                '${measurement.systolicPressure}'
                                                '/'
                                                '${measurement.diastolicPressure} mmHg',

                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge, 
                                            ),
                                        ),


                                        
                                            _pressureChip(
                                                measurement,
                                            ),
                                        

                                    ],                                    


                                ),

                            ],

                        ),


                        subtitle: Column(

                            crossAxisAlignment: CrossAxisAlignment.start, 

                            children: [

                                const SizedBox(height: 8), 

                                Row(

                                    children: [

                                        const Icon(
                                            Icons.favorite_border, 
                                            size: 16, 
                                        ), 

                                        const SizedBox(width: 6), 

                                        Text(
                                            '${measurement.heartRate} bpm', 
                                        ), 
                                    ], 
                                ), 

                                const SizedBox(height: 4), 

                                Row(

                                    children: [

                                        const Icon(
                                            Icons.schedule, 
                                            size: 16, 
                                        ), 

                                        const SizedBox(width: 6), 

                                        Text(
                                            _formatDate(
                                                measurement.measurementDateTime,
                                            ), 
                                        ), 
                                    ], 
                                ), 

                                if (patientId == null && patientName != 'Unknown')

                                    Padding(

                                        padding: 
                                            const EdgeInsets.only(top: 4), 

                                        child: Row(

                                            children: [

                                                const Icon(
                                                    Icons.person_outline, 
                                                    size: 16, 
                                                ), 

                                                const SizedBox(width: 6), 

                                                //Text(patientName), 
                                            ], 
                                        ),
                                    ),
                            ], 
                        ), 
                        
                            /*
                            Text(
                            'Frequenza cardiaca: '
                            '${measurement.heartRate} bpm\n'
                            '${_formatDate(
                                measurement.measurementDateTime,
                            )}',
                            ),
                            */
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