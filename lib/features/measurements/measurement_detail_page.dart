import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';
import 'package:flutter_hypertension_monitor/shared/widgets/pressure_status_chip.dart';

class MeasurementDetailPage extends ConsumerWidget {

    const MeasurementDetailPage({
        super.key,
        required this.measurement,
    });


    final BloodPressureMeasurement measurement;


    @override
    Widget build(
        BuildContext context,
        WidgetRef ref,
    ) {

        final colors = Theme.of(context).colorScheme; 

        return Scaffold(

            appBar: AppBar(
                title: const Text(
                    'Dettaglio misurazione',
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

                                                    const SizedBox(height: 16),

                                                    Text(
                                                        'Pressione arteriosa', 
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium, 
                                                    ), 

                                                    const SizedBox(height: 8), 

                                                    Text(
                                                        '${measurement.systolicPressure}'
                                                        '/'
                                                        '${measurement.diastolicPressure}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall
                                                            ?.copyWith(
                                                                fontWeight: FontWeight.w600,
                                                            ),  
                                                    ),

                                                    const SizedBox(height: 4), 

                                                    Text(
                                                        'mmHg',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                    ),

                                                    const SizedBox(height: 16),

                                                    PressureStatusChip(
                                                        measurement: measurement,
                                                    ),

                                                ], 
                                            ), 
                                        ), 
                                    ), 

                                    const SizedBox(height: 16), 
                                
                                    Card(
                                        child: Padding(
                                            padding: const EdgeInsets.all(20),

                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: [

                                                    Text(
                                                        'Informazioni',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge,
                                                    ),

                                                    const SizedBox(height: 16),

                                                    ListTile(
                                                        contentPadding: EdgeInsets.zero,
                                                        leading: const Icon(
                                                            Icons.monitor_heart_outlined,
                                                        ),
                                                        title: const Text(
                                                            'Frequenza cardiaca',
                                                        ),
                                                        subtitle: Text(
                                                            '${measurement.heartRate} bpm',
                                                        ),
                                                    ),

                                                    ListTile(
                                                        contentPadding: EdgeInsets.zero,
                                                        leading: const Icon(
                                                            Icons.calendar_today_outlined,
                                                        ),
                                                        title: const Text(
                                                            'Data e ora',
                                                        ),
                                                        subtitle: Text(
                                                            '${measurement.measurementDateTime.day}/'
                                                            '${measurement.measurementDateTime.month}/'
                                                            '${measurement.measurementDateTime.year} '
                                                            '${measurement.measurementDateTime.hour}:'
                                                            '${measurement.measurementDateTime.minute.toString().padLeft(2, '0')}',
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),   

                                    const SizedBox(height: 24),

                                    OutlinedButton.icon(
                                        onPressed: () async {

                                            final confirm = await showDialog<bool>(
                                                context: context,

                                                builder: (context) => AlertDialog(
                                                    title: const Text(
                                                        'Eliminare misurazione?',
                                                    ),

                                                    content: const Text(
                                                        'Questa operazione non può essere annullata.',
                                                    ),

                                                    actions: [

                                                        TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(context, false),

                                                            child: const Text(
                                                                'Annulla',
                                                            ),
                                                        ),

                                                        FilledButton(
                                                            onPressed: () =>
                                                                Navigator.pop(context, true),

                                                            child: const Text(
                                                                'Elimina',
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            );

                                            if (confirm != true) {
                                                return;
                                            }   

                                            await ref
                                                .read(
                                                    bloodPressureMeasurementsProvider.notifier,
                                                )
                                                .delete(
                                                    measurement.id,
                                                );

                                            if (!context.mounted) {
                                                return;
                                            }

                                            Navigator.pop(context);
                                        },

                                        icon: const Icon(
                                            Icons.delete_outline,
                                        ),

                                        label: const Text(
                                            'Elimina misurazione',
                                        ),
                                    ),                                                                                             

                                ],
                            ),
                        ),
                    ),
                ),
            ),
        

        );

    }

}