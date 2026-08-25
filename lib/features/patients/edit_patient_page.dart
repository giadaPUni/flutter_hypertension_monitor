import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/patient_form.dart';

class EditPatientPage extends ConsumerWidget {

    const EditPatientPage({
        super.key, 
        required this.patient,
    }); 

    final Patient patient; 

    /*
    @override
    ConsumerState<EditPatientPage> createState() => 
        _EditPatientPageState(); 
    */

    @override
    Widget build(
        BuildContext context, 
        WidgetRef ref, 
    ) {
        
        return Scaffold(

            appBar: AppBar(
                title: const Text(
                    'Modifica paziente', 
                ), 
            ),

            body: PatientForm(
                patient: patient, 
                submitLabel: 'Salva modifiche', 
                onSubmit: (data) async {
                    
                    final updatedPatient = Patient(

                        id: patient.id,
                        ownerId: patient.ownerId, 
                        firstName: data.firstName, 
                        lastName: data.lastName,
                        birthDate: data.birthDate, 
                        sex: data.sex, 
                        height: data.height, 
                        weight: data.weight, 
                    ); 

                    await ref
                        .read(patientsProvider.notifier)
                        .update(updatedPatient); 

                    if (!context.mounted) {
                        return; 
                    }

                    Navigator.pop(context); 
                },
            ), 
        ); 
    }
}
