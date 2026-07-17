import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_hypertension_monitor/features/measurements/add_measurement_page.dart';
import 'package:flutter_hypertension_monitor/features/patients/edit_patient_page.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';
import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurement_detail_page.dart';

class PatientDetailPage extends ConsumerWidget {

    const PatientDetailPage({
        super.key,
        required this.patientId,
        this.showBackButton = true, 
    });


    final String patientId;
    final bool showBackButton; 

    /*
    // Helper per determinare lo stato e il colore della pressione
    Color _getPressureColor(int systolic, int diastolic, ThemeData theme) {
        if (systolic >= 140 || diastolic >= 90) {
        return Colors.red.shade600; // Ipertensione
        } else if (systolic >= 120 || diastolic >= 80) {
        return Colors.orange.shade600; // Pre-ipertensione / Elevata
        } else {
        return Colors.green.shade600; // Normale
        }
    }
    */



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

    
        // filtering measurements 
        final measurements = ref.watch(
            bloodPressureMeasurementsProvider
        ) 
        .where(
            (m) => m.patientId == patient.id, 
        )
        .toList()
        ..sort(
            (a,b) => b.measurementDateTime
                .compareTo(a.measurementDateTime), 
        );


        return Scaffold(

            appBar: AppBar(

                automaticallyImplyLeading: showBackButton, 

                title: Text(
                    //'${patient.firstName} ${patient.lastName}',
                    'Scheda Paziente', 
                ),

                actions: [

                    IconButton(
                        icon: const Icon(Icons.edit), 

                        tooltip: 'Modifica paziente', 

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
                    
                    IconButton(
                        icon: const Icon(
                            Icons.delete, 
                        ), 

                        tooltip: "Elimina profilo paziente",

                        onPressed: () {
                            _confirmDeletePatient(
                                context, 
                                ref, 
                                patient.id, 
                            ); 
                        },
                    ),
                    

                ],

            ),

            body: SingleChildScrollView(

                padding: const EdgeInsets.all(16),

                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                        Card(

                            child: ListTile(

                                leading: const CircleAvatar(
                                    child: Icon(Icons.person), 
                                ), 


                                title: Text(
                                    '${patient.firstName} ${patient.lastName}', 
                                ), 

                                subtitle: Text(
                                    'BMI ${patient.bmi.toStringAsFixed(1)}', 
                                ),
                            ), 
                        ), 

                        const SizedBox(height: 20), 

                        Text(
                            'Azioni veloci',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge,
                        ),


                        const SizedBox(
                            height: 12,
                        ),

                        SizedBox(

                            width: double.infinity, 

                            child: FilledButton.icon(

                                icon: const Icon(Icons.add), 

                                label: const Text(
                                    'Add measurement'
                                ), 
                            

                                onPressed: () {
                                    
                                    Navigator.push(
                                        context, 
                                        MaterialPageRoute(
                                            builder: (_) => 
                                                AddMeasurementPage(
                                                    patientId: patient.id, 
                                                ),
                                        ), 
                                    ); 
                                }, 

                            ), 
                        ),

                        const SizedBox(height: 24), 

                        Text(
                            'Misurazioni recenti', 
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge,
                        ), 

                        const SizedBox(height: 12), 

                        if (measurements.isEmpty)
                            const Text(
                                'Nessuna misurazione disponibile',
                            )
                        
                        else

                            ...measurements
                                .take(5)
                                .map(
                                    (measurement) {

                                        return Card(
                                            child: ListTile(

                                                leading: const Icon(
                                                    Icons.favorite, 
                                                ), 

                                                title: Text(
                                                    '${measurement.systolicPressure}/'
                                                    '${measurement.diastolicPressure}'
                                                    ' mmHg', 
                                                ), 

                                                subtitle: Text(
                                                    DateFormat(
                                                        'dd/MM/yyyy HH:mm', 
                                                    )
                                                    .format(
                                                        measurement
                                                        .measurementDateTime, 
                                                    ), 
                                                ), 

                                                trailing: const Icon(
                                                    Icons.chevron_right, 
                                                ), 

                                                onTap: () {

                                                    Navigator.push(
                                                        context, 
                                                        MaterialPageRoute(
                                                            builder: (_) => 
                                                            MeasurementDetailPage(
                                                                measurement: 
                                                                    measurement, 
                                                            ), 
                                                        ), 
                                                    ); 

                                                },
                                            ),
                                        );
                                    },
                                ), 
                    

                    ],

                ),

            ),

        );

    }

    Future<void> _confirmDeletePatient(
        BuildContext context,
        WidgetRef ref,
        String patientId,
    ) async {


    final confirm =
        await showDialog<bool>(

        context: context,

        builder: (_) =>
            AlertDialog(

                title: const Text(
                    'Cancella profilo paziente',
                ),

                content: const Text(
                    'Sei sicuro di voler cancellare il profilo paziente?',
                ),

                actions: [

                TextButton(
                    onPressed: (){
                        Navigator.pop(
                        context,
                        false,
                        );
                    },

                    child:
                        const Text('Annulla'),
                ),


                FilledButton(

                    onPressed: (){
                        Navigator.pop(
                        context,
                        true,
                        );
                    },

                    child:
                        const Text('Cancella'),

                ),

                ],

            ),

        );


    if(confirm != true){
        return;
    }


    await ref
        .read(patientsProvider.notifier)
        .delete(
            patientId,
        );


    if(!context.mounted){
        return;
    }


    Navigator.pop(context);

    }



}