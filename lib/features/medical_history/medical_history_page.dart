import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';

import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_provider.dart';
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_form_page.dart';
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_detail_page.dart';

import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/data/models/medical_history.dart';


class MedicalHistoryPage extends ConsumerWidget {

  const MedicalHistoryPage({
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

    //final histories = ref.watch(medicalHistoryProvider);

    //print("MedicalHistoryPage rebuild");
    if (currentUser == null) {

      return const Center(
        child: Text(
          'Utente non autenticato', 
        ), 
      ); 
    }

    // Case Patient Account

    if (currentUser.role == UserRole.patient) {
      

      return _buildPatientView(context, ref, currentUser.patientId); 

    }


    // Case User Account 
  
    return _buildDoctorView(context, ref); 


  }

  Widget _buildPatientView(
    BuildContext context, 
    WidgetRef ref, 
    String? patientId, 
  ) {

    if (patientId == null) {
      return const Center(
        child: Text('Profilo paziente non disponibile'), 
      ); 
    }

    final histories = ref.watch(medicalHistoryProvider); 

    final history = histories
      .where((h) => h.patientId == patientId)
      .firstOrNull; 

    if (history == null) {
      return _NoMedicalHistoryBody(
        patientId: patientId, 
      ); 
    }

    return MedicalHistoryDetailPage(
      patientId: patientId, 
    ); 

  }

  Widget _buildDoctorView(
    BuildContext context, 
    WidgetRef ref, 
  ) {
    final patients = ref.watch(patientsProvider); 
    final histories = ref.watch(medicalHistoryProvider); 

    if (patients.isEmpty) {
      return const Center(
        child: Text('Nessun paziente disponibile'), 
      ); 
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16), 
      itemCount: patients.length, 
      itemBuilder: (context, index) {
        final patient = patients[index]; 

        return _buildPatientTile(
          context, 
          patient, 
          histories, 
        ); 
      }, 
    );

  }

  Widget _buildPatientTile(
    BuildContext context, 
    Patient patient, 
    List<MedicalHistory> histories,
  ) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.medical_information), 
        title: Text('${patient.firstName} ${patient.lastName}'), 
        trailing: const Icon(Icons.chevron_right), 
        onTap: () {
          final history = histories
            .where((h) => h.patientId == patient.id)
            .firstOrNull; 

          if (history == null) {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: const Text('Anamnesi'), 
                  ), 
                  body: _NoMedicalHistoryBody(
                    patientId: patient.id,
                    onCreated: () => Navigator.pop(context), 
                  ),

                ), 
              ), 
            ); 

            return; 
          }

          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (_) => MedicalHistoryDetailPage(
                patientId: patient.id,
                onDeleted: () => Navigator.pop(context),
              ), 
            ), 
          ); 
        }, 
      ), 
    );

  }

}





class _NoMedicalHistoryBody extends StatelessWidget {


  const _NoMedicalHistoryBody({

    required this.patientId,
    this.onCreated, 

  });


  final String patientId;
  final VoidCallback? onCreated; 



  @override
  Widget build(BuildContext context) {


    return Center(

      child: Column(

        mainAxisSize:
            MainAxisSize.min,


        children: [


          Icon(

            Icons.assignment_outlined,

            size: 90,
            color: Theme.of(context)
              .colorScheme
              .primary, 

          ),


          const SizedBox(
            height: 20,
          ),



          Text(

            'Nessuna anamnesi presente',
            style: Theme.of(context)
              .textTheme
              .titleLarge, 
          ),



          const SizedBox(
            height: 8,
          ),

          Text(
            'Crea la prima anamnesi per iniziare\nil monitoraggio del paziente.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium,
          ),

          const SizedBox(height: 24), 


          FilledButton.icon(

            icon:
                const Icon(
                  Icons.add,
                ),


            label:
                const Text(
                  'Crea anamnesi',
                ),



            onPressed: () async {


              final created = await Navigator.push<bool>(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                    MedicalHistoryFormPage(

                      patientId:
                          patientId,

                    ),

                ),

              );

              if (created == true) {
                onCreated?.call(); 
              }


            },


          ),


        ],

      ),

    );


  }

}
