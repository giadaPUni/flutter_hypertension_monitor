import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/features/measurements/add_measurement_page.dart';
import 'package:flutter_hypertension_monitor/features/patients/edit_patient_page.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';

class PatientDetailPage extends ConsumerWidget {

    const PatientDetailPage({
        super.key,
        required this.patientId,
    });


    final String patientId;


    @override
    Widget build(
        BuildContext context,
        WidgetRef ref,
    ) {

        final patients = ref.watch(
            patientsProvider, 
        ); 

        final patient = patients.where(
            (p) => p.id == patientId, 
        ).firstOrNull; 

        if (patient == null) {
            return const Scaffold(
                body: Center(
                    child: Text(
                        'Paziente non trovato',
                    ),
                ),
            ); 
        }


        return Scaffold(

            appBar: AppBar(

                automaticallyImplyLeading: false, 

                title: Text(
                    '${patient.firstName} ${patient.lastName}',
                ),

                actions: [

                    IconButton(
                        icon: const Icon(Icons.edit), 
                        onPressed: () async {

                            await Navigator.push(
                                context, 
                                MaterialPageRoute(
                                    builder: (_) => 
                                        EditPatientPage(
                                            patient: patient, 
                                        ),
                                ), 
                            ); 

                            ref.invalidate(patientsProvider); 
                        },
                    ),
                    /*
                    PopupMenuButton(
                        itemBuilder: (context) => [

                            const PopupMenuItem(
                                value: 'delete', 
                                child: Text(
                                    'Elimina paziente',
                                ), 
                            ), 
                        ], 

                        onSelected: (value) {
                            if (value == 'delete') {
                                deletePatient(context, ref); 
                            }
                        },
                    ),
                    */

                ],

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