import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';


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



  Future<void> savePatient() async {


    final user = ref.read(
      currentUserProvider,
    );


    if (user == null) {
      return;
    }


    final patient = Patient(

      ownerId: user.id,

      firstName: firstNameController.text,

      lastName: lastNameController.text,

      birthDate: birthDate,

      sex: sex,

      height: double.parse(
        heightController.text,
      ),

      weight: double.parse(
        weightController.text,
      ),

    );


    await ref.read(
      patientsProvider.notifier,
    )
    .add(
      patient,
    );


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