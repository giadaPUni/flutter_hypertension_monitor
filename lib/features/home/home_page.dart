import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart'; 
import 'package:flutter_hypertension_monitor/shared/layout/main_layout.dart'; 
import 'package:flutter_hypertension_monitor/features/patients/patient_page.dart'; 
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_page.dart'; 
import 'package:flutter_hypertension_monitor/features/measurements/measurements_page.dart'; 
import 'package:flutter_hypertension_monitor/features/statistics/statistics_page.dart'; 
import 'package:flutter_hypertension_monitor/features/settings/settings_page.dart'; 
import 'package:flutter_hypertension_monitor/features/profile/profile_page.dart'; 
import 'package:flutter_hypertension_monitor/features/auth/auth_service_provider.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_routes.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/features/measurements/add_measurement_page.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/create_patient_page.dart';


class HomePage extends ConsumerStatefulWidget {

    const HomePage({
        super.key, 
    }); 

    @override
    ConsumerState<HomePage> createState() => _HomePageState();

}

class _HomePageState extends ConsumerState<HomePage> {

    NavigationSection _currentSection = NavigationSection.home; 

    bool _loggingOut = false; 

    @override
    Widget build(BuildContext context) {

        
        final user = ref.watch(currentUserProvider); 

        // Case Patient: 
        //if user is also the patient and its patientId is not null (that is the profile has been created)
        // then show the FAB to add new measurements
        final showFab = 
            user?.isPatient == true && 
            user?.patientId != null; 

        return PopScope(

            canPop: false, 
        
            child: MainLayout(

                title: const Text(
                    'Hypertension Monitor', 
                ),  

                currentSection: _currentSection, 

                onSectionSelected: (section) async {

                    if (section == NavigationSection.logout) {
                        await _confirmLogout(); 

                        return; 
                    }

                    setState(() {

                        _currentSection = section; 

                    });

                },

                body: _buildBody(), 

                floatingActionButton: 
                    showFab 
                        ? FloatingActionButton(
                            onPressed: () {

                                final user = ref.read(
                                    currentUserProvider,
                                );


                                if (user == null) {
                                    return;
                                }


                                if (user.patientId == null) {
                                    return;
                                }


                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => AddMeasurementPage(
                                            patientId: user.patientId!,
                                        ),
                                    ),
                                );

                            },

                            child: const Icon(
                                Icons.add,
                            ),
                          )   
                        : null, 

                actions: showFab
                    ? [
                        IconButton(
                            icon: const Icon(Icons.add),

                            tooltip: 'Nuova misurazione',

                            onPressed: () {

                                final user = ref.read(
                                    currentUserProvider,
                                );


                                if (user == null) {
                                    return;
                                }


                                if (user.patientId == null) {
                                    return;
                                }


                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => AddMeasurementPage(
                                            patientId: user.patientId!,
                                        ),
                                    ),
                                );

                            },
                        ),
                      ]  
                    : [],                 

            ), 
        ); 
    }


    Future<void> _confirmLogout() async {

        final confirm = await showDialog<bool>(

            context: context, 

            builder: (context) {

                return AlertDialog(

                    title: const Text(
                        'Logout', 
                    ), 

                    content: const Text(
                        'Sei sicuro di voler uscire dall\'applicazione?', 
                    ), 

                    actions: [

                        TextButton(
                            onPressed: () {

                                Navigator.pop(
                                    context, 
                                    false, 
                                );
                            },

                            child: const Text(
                                'Annulla', 
                            ), 
                        ), 

                        FilledButton(
                            
                            onPressed: () {

                                Navigator.pop(
                                    context, 
                                    true,
                                ); 
                            }, 

                            child: const Text(
                                'Logout', 
                            ), 
                        ), 
                    ], 
                );
            }, 

        );

        if (confirm == true) {

            await _logout(); 

        }
    }


    Future<void> _logout() async {

        if (_loggingOut) {
            return; 
        }

        _loggingOut = true; 

        await ref
            .read(authServiceProvider)
            .logout();


        ref
            .read(currentUserProvider.notifier)
            .logout();


        if (!mounted) {
            return;
        }


        Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
        );

    }



    Widget _buildBody() {

        switch (_currentSection) {

            case NavigationSection.home:
                return _buildHomeContent(context); 

            case NavigationSection.patients: 
                return const PatientPage(); 

            case NavigationSection.medicalHistory: 
                return const MedicalHistoryPage(); 

            case NavigationSection.measurements: 
                return const MeasurementsPage(); 

            case NavigationSection.statistics:
                return const StatisticsPage(); 

            case NavigationSection.profile:
                return const ProfilePage();
            
            case NavigationSection.settings: 
                return const SettingsPage(); 

            default: 
                return const Center(
                    child: Text(
                        'Sezione non disponibile', 
                    ),
                ); 

        }

    }


    Widget _buildHomeContent(BuildContext context) {

        final user = ref.watch(currentUserProvider); 

        final needsPatientProfile = 
            user?.isPatient == true && user?.patientId == null; 

        final needsFirstPatient = 
            user?.isUser == true && ref.watch(patientsProvider).isEmpty; 

        final canAddMeasurement =
            (user?.isPatient ?? false) && user?.patientId != null;



        return SingleChildScrollView(

            padding: const EdgeInsets.all(24),

            child: Center(

                child: ConstrainedBox(
                    
                    constraints: const BoxConstraints(
                        maxWidth: 600, 
                    ), 
                
                    child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                            Text(
                                'Benvenuto ${user?.name ?? ""}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge, //Medium
                            ),


                            const SizedBox(
                                height: 8, //24
                            ),

                            Text(
                                'Monitora l\'ipertensione e mantiene sotto controllo la tua salute.', 
                                style: Theme.of(context).textTheme.bodyLarge, 
                            ), 

                            const SizedBox(height: 24), 


                            // Use Case User Account: to add the very first patient 
                            if (needsFirstPatient)
                                _buildAddFirstPatientCard(context), 

                            const SizedBox(height: 32), 

                            if (user?.isPatient ?? false) ...[
                                
                                // Use Case Patient Account: it appears only if the patient did not complete its profile yet 
                                if (needsPatientProfile) ...[
                                    _buildCompleteProfileCard(context), 
                                ] else ...[

                                    Row(

                                        children: [

                                            Expanded(
                                                child: _homeCard(

                                                    context: context, 

                                                    icon: Icons.favorite, 

                                                    title: 'Nuova misurazione', 

                                                    subtitle: 'Valore',

                                                    color: Theme.of(context).colorScheme.primary, 

                                                    enabled: canAddMeasurement, 

                                                    onTap: () {
                                                        Navigator.push(
                                                            context, 
                                                            MaterialPageRoute(
                                                                builder: (_) => AddMeasurementPage(
                                                                    patientId: user!.patientId!, 
                                                                ), 
                                                            ),
                                                        );
                                                    }, 
                                                ), 
                                            ),

                                            const SizedBox(width: 16), 

                                            Expanded(
                                                child: _homeCard(
                                                    context: context, 

                                                    icon: Icons.analytics, 
                                                    
                                                    title: 'Statistiche', 

                                                    subtitle: 'Visualizza i trend e i grafici.', 

                                                    color: Colors.green, 

                                                    enabled: true, 

                                                    onTap: () {

                                                        setState((){
                                                            _currentSection = NavigationSection.statistics;
                                                        });
                                                    },
                                                ),
                                            ),

                                        ], 
                                    ), 

                                    const SizedBox(height: 24), 

                                    Card(
                                        
                                        child: ListTile(

                                            leading: const Icon(Icons.history), 

                                            title: const Text("Misurazioni recenti"),

                                            subtitle: const Text(
                                                "Le misurazioni vengono mostrate qui.", 
                                            ), 
                                        ),
                                    ),
                                ],
                            ]

                            else ...[

                                // Case User account 
                                Row(
                                    children: [

                                        Expanded(
                                            child: _homeCard(

                                                context: context, 

                                                icon: Icons.people, 

                                                title: "Pazienti", 

                                                subtitle: "Gestisci i tuoi pazienti", 

                                                color: Colors.indigo, 

                                                enabled: true, 

                                                onTap: () {

                                                    setState(() {
                                                        _currentSection = NavigationSection.patients; 

                                                    });
                                                },
                                            ),
                                        ),

                                        const SizedBox(width: 16), 

                                        Expanded(
                                            child: _homeCard(

                                                context: context, 

                                                icon: Icons.bar_chart, 

                                                title: 'Statistiche', 

                                                subtitle: 'Statistiche generali', 

                                                color: Colors.green, 

                                                enabled: true, 

                                                onTap: () {

                                                    setState((){
                                                        _currentSection = NavigationSection.statistics;
                                                    });
                                                },
                                            ),
                                        ),
                                    ],
                                ),

                                const SizedBox(height: 24), 

                                Card(

                                    child: Padding(

                                        padding: const EdgeInsets.all(24),

                                        child: Column(

                                            crossAxisAlignment: CrossAxisAlignment.start, 

                                            children: [

                                                Text(
                                                    "Suggerimento", 
                                                    style: Theme.of(context).textTheme.titleLarge, 
                                                ),

                                                const SizedBox(height: 8), 

                                                const Text(
                                                    "Selezionare un paziente dalla sezione Pazienti per visualizzare i dati clinici e registrare nuove misurazioni", 
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
                            ],

                        ],

                    ),

                ), 
            ), 
        ); 

    }    

    Widget _homeCard({

        required BuildContext context, 

        required IconData icon, 

        required String title, 

        required String subtitle, 

        required Color color, 

        required bool enabled, 

        required VoidCallback onTap, 
    }) {

        return Opacity(

            opacity: enabled ? 1.0 : 0.5, 
            child: Card(
                
                clipBehavior: Clip.antiAlias, 

                child: InkWell(

                    onTap: enabled ? onTap : null, 

                    child: Padding(

                        padding: const EdgeInsets.all(20), 

                        child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start, 

                            children: [

                                CircleAvatar(
                                    
                                    radius: 24, 

                                    backgroundColor: color.withValues(
                                        alpha: 0.12,
                                    ),

                                    child: Icon(
                                        icon, 
                                        color: color, 
                                        size: 28,
                                    ), 
                                ),

                                const SizedBox(height: 20), 

                                Text(
                                    title, 
                                    style: Theme.of(context).textTheme.titleLarge, 
                                ), 

                                const SizedBox(height: 8), 

                                Text(
                                    subtitle, 
                                    style: Theme.of(context).textTheme.bodyMedium,
                                ), 
                            ], 
                        ),
                    ),
                ),
            ), 

        );
        
        
    }

    // Case Patient 
    Widget _buildCompleteProfileCard(BuildContext context) {

        return Card(
            child: Padding(
                padding: const EdgeInsets.all(24), 
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [

                        const Icon(
                            Icons.monitor_health,  // person_add //monitor_health
                            size: 72, 
                        ), 

                        const SizedBox(height: 16), 

                        Text(
                            'Completa il tuo profilo', 
                            style: Theme.of(context).textTheme.titleLarge, 
                        ), 

                        const SizedBox(height: 8), 

                        const Text(
                            'Completa il tuo profilo con i tuoi dati anagrafici e antropometrici per iniziare a registrare le misurazioni della pressione.', 
                        ), 

                        const SizedBox(height: 20), 

                        FilledButton(
                            onPressed: () async {

                                await Navigator.push(
                                    
                                    context, 

                                    MaterialPageRoute(
                                        
                                        builder: (_) => const CreatePatientPage(), 

                                    ), 
                                
                                ); 
                            }, 

                            child: const Text(
                                'Completa il profilo', 
                            ), 
                        ), 
                    ], 
                ), 
            ), 
        ); 
    }


    // Case User Account 
    Widget _buildAddFirstPatientCard(BuildContext context) {

        return Card(
            
            child: Padding(

                padding: const EdgeInsets.all(24), 

                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start, 

                    children: [

                        const Icon(
                            Icons.people, 
                            size: 42, 
                        ), 

                        const SizedBox(height: 16), 

                        Text(
                            'Aggiungi il primo paziente', 
                            style: Theme.of(context).textTheme.titleLarge, 
                        ), 

                        const SizedBox(height: 8), 

                        const Text(
                            'Crea il profilo del tuo primo paziente per iniziare a monitorare le misurazioni.', 
                        ), 

                        const SizedBox(height: 20), 

                        FilledButton(
                            
                            onPressed: () async {

                                await Navigator.push(
                                    context, 

                                    MaterialPageRoute(

                                        builder: (_) => const CreatePatientPage(), 
                                    ), 
                                );
                            },

                            child: const Text(
                                'Aggiungi un paziente', 
                            ), 
                        ), 
                    ], 
                ), 
            ), 
        ); 
    }

}