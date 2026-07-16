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

                floatingActionButton: FloatingActionButton(
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
                ),   

                actions: [
                    IconButton(
                        icon: const Icon(Icons.add),

                        tooltip: 'New Measurement',

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
                ],                    

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
                        'Section not available', 
                    ),
                ); 

        }

    }


    Widget _buildHomeContent(BuildContext context) {

        final user = ref.watch(currentUserProvider); 


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

                            const SizedBox(height: 32), 

                            if (user?.isPatient ?? false) ...[

                                Row(

                                    children: [

                                        Expanded(
                                            child: _homeCard(

                                                context: context, 

                                                icon: Icons.favorite, 

                                                title: 'Nuova misurazione', 

                                                subtitle: 'Valore',

                                                color: Theme.of(context).colorScheme.primary, 

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

                            ]

                            else ...[

                                Row(
                                    children: [

                                        Expanded(
                                            child: _homeCard(

                                                context: context, 

                                                icon: Icons.people, 

                                                title: "Pazienti", 

                                                subtitle: "Gestisci i tuoi pazienti", 

                                                color: Colors.indigo, 

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
                                                    "Quick Tip", 
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

        required VoidCallback onTap, 
    }) {

        return Card(
            
            clipBehavior: Clip.antiAlias, 

            child: InkWell(

                onTap: onTap, 

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
        ); 
    }

}