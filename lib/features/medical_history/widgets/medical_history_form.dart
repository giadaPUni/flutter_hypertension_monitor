import 'package:flutter/material.dart';

import 'package:flutter_hypertension_monitor/data/models/medical_history.dart';


class MedicalHistoryForm extends StatefulWidget {

    const MedicalHistoryForm({

        super.key,

        required this.history,

        required this.onSave,

    });


    final MedicalHistory history;


    final Future<void> Function(
        MedicalHistory history,
    ) onSave;



    @override
    State<MedicalHistoryForm> createState() => _MedicalHistoryFormState();

    }



    class _MedicalHistoryFormState extends State<MedicalHistoryForm> {


        final _formKey = GlobalKey<FormState>();


        late MedicalHistory editedHistory;


        late TextEditingController therapyController;

        late TextEditingController allergiesController;

        late TextEditingController notesController;



    @override
    void initState() {

        super.initState();


        editedHistory =
            widget.history.copyWith();


        therapyController =
            TextEditingController(
                text: editedHistory.currentTherapy,
            );


        allergiesController =
            TextEditingController(
                text: editedHistory.allergies,
            );


        notesController =
            TextEditingController(
                text: editedHistory.notes,
            );

    }



    @override
    void dispose() {

        therapyController.dispose();

        allergiesController.dispose();

        notesController.dispose();


        super.dispose();

    }



    Future<void> _submit() async {

        ///
        if (!_formKey.currentState!.validate()) {

            return;

        }


        editedHistory.currentTherapy =
            therapyController.text.trim();


        editedHistory.allergies =
            allergiesController.text.trim();


        editedHistory.notes =
            notesController.text.trim();



        await widget.onSave(
            editedHistory,
        );


    }



    Widget _buildSwitch({
        required String title,
        required bool value,
        required ValueChanged<bool> onChanged,
    }) {


        return SwitchListTile(
            title: Text(title),
            value: value,
            onChanged: onChanged,
            contentPadding: EdgeInsets.zero,

        );


    }


    Widget _sectionCard({
        required String title,
        required Widget child,
    }) {
        final colors = Theme.of(context).colorScheme;

        return Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Row(
                            children: [
                                Container(
                                    width: 6,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        color: colors.primary,
                                        borderRadius: BorderRadius.circular(3),
                                    ),
                                ),

                                const SizedBox(width: 10),

                                Text(
                                    title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                        ),
                                ),
                            ],
                        ),

                        const SizedBox(height: 8),

                        child,
                    ],
                ),
            ),
        );
    }


    Widget _familySection() {
        return _sectionCard(
            title: 'Stato familiare',
            child: _buildSwitch(
                title: 'Casi di ipertensione in famiglia',
                value: editedHistory.familyHistoryHypertension,
                onChanged: (value) {
                    setState(() {
                        editedHistory.familyHistoryHypertension = value;
                    });
                },
            ),
        );
    }


    Widget _diseaseSection() {
        return _sectionCard(
            title: 'Patologie associate',
            child: Column(
                children: [
                    _buildSwitch(
                        title: 'Diabete',
                        value: editedHistory.diabetes,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.diabetes = value;
                            });
                        },
                    ),

                    _buildSwitch(
                        title: 'Malattie cardiovascolari',
                        value: editedHistory.cardiovascularDisease,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.cardiovascularDisease = value;
                            });
                        },
                    ),

                    _buildSwitch(
                        title: 'Malattia renale',
                        value: editedHistory.kidneyDisease,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.kidneyDisease = value;
                            });
                        },
                    ),

                    _buildSwitch(
                        title: 'Dislipidemia',
                        value: editedHistory.dyslipidemia,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.dyslipidemia = value;
                            });
                        },
                    ),

                    _buildSwitch(
                        title: 'Precedenti di ictus',
                        value: editedHistory.previousStroke,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.previousStroke = value;
                            });
                        },
                    ),

                    _buildSwitch(
                        title: 'Apne notturna',
                        value: editedHistory.sleepApnea,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.sleepApnea = value;
                            });
                        },
                    ),
                ],
            ),
        );
    }

    Widget _lifestyleSection() {
        return _sectionCard(
            title: 'Stile di vita',
            child: Column(
                children: [
                    _buildSwitch(
                        title: 'Fumatore',
                        value: editedHistory.smoker,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.smoker = value;
                            });
                        },
                    ),

                    _buildSwitch(
                        title: 'Consumo di alcool',
                        value: editedHistory.alcoholConsumption,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.alcoholConsumption = value;
                            });
                        },
                    ),

                    _buildSwitch(
                        title: 'Sedentarietà',
                        value: editedHistory.sedentaryLifestyle,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.sedentaryLifestyle = value;
                            });
                        },
                    ),

                    _buildSwitch(
                        title: 'Dieta ricca di sale',
                        value: editedHistory.highSaltDiet,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.highSaltDiet = value;
                            });
                        },
                    ),
                ],
            ),
        );
    }

    Widget _therapySection() {
        return _sectionCard(
            title: 'Terapia e note',
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    _buildSwitch(
                        title: 'Terapia antipertensiva',
                        value: editedHistory.antihypertensiveTherapy,
                        onChanged: (value) {
                            setState(() {
                                editedHistory.antihypertensiveTherapy = value;
                            });
                        },
                    ),

                    const SizedBox(height: 8),

                    TextField(
                        controller: therapyController,
                        decoration: const InputDecoration(
                            labelText: 'Farmaci o terapia attuale',
                            prefixIcon: Icon(Icons.medication_outlined),
                        ),
                        maxLines: 2,
                    ),

                    const SizedBox(height: 12),

                    TextField(
                        controller: allergiesController,
                        decoration: const InputDecoration(
                            labelText: 'Allergie',
                            prefixIcon: Icon(Icons.warning_amber_outlined),
                        ),
                        maxLines: 2,
                    ),

                    const SizedBox(height: 12),

                    TextField(
                        controller: notesController,
                        decoration: const InputDecoration(
                            labelText: 'Note aggiuntive',
                            prefixIcon: Icon(Icons.notes_outlined),
                        ),
                        maxLines: 3,
                    ),
                ],
            ),
        );
    }


    @override
    Widget build(BuildContext context) {

        //
        return Form(

            key: _formKey,

            child: SafeArea(

                child: SingleChildScrollView(

                    padding: const EdgeInsets.all(16),


                    child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,


                        children: [

                            _familySection(),

                            const SizedBox(height: 16),

                            _diseaseSection(),

                            const SizedBox(height: 16),

                            _lifestyleSection(),

                            const SizedBox(height: 16),

                            _therapySection(),

                            const SizedBox(height: 24),

                            SizedBox(

                                width: double.infinity,

                                child: FilledButton.icon(

                                    onPressed: _submit,
                                    icon: const Icon(Icons.save),
                                    label: const Text('Salva'),
                                ),

                            ),

                            const SizedBox(height: 16), 

                        ],

                    ),

                ),                
            ),

        );


    }

}