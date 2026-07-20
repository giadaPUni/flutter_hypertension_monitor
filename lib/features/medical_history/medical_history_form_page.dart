import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/medical_history.dart';
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_provider.dart';
import 'package:flutter_hypertension_monitor/features/medical_history/widgets/medical_history_form.dart';


class MedicalHistoryFormPage extends ConsumerWidget {

    const MedicalHistoryFormPage({

        super.key,

        required this.patientId,

        this.history,

    });

    final String patientId;

    final MedicalHistory? history;



    bool get isEditing => history != null;



    @override
    Widget build(
        BuildContext context,
        WidgetRef ref,
    ) {


        final initialHistory = history ??
            MedicalHistory(
                patientId: patientId,
            );



        return Scaffold(

            appBar: AppBar(

                title: Text(

                isEditing
                    ? 'Modifica anamnesi'
                    : 'Nuova anamnesi',

                ),

            ),

            body: MedicalHistoryForm(

                history: initialHistory,

                onSave: (updatedHistory) async {


                    await ref
                        .read(
                            medicalHistoryProvider.notifier,
                        )
                        .save(
                            updatedHistory,
                        );


                    if(context.mounted){

                        Navigator.pop(
                            context,
                            true,
                        );

                    }


                },

            ), 
        ); 
    }

}