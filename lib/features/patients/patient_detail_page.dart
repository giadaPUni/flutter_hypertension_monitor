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
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_detail_page.dart';
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_page.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';

import 'package:flutter_hypertension_monitor/shared/widgets/blood_pressure_card.dart';

class PatientDetailPage extends ConsumerWidget {

    const PatientDetailPage({
        super.key,
        required this.patientId,
        this.showBackButton = true, 
    });


    final String patientId;
    final bool showBackButton; 

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

        final currentUser = ref.watch(
            currentUserProvider, 
        ); 

        final isPatientAccount = 
            currentUser?.role == UserRole.patient && 
            currentUser?.patientId == patient.id; 

        return Scaffold(

            appBar: showBackButton
            
                ? AppBar(

                    automaticallyImplyLeading: true, 

                    title: Text(
                        //'${patient.firstName} ${patient.lastName}',
                        'Scheda Paziente', 
                    ),
                  )   
                : null, 

/*
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
*/

            body: SingleChildScrollView(

                padding: const EdgeInsets.all(16),

                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                        Text(
                            'Scheda Paziente', 
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium, 
                        ), 

                        const SizedBox(height: 24), 

                        Card(
                            child: Padding(
                                padding: const EdgeInsets.all(20), 
                                child: Row(
                                    children: [

                                        CircleAvatar(
                                            radius: 30, 
                                            backgroundColor: Theme.of(context).colorScheme.primaryContainer, 
                                            child: Icon(
                                                Icons.person, 
                                                size: 30,
                                                color: Theme.of(context).colorScheme.onPrimaryContainer, 
                                            ), 
                                        ), 

                                        const SizedBox(width: 16), 

                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start, 
                                                children: [

                                                    Text(
                                                        '${patient.firstName} ${patient.lastName}', 
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                                fontWeight: FontWeight.w600,
                                                            ), 
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

                                        Row(

                                            children: [
                                                Expanded(
                                                    child: Text(
                                                        'Informazioni', 
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge, 
                                                    ), 
                                                ), 

                                                IconButton(
                                                    icon: const Icon(Icons.edit), 
                                                    tooltip: 'Modifica informazioni', 
                                                    onPressed: () async {
                                                        await Navigator.push(
                                                            context, 
                                                            MaterialPageRoute(
                                                                builder: (_) => EditPatientPage(
                                                                    patient: patient, 
                                                                ), 
                                                            ),
                                                        );

                                                        ref.invalidate(patientsProvider); 
                                                    }, 
                                                ), 
                                                
                                                // User Account 
                                                if (!isPatientAccount)
                                                    IconButton(
                                                        icon: const Icon(Icons.delete), 
                                                        tooltip: 'Elimina paziente', 
                                                        onPressed: () {
                                                            _confirmDeletePatient(
                                                                context, 
                                                                ref, 
                                                                patient.id, 
                                                            ); 
                                                        }, 
                                                    ),

                                                // Patient Account 
                                                if (isPatientAccount)
                                                    IconButton(
                                                        icon: const Icon(Icons.person_off),
                                                        tooltip: 'Disattiva profilo',
                                                        onPressed: () {
                                                            _confirmDeactivateProfile(
                                                                context,
                                                                ref,
                                                                patient.id,
                                                            );
                                                        },
                                                    ), 
                                            ],

                                        ), 


                                        const Divider(height: 24), 

                                        _infoRow(
                                            context, 
                                            'Nome', 
                                            patient.firstName, 
                                        ), 

                                        _infoRow(
                                            context, 
                                            'Cognome', 
                                            patient.lastName,
                                        ), 

                                        _infoRow(
                                            context, 
                                            'Data di Nascita', 
                                            DateFormat(
                                                'dd/MM/yyyy', 
                                            ).format(
                                                patient.birthDate, 
                                            ), 
                                        ), 

                                        _infoRow(
                                            context, 
                                            'Sesso',
                                            patient.sex, 
                                        ), 

                                        _infoRow(
                                            context, 
                                            'Altezza', 
                                            '${patient.height.toStringAsFixed(0)} cm', 
                                        ), 

                                        _infoRow(
                                            context, 
                                            'Peso', 
                                            '${patient.weight.toStringAsFixed(1)} kg',
                                        ), 

                                        _infoRow(
                                            context, 
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
                            patient.id, 
                        ), 

                        const SizedBox(height: 24), 

                        _buildLatestMeasurements(
                            context, 
                            ref, 
                            patient.id, 
                        ), 

                        const SizedBox(height: 24), 


                        Center(

                            //width: double.infinity, 

                            child: FilledButton.icon(

                                icon: const Icon(
                                    Icons.add,
                                    size: 20, 
                                ), 

                                label: const Text(
                                    'Nuova misurazione'
                                ), 
                                style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                    ),
                                ),                            

                                onPressed: () {
                                    
                                    Navigator.push(
                                        context, 
                                        MaterialPageRoute(
                                            builder: (_) => AddMeasurementPage(
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
        BuildContext context, 
        String label, 
        String value,
    ) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6), 
            child: Row(
                children: [

                    SizedBox(
                        width: 120, 

                        child: Text(

                            label, 

                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                ),
                        ), 
                    ), 

                    Expanded(
                        child: Text(
                            value, 
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                ),
                        ), 

                    ), 
                ], 
            ), 
        ); 
    }


    // Medical History 
    Widget _buildMedicalHistoryCard(
        BuildContext context, 
        String patientId, 
    ) {

        return Card(
            
            child: ListTile(

                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20, 
                    vertical: 8, 
                ),

                leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    child: Icon(
                        Icons.medical_information_outlined,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                ),

                title: const Text(
                    'Anamnesi', 
                ), 

                subtitle: const Text(
                    'Visualizza la storia clinica del paziente',
                ),

                trailing: const Icon(
                    Icons.chevron_right, 
                ), 

                onTap: () {

                    Navigator.push(
                        context, 
                        MaterialPageRoute(
                            builder: (_) => MedicalHistoryPage(
                                patientId: patientId, 
                                showBackButton: true, 
                            ), 
                        ),
                    );
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

        /*
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
        */

        // Measurements for the patient already sorted from newest to oldest 
        final measurements = ref.watch(
            patientMeasurementsProvider(patientId), 
        ); 

        // Only the 5 newest measurements are displayed
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
                                                
                                                builder: (_) => Scaffold(
                                                    appBar: AppBar(
                                                        title: const Text("Tutte le misurazioni"), 
                                                    ),
                                                    body: MeasurementsPage(
                                                        patientId: patientId, 
                                                    ), 
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



    // User Account 
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


        if (confirm != true) {
            return;
        }


        await ref
            .read(patientsProvider.notifier)
            .delete(
                patientId,
            );


        if (!context.mounted){
            return;
        }

        
        Navigator.pop(context);

    
    }


    // Patient Account 
    Future<void> _confirmDeactivateProfile(
        BuildContext context,
        WidgetRef ref,
        String patientId,
    ) async {

        final confirm = await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
                title: const Text(
                    'Disattiva profilo',
                ),
                content: const Text(
                    'Disattivando il profilo verranno eliminati '
                    'definitivamente il profilo paziente, '
                    'l\'anamnesi e tutte le misurazioni associate. '
                    'Questa operazione non può essere annullata.',
                ),
                actions: [

                    TextButton(
                        onPressed: () {
                            Navigator.pop(
                                context,
                                false,
                            );
                        },
                        child: const Text(
                            'Annulla',
                        ),
                    ),

                    FilledButton(
                        onPressed: () {
                            Navigator.pop(
                                context,
                                true,
                            );
                        },
                        child: const Text(
                            'Disattiva',
                        ),
                    ),
                ],
            ),
        );

        if (confirm != true) {
            return;
        }

        await ref
            .read(patientsProvider.notifier)
            .deactivatePatientProfile(
                patientId,
            );

        if (!context.mounted) {
            return;
        }
    }


}