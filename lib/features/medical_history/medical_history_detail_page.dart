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

  });



  //final MedicalHistory history;
  final String patientId; 
  //final bool canPopAfterDelete; 
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

    
    if (history == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Nessuna anamnesi presente',
          ),
        ),
      );
    }

    print("detail rebuild"); 

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Storia medica',
        ),


        actions: [

          IconButton(

            icon:
                const Icon(
                  Icons.edit,
                ),

            tooltip: 'Modifica', 


            onPressed: () async {


              final updated = await Navigator.push<bool>(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                      MedicalHistoryFormPage(

                        patientId:
                            history.patientId,

                        history:
                            history,

                      ),

                ),

              );

              print(updated); 


            },

          ),


        ],


      ),



      body: Padding(

        padding:
            const EdgeInsets.all(16),


        child: ListView(

          children: [


            _section(

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

              'Informazioni aggiuntive',

              [

                _item(
                  context,
                  'Terapia antipertensiva',
                  history.antihypertensiveTherapy,
                ),
                

                Text(
                  'Terapia:\n${history.currentTherapy}',
                ),


                const SizedBox(
                  height: 12,
                ),


                Text(
                  'Allergie:\n${history.allergies}',
                ),


                const SizedBox(
                  height: 12,
                ),


                Text(
                  'Note:\n${history.notes}',
                ),

              ],

            ),



            const SizedBox(
              height: 32,
            ),



            FilledButton.icon(

              icon:
                  const Icon(
                    Icons.delete,
                  ),


              label:
                  const Text(
                    'Elimina anamnesi',
                  ),


              onPressed: () async {


                final confirm =
                    await showDialog<bool>(

                  context: context,


                  builder: (_) =>
                      AlertDialog(

                    title:
                        const Text(
                          'Eliminare anamnesi?',
                        ),


                    actions: [

                      TextButton(

                        onPressed: () =>
                            Navigator.pop(
                              context,
                              false,
                            ),

                        child:
                            const Text(
                              'Annulla',
                            ),

                      ),


                      FilledButton(

                        onPressed: () =>
                            Navigator.pop(
                              context,
                              true,
                            ),

                        child:
                            const Text(
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
                /*
                ref.invalidate(
                    medicalHistoryProvider,
                );
                */

                /*
                if(canPopAfterDelete && context.mounted){

                  Navigator.pop(
                    context, 
                  );

                }
                */


              },

            )

          ],

        ),

      ),

    );

  }





  Widget _section(
      String title,
      List<Widget> children,
  ){

    return Card(

      margin:
          const EdgeInsets.only(
            bottom: 16,
          ),


      child: Padding(

        padding:
            const EdgeInsets.all(16),


        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [

            Text(

              title,

              style:
                  const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),

            ),


            const SizedBox(
              height: 12,
            ),


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
  ){
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
      trailing: Icon(
        value
          ? Icons.check_circle
          : Icons.cancel_outlined, 
        color: value 
          ? Colors.green
          : colors.error, 
         // ? Theme.of(context).colorScheme.primary
          //: Theme.of(context).colorScheme.outline, 
      ),
    ); 

  }

}