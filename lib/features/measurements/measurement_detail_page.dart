import 'package:flutter/material.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';


class MeasurementDetailPage extends StatelessWidget {

    const MeasurementDetailPage({
        super.key,
        required this.measurement,
    });


    final BloodPressureMeasurement measurement;


    @override
    Widget build(BuildContext context) {

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

                    ],

                ),

            ),

        );

    }

}