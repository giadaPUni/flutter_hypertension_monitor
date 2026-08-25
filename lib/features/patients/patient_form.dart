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

        final theme = Theme.of(context); 
        final colors = theme.colorScheme; 

        return SafeArea(
        
            child: SingleChildScrollView(

                padding: const EdgeInsets.all(16), 

                child: Center(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth: 700, 
                        ), 

                        child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(24), 
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, 

                                    children: [

                                        // --- Header --- 
                                        Row(
                                            children: [
                                                Container(
                                                    width: 48, 
                                                    height: 48, 
                                                    decoration: BoxDecoration(
                                                        color: colors.primary.withValues(alpha: 0.10),
                                                        shape: BoxShape.circle, 
                                                    ),

                                                    child: Icon(
                                                        Icons.person_outline, 
                                                        color: colors.primary, 
                                                    ), 
                                                ), 

                                                const SizedBox(width: 16), 

                                                Expanded(
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start, 
                                                        children: [
                                                            Text(

                                                                widget.patient == null 
                                                                    ? 'Profilo paziente'
                                                                    : 'Informazioni paziente', 

                                                                style: theme.textTheme.titleLarge, 
                                                            ), 

                                                            const SizedBox(height: 4), 

                                                            Text(
                                                                widget.patient == null 
                                                                    ? 'Inserisci le informazioni del paziente.'
                                                                    : 'Modifica le informazioni del paziente.', 

                                                                style: theme.textTheme.bodyMedium,                                                                
                                                            ), 
                                                        ], 
                                                    ), 
                                                ), 
                                            ], 
                                        ), 

                                        const SizedBox(height: 28), 

                                        // Name 
                                        Text(
                                            'Informazioni personali', 
                                            style: theme.textTheme.titleMedium, 
                                        ), 
                                        const SizedBox(height: 16), 

                                        TextField(
                                            controller: firstNameController,
                                            enabled: !_saving,  
                                            textCapitalization: TextCapitalization.words,
                                            decoration: const InputDecoration(
                                                labelText: 'Nome',
                                                prefixIcon: Icon(
                                                    Icons.person_outline,
                                                ), 
                                            ),
                                        ),

                                        const SizedBox(height: 12), 

                                        TextField(
                                            controller: lastNameController,
                                            enabled: !_saving, 
                                            textCapitalization: TextCapitalization.words,
                                            decoration: const InputDecoration(
                                                labelText: 'Cognome',
                                                prefixIcon: Icon(
                                                    Icons.person_outline,
                                                ),                                                 
                                            ),
                                        ), 

                                        const SizedBox(height: 12), 
                                        
                                        // Birth date 

                                        InkWell(
                                            borderRadius:
                                                BorderRadius.circular(12),

                                            onTap: _saving
                                                ? null
                                                : selectBirthDate,

                                            child: InputDecorator(

                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            'Data di nascita',
                                                        prefixIcon: Icon(
                                                            Icons
                                                                .calendar_month_outlined,
                                                        ),
                                                    ),

                                                child: Text(
                                                    '${birthDate.day.toString().padLeft(2, '0')}/'
                                                    '${birthDate.month.toString().padLeft(2, '0')}/'
                                                    '${birthDate.year}',
                                                ),
                                            ),
                                        ),

                                        const SizedBox(height: 12),
                                        
                                        // Sex

                                        DropdownButtonFormField<String>(

                                            initialValue: sex,

                                            decoration:
                                                const InputDecoration(
                                                    labelText: 'Sesso',
                                                    prefixIcon: Icon(
                                                        Icons.wc_outlined,
                                                    ),
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

                                        const SizedBox(height: 28), 

                                        // Physical information 

                                        Text(
                                            'Dati fisici',
                                            style: theme.textTheme.titleMedium,
                                        ),

                                        const SizedBox(height: 16),

                                        TextField(
                                            controller: heightController,
                                            enabled: !_saving, 
                                            keyboardType: const TextInputType.numberWithOptions(
                                                decimal: true,
                                            ),
                                            decoration: const InputDecoration(
                                                labelText: 'Altezza (cm)',
                                                prefixIcon: Icon(
                                                    Icons.height, 
                                                ), 
                                            ),
                                        ),

                                        const SizedBox(height: 12),

                                        TextField(
                                            controller: weightController,
                                            enabled: !_saving, 
                                            keyboardType: const TextInputType.numberWithOptions(
                                                decimal: true,
                                            ),
                                            decoration: const InputDecoration(
                                                labelText: 'Peso (kg)',
                                                prefixIcon: Icon(
                                                    Icons.monitor_weight_outlined, 
                                                ),                                                
                                            ),
                                        ),
 

                                        const SizedBox(height: 30), 

                                        SizedBox(
                                            width: double.infinity, 

                                            child: FilledButton.icon(
                                                onPressed: _saving ? null : submit, 

                                                icon: _saving
                                                    ? const SizedBox(
                                                        width: 20, 
                                                        height: 20, 
                                                        child: CircularProgressIndicator(
                                                            strokeWidth: 2, 
                                                        ), 
                                                    )
                                                    : const Icon(
                                                        Icons.save_outlined, 
                                                    ),

                                                label: Text(
                                                    _saving
                                                        ? 'Salvataggio...'
                                                        : widget.submitLabel, 
                                                ), 
                                            ),
                                        ),
                                    ],                                     
                                ),
                            ),
                        ),
                    ),


                ),
            ),

        );
    }

}