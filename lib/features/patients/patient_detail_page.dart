import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/features/measurements/add_measurement_page.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';

class PatientDetailPage extends ConsumerWidget {

    const PatientDetailPage({
        super.key,
        required this.patient,
    });


    final Patient patient;


    @override
    Widget build(
        BuildContext context,
        WidgetRef ref,
    ) {

        final measurement = ref.watch(
            bloodPressureMeasurementsProvider,
        ).where(
            (measurement) =>
                measurement.patientId == patient.id,
        ).toList();

        return Scaffold(

            appBar: AppBar(

                title: Text(
                    '${patient.firstName} ${patient.lastName}',
                ),

            ),


            body: Padding(

                padding: const EdgeInsets.all(16),

                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                        Text(
                            'Patient information',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall,
                        ),


                        const SizedBox(
                            height: 16,
                        ),


                        Text(
                            'Name: '
                            '${patient.firstName} ${patient.lastName}',
                        ),


                        Text(
                            'Sex: ${patient.sex}',
                        ),


                        Text(
                            'BMI: ${patient.bmi.toStringAsFixed(1)}',
                        ),


                        const SizedBox(
                            height: 32,
                        ),


                        SizedBox(

                            width: double.infinity,

                            child: FilledButton.icon(

                                onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(

                                            builder: (_) =>
                                                AddMeasurementPage(
                                                    patientId: patient.id,
                                                ),

                                        ),
                                    );

                                },


                                icon: const Icon(
                                    Icons.add,
                                ),


                                label: const Text(
                                    'Add measurement',
                                ),

                            ),

                        ),

                    ],

                ),

            ),

        );

    }

}