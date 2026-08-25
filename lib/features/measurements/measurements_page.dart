import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/features/measurements/measurement_detail_page.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/user_role.dart';

import 'package:flutter_hypertension_monitor/features/measurements/add_measurement_page.dart';
import 'package:flutter_hypertension_monitor/shared/widgets/blood_pressure_card.dart'; 

class MeasurementsPage extends ConsumerWidget {

  const MeasurementsPage({
    super.key,
    this.patientId, 
  });

  final String? patientId; 

  @override
    Widget build(
        BuildContext context,
        WidgetRef ref,
    ) {

        // If patientId is not provided then get all the sorted measurements 
        // otherwise, get the patient's sorted measurements 
        final measurements = patientId == null 
            ? ref.watch(
                sortedBloodPressureMeasurementsProvider, 
                )
            : ref.watch(
                patientMeasurementsProvider(patientId!), 
                ); 


        final patients = ref.watch(
            patientsProvider, 
        ); 

        final currentUser = ref.watch(
            currentUserProvider,
        );

        if (currentUser == null) {
            return const Center(
                child: Text('Nessun utente autenticato'), 
            );
        }

        // case Patient: it's not necessary to show patientName at every measurement
        // case User: show every patientName of the patients (if it's in the main global page)
        final showPatientName = 
            currentUser.role == UserRole.user && patientId == null; 


        final canAddMeasurement = 
            currentUser.role == UserRole.patient && 
            currentUser.patientId != null; 


        return Scaffold(

            floatingActionButton: canAddMeasurement
                ? Tooltip(
                    message: 'Nuova misurazione', 
                    child: FloatingActionButton(
                        onPressed: () async {

                            await Navigator.push(
                                context, 
                                MaterialPageRoute(
                                    builder: (_) => AddMeasurementPage(
                                        patientId: currentUser.patientId!, 
                                    ), 
                                ),
                            );
                        },

                        child: const Icon(
                            Icons.add,
                        ),
                    ), 
                  )
                : null, 

            body: measurements.isEmpty

                ? _buildEmptyState(
                    context, 
                    canAddMeasurement, 
                  )

                : ListView.builder(

                    padding: const EdgeInsets.all(16),

                    itemCount: measurements.length,

                    itemBuilder: (context, index) {

                        final measurement = measurements[index];

                        final patientName = patients
                            .where(
                                (patient) => 
                                    patient.id == measurement.patientId, 
                            )
                            .map(
                                (patient) => 
                                    '${patient.firstName} ${patient.lastName}', 
                            )
                            .firstOrNull; 


                        return BloodPressureCard(

                            measurement: measurement, 

                            patientName: patientName, 

                            showPatientName: showPatientName,  

                            onTap: () {

                                Navigator.push(
                                    context, 

                                    MaterialPageRoute(
                                        builder: (_) => MeasurementDetailPage(
                                            measurement: measurement, 
                                        ), 
                                    ), 
                                ); 
                            }, 
                        ); 

                    },

                ),

        );
    }

    Widget _buildEmptyState(
        BuildContext context,
        bool canAddMeasurement,
    ) {
        return Center(
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                        Container(
                            width: 72,
                            height: 72,

                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.10),

                                shape: BoxShape.circle,
                            ),

                            child: Icon(
                                Icons.monitor_heart_outlined,
                                size: 36,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                            ),
                        ),
                        const SizedBox(
                            height: 20,
                        ),

                        Text(
                            'Nessuna misurazione',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge,
                        ),

                        const SizedBox(
                            height: 8,
                        ),

                        Text(
                            'Registra le misurazioni della pressione per iniziare a monitorarne i valori.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                        ),
                    ],
                ),
            ),
        );
    }                    


}