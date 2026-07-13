import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart'; 
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';

class AddMeasurementPage extends ConsumerStatefulWidget {

    const AddMeasurementPage({
        super.key,
    }); 
    
    @override
    ConsumerState<AddMeasurementPage> createState() => _AddMeasurementPageState();
}

class _AddMeasurementPageState extends ConsumerState<AddMeasurementPage> {

    final _formKey = GlobalKey<FormState>();

    final _systolicController = TextEditingController();

    final _diastolicController = TextEditingController();

    final _heartRateController = TextEditingController();



    @override
    void dispose() {

        _systolicController.dispose();

        _diastolicController.dispose();

        _heartRateController.dispose();

        super.dispose();

    }



    @override
    Widget build(BuildContext context) {

        return Scaffold(

            appBar: AppBar(
                title: const Text(
                    'Add Measurement',
                ),
            ),


            body: SingleChildScrollView(

                padding: const EdgeInsets.all(16),

                child: Form(

                    key: _formKey,

                    child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [


                            Text(
                                'Blood pressure values',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                            ),


                            const SizedBox(
                                height: 24,
                            ),


                            TextFormField(

                                controller: _systolicController,

                                keyboardType: TextInputType.number,

                                decoration: const InputDecoration(
                                    labelText: 'Systolic pressure',
                                    suffixText: 'mmHg',
                                ),


                                validator: (value) {

                                    if (value == null ||
                                        value.isEmpty) {

                                        return 'Required field';

                                    }


                                    final number = int.tryParse(value);


                                    if (number == null ||
                                        number < 50 ||
                                        number > 250) {

                                        return 'Enter a valid value';

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

                                decoration: const InputDecoration(
                                    labelText: 'Diastolic pressure',
                                    suffixText: 'mmHg',
                                ),


                                validator: (value) {

                                    if (value == null ||
                                        value.isEmpty) {

                                        return 'Required field';

                                    }


                                    final number = int.tryParse(value);


                                    if (number == null ||
                                        number < 30 ||
                                        number > 150) {

                                        return 'Enter a valid value';

                                    }


                                    return null;

                                },

                            ),


                            const SizedBox(
                                height: 16,
                            ),


                            TextFormField(

                                controller: _heartRateController,

                                keyboardType: TextInputType.number,

                                decoration: const InputDecoration(
                                    labelText: 'Heart rate',
                                    suffixText: 'bpm',
                                ),


                                validator: (value) {

                                    if (value == null ||
                                        value.isEmpty) {

                                        return 'Required field';

                                    }


                                    final number = int.tryParse(value);


                                    if (number == null ||
                                        number < 30 ||
                                        number > 220) {

                                        return 'Enter a valid value';

                                    }


                                    return null;

                                },

                            ),


                            const SizedBox(
                                height: 32,
                            ),


                            SizedBox(

                                width: double.infinity,

                                child: FilledButton.icon(

                                    onPressed: () async {

                                        if (_formKey.currentState!.validate()) {


                                            final measurement = BloodPressureMeasurement(

                                                patientId: 'TEMP_PATIENT_ID',

                                                systolicPressure: int.parse(
                                                    _systolicController.text,
                                                ),

                                                diastolicPressure: int.parse(
                                                    _diastolicController.text,
                                                ),

                                                heartRate: int.parse(
                                                    _heartRateController.text,
                                                ),

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
                                                        'Measurement saved', 
                                                    ),
                                                ),
                                            );

                                            navigator.pop(); 
                                        }

                                    },


                                    icon: const Icon(
                                        Icons.save,
                                    ),


                                    label: const Text(
                                        'Save',
                                    ),

                                ),

                            ),

                        ],

                    ),

                ),

            ),

        );

    }

}