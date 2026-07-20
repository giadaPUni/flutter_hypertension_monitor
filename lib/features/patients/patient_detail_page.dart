import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_hypertension_monitor/features/measurements/add_measurement_page.dart';
import 'package:flutter_hypertension_monitor/features/patients/edit_patient_page.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_page.dart';
import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurement_detail_page.dart';

import 'package:flutter_hypertension_monitor/shared/widgets/blood_pressure_card.dart';

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

                            child: Padding(

                                padding: const EdgeInsets.all(20), 

                                child: Row(

                                    children: [

                                        const CircleAvatar(

                                            //radius: 34, 

                                            child: Icon(
                                                Icons.person, 
                                                size: 34, 
                                            ), 
                                        ), 

                                        const SizedBox(width: 20), 

                                        Expanded(

                                            child: Column(

                                                crossAxisAlignment: CrossAxisAlignment.start, 

                                                children: [


                                                    Text(
                                                        '${patient.firstName} ${patient.lastName}', 

                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall, 
                                                    ), 

                                                    const SizedBox(height: 6), 

                                                    Text(
                                                        '${patient.sex} • BMI ${patient.bmi.toStringAsFixed(1)}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium, 
                                                    ),

                                                ], 
                                            ),
                                        ),
                                    ],
                                ),


                            ), 
                        ), 

                        const SizedBox(height: 24), 
                        
                        // Patient info 
                        Card(

                            child: Padding(

                                padding: const EdgeInsets.all(20), 

                                child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start, 

                                    children: [

                                        Text(
                                            'Informazioni', 

                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge, 
                                        ), 

                                        const Divider(height: 24), 

                                        _infoRow(
                                            'Nome', 
                                            patient.firstName, 
                                        ), 

                                        _infoRow(
                                            'Cognome', 
                                            patient.lastName,
                                        ), 

                                        _infoRow(
                                            'Data di Nascita', 
                                            DateFormat(
                                                'dd/MM/yyyy', 
                                            ).format(
                                                patient.birthDate, 
                                            ), 
                                        ), 

                                        _infoRow(
                                            'Sesso',
                                            patient.sex, 
                                        ), 

                                        _infoRow(
                                            'Altezza', 
                                            '${patient.height.toStringAsFixed(0)} cm', 
                                        ), 

                                        _infoRow(
                                            'Peso', 
                                            '${patient.weight.toStringAsFixed(1)} kg',
                                        ), 

                                        _infoRow(
                                            'BMI', 
                                            patient.bmi.toStringAsFixed(1), 
                                        ), 
                                    
                                    ],
                                ),
                            ),
                        ),

                        const SizedBox(height: 24),

                        // Medical history 
                        _buildMedicalHistoryCard(
                            context, 
                        ), 

                        const SizedBox(height: 24), 

                        _buildLatestMeasurements(
                            context, 
                            ref, 
                            patient.id, 
                        ), 

                        const SizedBox(height: 24), 


                        SizedBox(

                            width: double.infinity, 

                            child: FilledButton.icon(

                                icon: const Icon(Icons.add), 

                                label: const Text(
                                    'Aggiungi misurazione'
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
                    
                    ],

                ),

            ),

        );

    }



    // info row 

    Widget _infoRow(
        String label, 
        String value,
    ) {
        return Padding(

            padding: const EdgeInsets.symmetric(
                vertical: 6, 
            ), 

            child: Row(

                children: [

                    SizedBox(
                        width: 120, 

                        child: Text(

                            label, 

                            style: const TextStyle(
                                fontWeight: FontWeight.w600, 
                            ), 
                        ), 
                    ), 

                    Expanded(
                        child: Text(value), 

                    ), 
                ], 
            ), 
        ); 
    }


    // Medical History 
    Widget _buildMedicalHistoryCard(
        BuildContext context, 
    ) {

        return Card(
            
            child: ListTile(

                leading: const Icon(
                    Icons.medical_information,
                ), 

                title: const Text(
                    'Dati Clinici', 
                ), 

                subtitle: const Text(
                    'Visualizza i dati clinici',
                ),

                trailing: const Icon(
                    Icons.chevron_right, 
                ), 

                onTap: () {

                    // todo 
                },
            ),
        ); 
    }


    // Last measurements 
    Widget _buildLatestMeasurements(
        BuildContext context, 
        WidgetRef ref, 
        String patientId, 
    ) {

    
        // filtering measurements 
        final measurements = ref.watch(
            bloodPressureMeasurementsProvider
        ) 
        .where(
            (m) => m.patientId == patientId, 
        )
        .toList()
        ..sort(
            (a,b) => b.measurementDateTime
                .compareTo(a.measurementDateTime), 
        );

        final latest = measurements.take(5).toList(); 

        return Card(

            child: Padding(

                padding: const EdgeInsets.all(20), 

                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start, 

                    children: [

                        Text(
                            'Ultime misurazioni', 
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge, 
                        ), 

                        const SizedBox(height: 16), 

                        if (latest.isEmpty)

                            const Padding(

                                padding: EdgeInsets.symmetric(vertical: 12), 

                                child: Text(
                                    'Nessuna misurazione disponibile', 
                                ),
                            )
                        else
                            ...latest.map(

                                (m) => Padding(

                                    //dense: true, 

                                    padding: const EdgeInsets.only(bottom: 12), 

                                    child: BloodPressureCard(
                                        
                                        measurement: m, 

                                        showPatientName: false, 

                                        embedded: true, 

                                        compact: true, 

                                        onTap: () {

                                            Navigator.push(

                                                context, 

                                                MaterialPageRoute(
                                                    builder: (_) => MeasurementDetailPage(
                                                        measurement: m, 
                                                    ), 
                                                ),
                                            );
                                        },
                                    ),
                        
                                ), 
                            ), 

                            const SizedBox(height: 8), 

                            Align(
                                alignment: Alignment.centerRight, 

                                child: TextButton.icon(

                                    icon: const Icon(
                                        Icons.history, 
                                    ), 

                                    label: const Text(
                                        'Guarda tutte le misurazioni', 
                                    ), 

                                    onPressed: () {

                                        Navigator.push(
                                            
                                            context, 

                                            MaterialPageRoute(
                                                
                                                builder: (_) => MeasurementsPage(
                                                    patientId: patientId, 
                                                ), 
                                            ), 
                                        ); 
                                    }, 
                                ), 
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