import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';
import 'package:flutter_hypertension_monitor/data/repositories/user_repository_provider.dart';

// to create a Patient 

class CreatePatientPage extends ConsumerStatefulWidget {

  const CreatePatientPage({
    super.key,
  });


  @override
  ConsumerState<CreatePatientPage> createState() =>
      _CreatePatientPageState();

}



class _CreatePatientPageState
    extends ConsumerState<CreatePatientPage> {


  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final heightController = TextEditingController();

  final weightController = TextEditingController();


  DateTime birthDate = DateTime.now();

  String sex = 'M';



  @override
  void dispose() {

    firstNameController.dispose();
    lastNameController.dispose();
    heightController.dispose();
    weightController.dispose();

    super.dispose();

  }


  Future<void> selectBirthDate() async {

    final picked = await showDatePicker(

      context: context, 

      initialDate: birthDate, 

      firstDate: DateTime(1900), 

      lastDate: DateTime.now(), 
    ); 

    if (picked != null) {

      setState((){

        birthDate = picked; 

      }); 
    }
  }


  Future<void> savePatient() async {

    final currentUser = ref.read(
      currentUserProvider, 
    ); 

    if (currentUser == null) {
      return; 
    }

    // to avoid a Patient account can create more than one profile
    if(
      currentUser.role == UserRole.patient &&
      currentUser.patientId != null
    ){

        return;

    }


    if( 
      firstNameController.text.isEmpty || 
      lastNameController.text.isEmpty
    ){

      ScaffoldMessenger.of(context)
      .showSnackBar(
        const SnackBar(
          content: Text(
            'Inserisci nome e cognome', 
          ),
        ), 
      ); 

      return; 
    }


    final height = double.tryParse(
      heightController.text, 
    ); 

    final weight = double.tryParse(
      weightController.text,
    ); 

    if (height == null || weight == null) {

      ScaffoldMessenger.of(context)
        .showSnackBar(
          const SnackBar(
            content: Text(
              'Inserisci altezza e peso validi', 
            ),
          ),
        ); 

        return; 
    }

    final patient = Patient(

      ownerId: currentUser.id, 

      firstName: firstNameController.text,

      lastName: lastNameController.text,

      birthDate: birthDate,

      sex: sex,

      height: height, 

      weight: weight, 

    );


    await ref.read(
      patientsProvider.notifier,
    )
    .add(
      patient,
    );

    // if the account is also the patient, 
    // save the relation user -> patient
    if (currentUser.role == UserRole.patient) {

      await ref.read(
        currentUserProvider.notifier, 
      )
      .updatePatientId(
        patient.id, 
        ref.read(
          userRepositoryProvider, 
        ),
      );

    }

    if (!mounted) {
      return;
    }


    Navigator.pop(context);

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Crea il profilo del paziente',
        ),
      ),


      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [


            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),



            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Cognome',
              ),
            ),



            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altezza (cm)',
              ),
            ),



            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),


            ListTile(
              title: Text(
                'Data di nascita: ${birthDate.day}/${birthDate.month}/${birthDate.year}', 
              ), 

              trailing: const Icon(
                Icons.calendar_month, 
              ), 

              onTap: selectBirthDate, 
            ), 



            const SizedBox(
              height: 20,
            ),



            DropdownButton<String>(

              value: sex,

              items: const [

                DropdownMenuItem(
                  value: 'M',
                  child: Text('Maschio'),
                ),

                DropdownMenuItem(
                  value: 'F',
                  child: Text('Femmina'),
                ),

              ],

              onChanged: (value){

                setState(() {

                  sex = value!;

                });

              },

            ),



            const SizedBox(
              height: 30,
            ),



            FilledButton(

              onPressed: savePatient,

              child: const Text(
                'Salva il paziente',
              ),

            )

          ],

        ),

      ),

    );

  }

}