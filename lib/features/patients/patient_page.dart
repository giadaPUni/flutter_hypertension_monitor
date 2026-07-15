import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/patient_detail_page.dart';
import 'package:flutter_hypertension_monitor/features/patients/create_patient_page.dart';

import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';

import 'package:flutter_hypertension_monitor/data/repositories/patient_repository_provider.dart';

class PatientPage extends ConsumerWidget {

  const PatientPage({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
  ) {


    final currentUser = ref.watch(
      currentUserProvider, 
    ); 


    if (currentUser == null) {

      return const Center(
        child: Text(
          'Nessun utente autenticato', 
        ), 
      ); 

    }

    // Case 1 - Patient: 
    // User is also the patient
    if (currentUser.role == UserRole.patient) {

      // if the account has not created the patient profile yet
      if (currentUser.patientId == null) {
      
        return Center(

          child: FilledButton(

            onPressed: (){

              Navigator.of(context).push(
                
                MaterialPageRoute(
                  builder: (_) => const CreatePatientPage(),
                ),
              ); 
            },

            child: const Text(
              'Crea il profilo paziente',
            ),
          ),

        ); 

      }

      final repository = ref.read(
        patientRepositoryProvider, 
      ); 

      final patient = repository.findById(
        currentUser.patientId!, 
      ); 

      if (patient == null) {

        return const Center(
          child: Text(
            'Profilo paziente non trovato',
          ), 
        ); 
      }

      return PatientDetailPage(
        patient: patient, 
      ); 

    }


    // Case 2 - User:
    // The user handles one or more patients 

    final patients = ref.watch(
      patientsProvider, 
    ); 

    // if the list of patients is empty
    if (patients.isEmpty) {

      return Center(

        child: FilledButton(
          
          onPressed: (){

            Navigator.of(context).push(

              MaterialPageRoute(
                builder: (_) => const CreatePatientPage(), 
              ), 
            ); 
          }, 

          child: const Text(
            'Aggiungi paziente', 
          ), 
        ),
      
      );

    }


    // There's at least one registered patient 
    return ListView.builder(

      itemCount: patients.length,

      itemBuilder: (context, index) {

        final patient = patients[index];


        return ListTile(

          title: Text(
            '${patient.firstName} ${patient.lastName}',
          ), 

          subtitle: Text(
            'BMI ${patient.bmi.toStringAsFixed(1)}',
          ), 

          onTap: (){

            Navigator.push(
              context, 

              MaterialPageRoute(

                builder: (_) => 
                  PatientDetailPage(
                    patient: patient, 
                  ), 

              ),
              
            );
          }, 

        );

      },

    );

  }

}