import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/patient_detail_page.dart';
import 'package:flutter_hypertension_monitor/features/patients/create_patient_page.dart';

import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';


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

            onPressed: () async {

              await Navigator.of(context).push(
                
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

      
      final patients = ref.watch(
        patientsProvider, 
      ); 

      final patient = patients.where(
        (patient) => patient.id == currentUser.patientId,
      ).firstOrNull; 
      

      if (patient == null) {

        return const Center(
          child: Text(
            'Profilo paziente non trovato',
          ), 
        ); 
      }

      return PatientDetailPage(
        patientId: patient.id, 
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

        child: Column(

          mainAxisSize: MainAxisSize.min, 

          children: [

            const Text(
              'Non ci sono pazienti registrati', 
            ), 

            const SizedBox(
              height: 20, 
            ), 

            FilledButton.icon(

              icon: const Icon(
                Icons.add,
              ), 

              label: const Text(
                'Aggiungi paziente', 
              ), 

              onPressed: () async {

                await Navigator.push(
                  context, 
                  
                  MaterialPageRoute(

                    builder: (_) => 
                      const CreatePatientPage(), 

                  ), 

                );


              },

            ), 

          ],

        ), 


      );

    }

    return Scaffold(

      floatingActionButton: FloatingActionButton(

        onPressed: () async {

          await Navigator.push(

            context, 

            MaterialPageRoute(

              builder: (_) => 
                const CreatePatientPage(), 
            
            ), 
            
          ); 

        }, 

        child: const Icon(
          Icons.add,
        ),

      ), 

      body: ListView.builder(

        padding: const EdgeInsets.all(16), 

        itemCount: patients.length, 

        itemBuilder: (context, index) {

          final patient = patients[index]; 

          return Card(

            child: ListTile(

              leading: const Icon(Icons.person), 

              title: Text(
                '${patient.firstName} ${patient.lastName}',
              ), 

              subtitle: Text(
                'BMI ${patient.bmi.toStringAsFixed(1)}',
              ), 

              trailing: const Icon(Icons.chevron_right), 

              onTap: () {

                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => PatientDetailPage(
                      patientId: patient.id, 
                    ),
                  ), 
                );
              },

            ),

          );

        },
      ), 

    ); 

  }

}