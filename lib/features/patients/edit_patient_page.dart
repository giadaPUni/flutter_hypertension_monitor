import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';

class EditPatientPage extends ConsumerStatefulWidget {

    const EditPatientPage({
        super.key, 
        required this.patient,
    }); 

    final Patient patient; 

    @override
    ConsumerState<EditPatientPage> createState() => 
        _EditPatientPageState(); 

}

class _EditPatientPageState extends ConsumerState<EditPatientPage> {

    late TextEditingController firstNameController; 

    late TextEditingController lastNameController;

    late TextEditingController heightController;

    late TextEditingController weightController;


    late DateTime birthDate;

    late String sex;

    @override
    void initState() {

        super.initState(); 

        final patient = widget.patient;

        firstNameController = TextEditingController(
            text: patient.firstName, 
        );


        lastNameController =
            TextEditingController(
                text: patient.lastName,
            );


        heightController =
            TextEditingController(
                text: patient.height.toString(),
            );


        weightController =
            TextEditingController(
                text: patient.weight.toString(),
            );


        birthDate = patient.birthDate;

        sex = patient.sex;


    }

    @override
    void dispose() {

        firstNameController.dispose(); 

        lastNameController.dispose();

        heightController.dispose();

        weightController.dispose();

        super.dispose();        
    }


    Future<void> saveChanges() async {

        final height = double.tryParse(
            heightController.text, 
        ); 

        final weight = double.tryParse(
            weightController.text,
        );


        if(height == null || weight == null){

        ScaffoldMessenger.of(context)
            .showSnackBar(
                const SnackBar(
                content: Text(
                    'Inserire valori validi',
                ),
                ),
            );

        return;

        }

        final updatedPatient = Patient(

            id: widget.patient.id,

            ownerId: widget.patient.ownerId,

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
        .update(
            updatedPatient, 
        ); 

        if(!mounted){
            return;
        }

        Navigator.pop(context); 

    }

    Future<void> selectBirthDate() async {

        final picked =

            await showDatePicker(

                context: context,

                initialDate: birthDate,

                firstDate: DateTime(1900),

                lastDate: DateTime.now(),

            );


        if(picked != null){

            setState(() {

                birthDate = picked;

            });

        }

    }



    @override
    Widget build(BuildContext context) {

        return Scaffold(

            appBar: AppBar(
                title: const Text(
                    'Modifica paziente', 
                ), 
            ), 


            body: Padding(

                padding: const EdgeInsets.all(16),

                child: Column(

                    children: [

                        TextField(
                            controller: firstNameController, 

                            decoration: 
                                const InputDecoration(
                                    labelText: 'Nome', 
                                ), 
                        ), 

                        TextField(

                            controller: lastNameController,

                            decoration:
                                const InputDecoration(
                                    labelText: 'Cognome',
                                ),

                        ), 


                        TextField(

                            controller: heightController,

                            keyboardType:
                                TextInputType.number,

                            decoration:
                                const InputDecoration(
                                    labelText: 'Altezza (cm)',
                                ),

                        ),

                        TextField(

                            controller: weightController,

                            keyboardType:
                                TextInputType.number,

                            decoration:
                                const InputDecoration(
                                    labelText: 'Peso (kg)',
                                ),

                        ),

                        ListTile(

                            title: Text(
                                'Data nascita: '
                                '${birthDate.day}/'
                                '${birthDate.month}/'
                                '${birthDate.year}',
                            ),

                            trailing:
                                const Icon(
                                    Icons.calendar_month,
                                ),

                            onTap:
                                selectBirthDate,

                        ),

                        DropdownButton<String>(

                            value: sex,


                            items: const [

                                DropdownMenuItem(

                                    value: 'M',

                                    child:
                                        Text('Maschio'),

                                ), 

                                DropdownMenuItem(

                                    value: 'F',

                                    child:
                                        Text('Femmina'),

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

                            onPressed:
                                saveChanges,


                            child:
                                const Text(
                                    'Salva modifiche',
                                ), 
                        ),              

                    ], 
                ), 
            ),
        );

    }

}