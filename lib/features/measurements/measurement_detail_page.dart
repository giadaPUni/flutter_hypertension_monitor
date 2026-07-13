import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';

class MeasurementDetailPage extends ConsumerWidget {

    const MeasurementDetailPage({
        super.key,
        required this.measurement,
    });


    final BloodPressureMeasurement measurement;


    @override
    Widget build(
        BuildContext context,
        WidgetRef ref,
    ) {

        return Scaffold(

            appBar: AppBar(
                title: const Text(
                    'Measurement detail',
                ),
            ),


            body: Padding(

                padding: const EdgeInsets.all(16),

                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                        Text(
                            '${measurement.systolicPressure}/'
                            '${measurement.diastolicPressure} mmHg',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium,
                        ),


                        const SizedBox(
                            height: 16,
                        ),


                        Text(
                            'Heart rate: '
                            '${measurement.heartRate} bpm',
                        ),


                        const SizedBox(
                            height: 16,
                        ),


                        Text(
                            measurement.measurementDateTime
                                .toString(),
                        ),

                        const SizedBox(
                            height: 32,
                        ),


                        SizedBox(

                            width: double.infinity,

                            child: FilledButton.icon(

                                onPressed: () async {

                                    final confirm = await showDialog<bool>(

                                        context: context,

                                        builder: (context) {

                                            return AlertDialog(

                                                title: const Text(
                                                    'Delete measurement',
                                                ),


                                                content: const Text(
                                                    'Are you sure you want to delete this measurement?',
                                                ),


                                                actions: [

                                                    TextButton(

                                                        onPressed: () {

                                                            Navigator.of(context)
                                                                .pop(false);

                                                        },

                                                        child: const Text(
                                                            'Cancel',
                                                        ),

                                                    ),


                                                    FilledButton(

                                                        onPressed: () {

                                                            Navigator.of(context)
                                                                .pop(true);

                                                        },

                                                        child: const Text(
                                                            'Delete',
                                                        ),

                                                    ),

                                                ],

                                            );

                                        },

                                    );


                                    if (confirm != true) {
                                        return;
                                    }


                                    await ref
                                        .read(
                                            bloodPressureMeasurementsProvider
                                                .notifier,
                                        )
                                        .delete(
                                            measurement.id,
                                        );


                                    if (!context.mounted) {
                                        return;
                                    }


                                    Navigator.of(context).pop();

                                },

                                icon: const Icon(
                                    Icons.delete,
                                ),


                                label: const Text(
                                    'Delete measurement',
                                ),

                            ),

                        ),

                    ],

                ),

            ),

        );

    }

}