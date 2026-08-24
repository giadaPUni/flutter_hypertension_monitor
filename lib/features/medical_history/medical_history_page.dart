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
    this.patientId, 
    this.showBackButton = false, 
  });

  // it can be null (for User Account Case)
  final String? patientId; 
  final bool showBackButton; 

  @override
  Widget build(
    BuildContext context, 
    WidgetRef ref, 
  ) {

    final currentUser = ref.watch(
      currentUserProvider, 
    ); 

    //final histories = ref.watch(medicalHistoryProvider);

    if (currentUser == null) {
      ////////////
      return const Center(
        child: Text(
          'Utente non autenticato', 
        ), 
      ); 
    }

    // A specific patient was explicitly selected. 
    // This is used when navigating from PatientDetailPage 
    if (patientId != null) {
      return _buildPatientView(
        context, 
        ref, 
        patientId!, 
      ); 
    }

    // Use Case: Patient Account 
    if (currentUser.role == UserRole.patient) {
      return _buildPatientView(
        context, 
        ref, 
        currentUser.patientId,
      ); 
    }


    // Use Case: User Account 
    return _buildUserView(
      context, 
      ref,
    ); 

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
      /*
      return const Scaffold(
        body: Center(
          child: Text(
            'Profilo paziente non disponibile', 
          ), 
        ),
      ); 
      */
    }

    final histories = ref.watch(medicalHistoryProvider); 

    final history = histories
      .where((h) => h.patientId == patientId)
      .firstOrNull; 

    if (history == null) {
      /*
      return _NoMedicalHistoryBody(
        patientId: patientId, 
      ); 
      */
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: showBackButton, 
          title: const Text('Anamnesi'),
        ), 
        body: _NoMedicalHistoryBody(
          patientId: patientId, 
        ), 
      ); 
    }

    return MedicalHistoryDetailPage(
      patientId: patientId,  
      showBackButton: showBackButton, 
    ); 

  }

  Widget _buildUserView(
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.sizeOf(context).height,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Icon(
                Icons.medical_information_outlined,
                size: 64,
                color: Theme.of(context)
                  .colorScheme
                  .primary,
              ),

              const SizedBox(height: 16),

              Text(
                'Nessuna anamnesi presente',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                  .textTheme
                  .titleLarge,
              ),

              const SizedBox(height: 16),

              FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Crea anamnesi'),
                onPressed: () async {

                  final created = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MedicalHistoryFormPage(
                        patientId: patientId,
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
        ),
      ),
    );
  }

}
