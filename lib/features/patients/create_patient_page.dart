import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';
import 'package:flutter_hypertension_monitor/data/repositories/user_repository_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/patient_form.dart';

// to create a Patient 


class CreatePatientPage extends ConsumerWidget {

  const CreatePatientPage({
    super.key,
  });


  /*
  @override
  ConsumerState<CreatePatientPage> createState() =>
      _CreatePatientPageState();
  */


  @override
  Widget build(
    BuildContext context, 
    WidgetRef ref, 
  ) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Crea il profilo del paziente',
        ), 
      ), 

      body: PatientForm(
        submitLabel: 'Salva il paziente', 
        onSubmit: (data) async {

          final currentUser = ref.read(
            currentUserProvider, 
          ); 

          if (currentUser == null) {
            return; 
          }

          // Patient accounts can only have one patient profile 
          if (
            currentUser.role == UserRole.patient && 
            currentUser.patientId != null
          ) {
            return; 
          }

          final patient = Patient(
            ownerId: currentUser.id, 
            firstName: data.firstName, 
            lastName: data.lastName, 
            birthDate: data.birthDate, 
            sex: data.sex, 
            height: data.height, 
            weight: data.weight, 
          ); 

          await ref 
            .read(patientsProvider.notifier)
            .add(patient); 

          // If this account is also a patient, link the account to the new patient 
          if (currentUser.role == UserRole.patient) {

            await ref
              .read(currentUserProvider.notifier)
              .updatePatientId(
                patient.id, 
                ref.read(userRepositoryProvider), 
              ); 
          }

          if (!context.mounted) {
            return; 
          }

          Navigator.pop(context);
        }, 
      ), 
    ); 
  }

}

