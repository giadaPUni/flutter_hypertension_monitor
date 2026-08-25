import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:intl/intl.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart'; 
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';

class AddMeasurementPage extends ConsumerStatefulWidget {

    const AddMeasurementPage({
        super.key,
        required this.patientId, 
    }); 

    final String patientId; 

    @override
    ConsumerState<AddMeasurementPage> createState() => _AddMeasurementPageState();
}

class _AddMeasurementPageState extends ConsumerState<AddMeasurementPage> {

    final _formKey = GlobalKey<FormState>();

    final _systolicController = TextEditingController();

    final _diastolicController = TextEditingController();

    final _heartRateController = TextEditingController();

    DateTime measurementDateTime = DateTime.now();

    @override
    void dispose() {

        _systolicController.dispose();

        _diastolicController.dispose();

        _heartRateController.dispose();

        super.dispose();

    }



    @override
    Widget build(BuildContext context) {

        final colors = Theme.of(context).colorScheme; 

        return Scaffold(

            appBar: AppBar(
                title: const Text(
                    'Nuova misurazione',
                ),
            ),


            body: SafeArea(

                child: SingleChildScrollView(

                    padding: const EdgeInsets.all(16),

                    child: Center(

                        child: ConstrainedBox(
                            
                            constraints: const BoxConstraints(
                                maxWidth: 700, 
                            ), 


                            child: Form(

                                key: _formKey,

                                child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.stretch,

                                    children: [
                                        
                                        Card(
                                            child: Padding(
                                                padding: const EdgeInsets.all(24),
                                                child: Column(
                                                    children: [

                                                        Icon(
                                                            Icons.favorite,
                                                            size: 40,
                                                            color: colors.primary,
                                                        ),

                                                        const SizedBox(
                                                            height: 16,
                                                        ),

                                                        Text(
                                                            'Pressione arteriosa',
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .titleLarge,
                                                        ),

                                                        const SizedBox(
                                                            height: 10,
                                                        ),


                                                        Text(
                                                            'Inserisci i valori della misurazione.',
                                                            textAlign: TextAlign.center,
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium,
                                                        ),

                                                        const SizedBox(
                                                            height: 32,
                                                        ),


                                                        TextFormField(

                                                            controller: _systolicController,

                                                            keyboardType: TextInputType.number,

                                                            textAlign: TextAlign.center,

                                                            decoration: const InputDecoration(
                                                                labelText: 'Pressione sistolica',
                                                                suffixText: 'mmHg',
                                                            ),


                                                            validator: (value) {

                                                                if (value == null ||
                                                                    value.isEmpty) {

                                                                    return 'Campo obbligatorio';

                                                                }


                                                                final number = int.tryParse(value);


                                                                if (number == null ||
                                                                    number < 50 ||
                                                                    number > 250) {

                                                                    return 'Inserisci un valore valido';

                                                                }


                                                                return null;

                                                            },

                                                        ),

                                                        const SizedBox(
                                                            height: 16,
                                                        ),


                                                        TextFormField(

                                                            controller: _diastolicController,

                                                            keyboardType: TextInputType.number,

                                                            textAlign: TextAlign.center,

                                                            decoration: const InputDecoration(
                                                                labelText: 'Pressione diastolica',
                                                                suffixText: 'mmHg',
                                                            ),


                                                            validator: (value) {

                                                                if (value == null ||
                                                                    value.isEmpty) {

                                                                    return 'Campo obbligatorio';

                                                                }


                                                                final number = int.tryParse(value);


                                                                if (number == null ||
                                                                    number < 30 ||
                                                                    number > 150) {

                                                                    return 'Inserisci un valore valido';

                                                                }


                                                                return null;

                                                            },

                                                        ),

                                                        const SizedBox(
                                                            height: 16,
                                                        ),

                                                        TextFormField(

                                                            controller:
                                                                _heartRateController,

                                                            keyboardType:
                                                                TextInputType.number,

                                                            textAlign:
                                                                TextAlign.center,

                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        'Frequenza cardiaca',
                                                                    suffixText:
                                                                        'bpm',
                                                                ), 

                                                            validator: (value) {

                                                                if (value ==
                                                                        null ||
                                                                    value.isEmpty) {
                                                                    return 'Campo obbligatorio';
                                                                }

                                                                final number =
                                                                    int.tryParse(
                                                                        value,
                                                                    );

                                                                if (number ==
                                                                        null ||
                                                                    number < 30 ||
                                                                    number > 220) {
                                                                    return 'Inserisci un valore valido';
                                                                }

                                                                return null;
                                                            },
                                                        ),   


                                                        const SizedBox(height: 16), 

                                                        ListTile(
                                                            contentPadding: EdgeInsets.zero,

                                                            leading: const Icon(
                                                                Icons.calendar_month_outlined,
                                                            ),

                                                            title: Text(
                                                                'Data e ora',
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                            ),

                                                            subtitle: Text(
                                                                DateFormat(
                                                                    'dd/MM/yyyy HH:mm',
                                                                ).format(
                                                                    measurementDateTime,
                                                                ),
                                                            ),

                                                            trailing: const Icon(
                                                                Icons.edit_calendar_outlined,
                                                            ),

                                                            onTap: selectMeasurementDateTime,
                                                        ), 

                                                    ], 
                                                ), 
                                            ), 
                                        ), 


                                        const SizedBox(height: 24), 


                                        FilledButton.icon(

                                            onPressed: () async {

                                                if (!_formKey.currentState!.validate()) {
                                                    return; 
                                                }

                                                final measurement = BloodPressureMeasurement(
                                                
                                                    // accessing to the state trough widget (AddMeasurementPage is a StatefulWidget) 
                                                    patientId: widget.patientId,

                                                    systolicPressure: int.parse(
                                                        _systolicController.text,
                                                    ),

                                                    diastolicPressure: int.parse(
                                                        _diastolicController.text,
                                                    ),

                                                    heartRate: int.parse(
                                                        _heartRateController.text,
                                                    ),

                                                    measurementDateTime: measurementDateTime,

                                                );

                                                final messenger = ScaffoldMessenger.of(context);
                                                final navigator = Navigator.of(context);

                                                await ref
                                                    .read(
                                                        bloodPressureMeasurementsProvider.notifier,
                                                    )
                                                    .add(
                                                        measurement,
                                                    );
                                                

                                                if (!mounted) {
                                                    return; 
                                                }

                                                messenger.showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Misurazione salvata', 
                                                        ),
                                                    ),
                                                );

                                                navigator.pop(); 
                                            },

                                            icon: const Icon(
                                                Icons.save,
                                            ),


                                            label: const Text(
                                                'Save',
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


    Future<void> selectMeasurementDateTime() async {

        final date = await showDatePicker(
            context: context,
            initialDate: measurementDateTime,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
        );

        if (!mounted || date == null) {
            return;
        }

        final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(
                measurementDateTime,
            ),
        );

        if (!mounted || time == null) {
            return;
        }

        setState(() {
            measurementDateTime = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
            );
        });
    }


}