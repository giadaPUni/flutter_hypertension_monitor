import 'package:flutter/material.dart';

import 'package:flutter_hypertension_monitor/data/models/patient.dart';


class PatientFormData {
    const PatientFormData({
        required this.firstName, 
        required this.lastName, 
        required this.birthDate, 
        required this.sex, 
        required this.height, 
        required this.weight,
    }); 

    final String firstName; 
    final String lastName; 
    final DateTime birthDate; 
    final String sex; 
    final double height; 
    final double weight; 
}


class PatientForm extends StatefulWidget {

    const PatientForm({
        super.key, 
        this.patient, 
        required this.onSubmit, 
        this.submitLabel = "Salva", 
    }); 

    final Patient? patient; 

    final Future<void> Function(PatientFormData data) onSubmit; 

    final String submitLabel; 

    @override
    State<PatientForm> createState() => _PatientFormState(); 
}

class _PatientFormState extends State<PatientForm> {

    late final TextEditingController firstNameController;
    late final TextEditingController lastNameController;
    late final TextEditingController heightController;
    late final TextEditingController weightController;

    late DateTime birthDate;
    late String sex;

    bool _saving = false;

    @override
    void initState() {
        super.initState(); 

        final patient = widget.patient; 

        firstNameController = TextEditingController(
            text: patient?.firstName ?? '',
        ); 

        lastNameController = TextEditingController(
            text: patient?.lastName ?? '', 
        ); 

        heightController = TextEditingController(
            text: patient?.height.toString() ?? '', 
        ); 

        weightController = TextEditingController(
            text: patient?.weight.toString() ?? '',
        ); 

        birthDate = patient?.birthDate ?? DateTime.now(); 

        sex = patient?.sex ?? 'M'; 
    }

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

        if (picked == null) {
            return;
        }

        setState(() {
            birthDate = picked;
        });
    }    


    Future<void> submit() async {

        if (_saving) {
            return;
        }

        final firstName = firstNameController.text.trim();
        final lastName = lastNameController.text.trim();

        if (firstName.isEmpty || lastName.isEmpty) {
            _showError('Inserisci nome e cognome');
            return;
        }

        final height = double.tryParse(
            heightController.text.trim().replaceAll(',', '.'),
        );

        final weight = double.tryParse(
            weightController.text.trim().replaceAll(',', '.'),
        );

        if (height == null || height <= 0) {
            _showError('Inserisci un\'altezza valida');
            return;
        }

        if (weight == null || weight <= 0) {
            _showError('Inserisci un peso valido');
            return;
        }

        setState(() {
            _saving = true;
        });

        try {

            await widget.onSubmit(
                PatientFormData(
                    firstName: firstName,
                    lastName: lastName,
                    birthDate: birthDate,
                    sex: sex,
                    height: height,
                    weight: weight,
                ),
            );

        } finally {

            if (mounted) {
                setState(() {
                    _saving = false;
                });
            }
        }
    }

    void _showError(String message) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(message), 
            ), 
        ); 
    }

    @override
    Widget build(BuildContext context) {

        return SingleChildScrollView(

            padding: const EdgeInsets.all(16), 

            child: Column(
                children: [
                    TextField(
                        controller: firstNameController, 
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                            labelText: 'Nome',
                        ),
                    ),

                    const SizedBox(height: 12), 

                    TextField(
                        controller: lastNameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                            labelText: 'Cognome',
                        ),
                    ), 

                    const SizedBox(height: 12), 
                    
                    TextField(
                        controller: heightController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                        ),
                        decoration: const InputDecoration(
                            labelText: 'Altezza (cm)',
                        ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                        controller: weightController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                        ),
                        decoration: const InputDecoration(
                            labelText: 'Peso (kg)',
                        ),
                    ),

                    const SizedBox(height: 12),  

                    ListTile(
                        contentPadding: EdgeInsets.zero, 

                        title: Text(
                            'Data di nascita: '
                            '${birthDate.day}/'
                            '${birthDate.month}/'
                            '${birthDate.year}',
                        ), 

                        trailing: const Icon(
                            Icons.calendar_month, 
                        ), 

                        onTap: selectBirthDate, 
                    ), 

                    const SizedBox(height: 12), 

                    DropdownButtonFormField<String>(
                        initialValue: sex, 

                        decoration: const InputDecoration(
                            labelText: 'Sesso', 
                        ), 

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

                        onChanged: _saving
                            ? null 
                            : (value) {
                                if (value == null) {
                                    return; 
                                }

                                setState(() {
                                    sex = value; 
                                }); 
                            },
                    ), 

                    const SizedBox(height: 30), 

                    SizedBox(
                        width: double.infinity, 

                        child: FilledButton(
                            onPressed: _saving ? null : submit, 

                            child: _saving
                                ? const SizedBox(
                                    width: 20, 
                                    height: 20, 
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, 
                                    ), 
                                )
                                : Text(widget.submitLabel),
                        ),
                    ),
                ], 

            ),
        ); 
    }

}