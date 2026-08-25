import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/data/models/medical_history.dart';
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_form_page.dart';
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_provider.dart';



class MedicalHistoryDetailPage extends ConsumerWidget {


  const MedicalHistoryDetailPage({

    super.key,

    required this.patientId,
    //this.canPopAfterDelete = true, 
    this.onDeleted, 

    this.showBackButton = true, 

  });



  //final MedicalHistory history;
  final String patientId; 
  //final bool canPopAfterDelete;
  final bool showBackButton;  
  final VoidCallback? onDeleted;




  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {

    final history = ref
      .watch(medicalHistoryProvider)
      .where(
        (h) => h.patientId == patientId, 
      )
      .firstOrNull; 

    // additional check 
    if (history == null) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: showBackButton, 
          title: const Text(
            'Storia medica', 
          ), 
        ), 
        body: const Center(
          child: Text(
            'Nessuna anamnesi presente',
          ),
        ),
      );
    }

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: showBackButton, 
        title: const Text(
          'Storia medica',
        ),


        actions: [

          IconButton(

            icon: const Icon(Icons.edit),

            tooltip: 'Modifica', 


            onPressed: () async {
              
              await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => MedicalHistoryFormPage(
                    patientId: history.patientId,
                    history: history,
                  ),

                ),

              );

            },

          ),


        ],


      ),



      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ), 
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24), 
                children: [
                  _section(
                    context, 
                    'Familiarità',
                    [
                      _item(
                        context, 
                        'Ipertensione familiare',
                        history.familyHistoryHypertension,
                      ),

                    ],

                  ),

                  _section(
                    context, 
                    'Patologie',
                    [

                      _item(
                        context,
                        'Diabete',
                        history.diabetes,
                      ),

                      _item(
                        context,
                        'Malattie cardiovascolari',
                        history.cardiovascularDisease,
                      ),

                      _item(
                        context,
                        'Malattia renale',
                        history.kidneyDisease,
                      ),

                      _item(
                        context,
                        'Dislipidemia',
                        history.dyslipidemia,
                      ),

                      _item(
                        context,
                        'Precedente ictus',
                        history.previousStroke,
                      ),

                      _item(
                        context,
                        'Apnea notturna',
                        history.sleepApnea,
                      ),

                    ],

                  ),



                  _section(
                    context, 
                    'Stile di vita',
                    [

                      _item(
                        context,
                        'Fumatore',
                        history.smoker,
                      ),

                      _item(
                        context,
                        'Consumo alcool',
                        history.alcoholConsumption,
                      ),

                      _item(
                        context,
                        'Sedentarietà',
                        history.sedentaryLifestyle,
                      ),

                      _item(
                        context,
                        'Dieta ricca di sale',
                        history.highSaltDiet,
                      ),

                    ],

                  ),



                  _section(
                    context, 
                    'Informazioni aggiuntive',
                    [

                      _item(
                        context,
                        'Terapia antipertensiva',
                        history.antihypertensiveTherapy,
                      ),
                      
                      _infoItem(
                        context,
                        'Terapia',
                        history.currentTherapy,
                      ),

                      _infoItem(
                        context,
                        'Allergie',
                        history.allergies,
                      ),

                      _infoItem(
                        context,
                        'Note',
                        history.notes,
                      ),

                    ],
                  ),

                  const SizedBox(
                    height: 32,
                  ),

                  OutlinedButton.icon(
                    
                    icon: const Icon(Icons.delete_outline),

                    label: const Text('Elimina anamnesi'),

                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),

                    onPressed: () async {

                      final confirm = await showDialog<bool>(

                        context: context,

                        builder: (_) => AlertDialog(

                          title: const Text(
                            'Eliminare anamnesi?',
                          ),


                          actions: [

                            TextButton(

                              onPressed: () => Navigator.pop(
                                context,
                                false,
                              ),

                              child: const Text(
                                'Annulla',
                              ),

                            ),


                            FilledButton(

                              onPressed: () => Navigator.pop(
                                context,
                                true,
                              ),

                              child: const Text(
                                'Elimina',
                              ),

                            ),

                          ],

                        ),

                      );



                      if(confirm != true){
                        return;
                      }



                      await ref
                          .read(
                            medicalHistoryProvider.notifier,
                          )
                          .delete(
                            history.id,
                          );


                      onDeleted?.call(); 

                    },

                  )

                ],

              ),
            ),
          ),
        ),
      ),
  
    );

  }


  Widget _section(
    BuildContext context,   
    String title,
    List<Widget> children,
  ) {

    final colors = Theme.of(context).colorScheme; 

    return Card(

      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(
              children: [
                Container(
                  width: 8, 
                  height: 24, 
                  decoration: BoxDecoration(
                    color: colors.primary, 
                    borderRadius: BorderRadius.circular(4), 
                  ), 
                ), 

                const SizedBox(width: 12), 

                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600, 
                  ), 

                ),

              ], 
            ), 

            const SizedBox(height: 12),

            ...children,

          ],

        ),

      ),

    );

  }



  Widget _item(
    BuildContext context, 
    String label,
    bool value,
  ) {
    /*
    return Text(
      '$label: ${value ? "Sì" : "No"}',
    );
    */

    final colors = Theme.of(context).colorScheme; 

    return ListTile(
      dense: true, 
      contentPadding: EdgeInsets.zero,
      title: Text(label), 
      
      trailing: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10, 
          vertical: 6, 
        ), 
        decoration: BoxDecoration(
          color: value
            ? colors.primaryContainer
            : colors.surfaceContainerHighest, 
          borderRadius: BorderRadius.circular(20), 
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              value
                ? Icons.check
                : Icons.close,
              size: 18, 
              color: value
                ? colors.onPrimaryContainer
                : colors.onSurfaceVariant, 
            ),

            const SizedBox(width: 4), 

            Text(
              value ? 'Sì' : 'No', 
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: value
                  ? colors.onPrimaryContainer
                  : colors.onSurfaceVariant, 
                fontWeight: FontWeight.w600, 
              ),
            ), 
          ],
        ),
      ),
      
    ); 

  }


  Widget _infoItem(
    BuildContext context,
    String label,
    String value,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value.isEmpty ? 'Non specificato' : value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }


}