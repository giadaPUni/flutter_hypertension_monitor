import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/core/navigation/navigation_section.dart'; 
import 'package:flutter_hypertension_monitor/shared/layout/main_layout.dart';

import 'package:flutter_hypertension_monitor/features/patients/patient_page.dart'; 
import 'package:flutter_hypertension_monitor/features/medical_history/medical_history_page.dart'; 
import 'package:flutter_hypertension_monitor/features/measurements/measurements_page.dart'; 
import 'package:flutter_hypertension_monitor/features/statistics/statistics_page.dart'; 
import 'package:flutter_hypertension_monitor/features/profile/profile_page.dart';

import 'package:flutter_hypertension_monitor/features/auth/auth_service_provider.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_routes.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';

import 'package:flutter_hypertension_monitor/features/measurements/add_measurement_page.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/features/patients/create_patient_page.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurement_detail_page.dart';

import 'package:flutter_hypertension_monitor/shared/widgets/blood_pressure_card.dart';

import 'package:flutter_hypertension_monitor/core/theme/app_colors.dart';
import 'package:flutter_hypertension_monitor/core/theme/app_radius.dart';

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
            ), 
        ); 
    }

    void _openAddMeasurement() {

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
    }


    void _openStatistics() {
        setState((){
            _currentSection = NavigationSection.statistics; 
        }); 
    }

    void _openPatients() {
        setState((){
            _currentSection = NavigationSection.patients; 
        });
    }

    // ---- Logout ----

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
            
            default: 
                return const Center(
                    child: Text(
                        'Sezione non disponibile', 
                    ),
                ); 

        }

    }

    // ---- Home ---- 

    Widget _buildHomeContent(BuildContext context) {

        final user = ref.watch(currentUserProvider); 

        final needsPatientProfile = 
            user?.isPatient == true && user?.patientId == null; 

        final patients = ref.watch(
            patientsProvider, 
        ); 

        final measurements = ref.watch(
            bloodPressureMeasurementsProvider, 
        ); 

        final needsFirstPatient = 
            user?.isUser == true && ref.watch(patientsProvider).isEmpty; 

        /*
        final canAddMeasurement =
            (user?.isPatient ?? false) && user?.patientId != null;
        */

        return LayoutBuilder(

            builder: (context, constraints) {

                final isWide = constraints.maxWidth >= 900; 
        
                return SingleChildScrollView(

                    //padding: const EdgeInsets.all(24),
                    padding: EdgeInsets.symmetric(
                        horizontal: isWide ? 40 : 24, 
                        vertical: 28, 
                    ), 

                    child: Center(

                        child: ConstrainedBox(
                            
                            constraints: const BoxConstraints(
                                //maxWidth: 600, 
                                maxWidth: 1100, 
                            ), 
                        
                            child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                    _buildWelcomeHeader(
                                        context, 
                                        user?.name ?? '', 
                                    ), 

                                    const SizedBox(height: 24), 


                                    // Use Case User Account: to add the very first patient 
                                    if (needsFirstPatient)
                                        _buildAddFirstPatientCard(context) 

                                        //const SizedBox(height: 32), 

                                    // Patient Account 
                                    else if (user?.isPatient == true) 
                                        _buildPatientDashboard(
                                            context, 
                                            needsPatientProfile, 
                                            isWide, 
                                        )
                                    // User Account 
                                    else
                                        _buildUserDashboard(
                                            context, 
                                            patients.length,
                                            measurements.length, 
                                            isWide, 
                                        ), 

                                ],

                            ),

                        ), 
                    ), 
                ); 
            
            }
        ); 
    }    

    // --- Welcome header --- 
    Widget _buildWelcomeHeader(
        BuildContext context,
        String name,
    ) {

        final displayName =
            name.trim().isEmpty
                ? ''
                : ', $name';

        return Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

                Text(
                    'Benvenuto$displayName',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge,
                ),
                const SizedBox(
                    height: 8,
                ),

                Text(
                    'Monitora la pressione arteriosa e mantieni sotto controllo la tua salute.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge,
                ),
            ],
        );
    }


    Widget _buildPatientDashboard(
        BuildContext context, 
        bool needsPatientProfile, 
        bool isWide, 
    ) {
        if (needsPatientProfile) {
            return _buildCompleteProfileCard(
                context, 
            ); 
        }

        final user = ref.watch(
            currentUserProvider, 
        ); 

        if (user?.patientId == null) {
            return const SizedBox.shrink(); 
        }

        return Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

                Text(
                    'Accesso rapido',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                ),

                const SizedBox(
                    height: 12,
                ),

                if (isWide)

                    Row(

                        children: [

                            Expanded(
                                child: _buildActionCard(
                                    context: context,
                                    icon: Icons.favorite_rounded,
                                    title: 'Nuova misurazione',
                                    subtitle:
                                        'Registra pressione e frequenza cardiaca.',
                                    color: AppColors.primary,
                                    onTap: _openAddMeasurement,
                                ),
                            ),

                            const SizedBox(
                                width: 16,
                            ),

                            Expanded(
                                child: _buildActionCard(
                                    context: context,
                                    icon: Icons.insights_rounded,
                                    title: 'Statistiche',
                                    subtitle:
                                        'Visualizza trend e andamento nel tempo.',
                                    color: AppColors.secondary,
                                    onTap: _openStatistics,
                                ),
                            ),
                        ],
                    )

                else
                    Column(

                        children: [

                            _buildActionCard(
                                context: context,
                                icon: Icons.favorite_rounded,
                                title: 'Nuova misurazione',
                                subtitle:
                                    'Registra pressione e frequenza cardiaca.',
                                color: AppColors.primary,
                                onTap: _openAddMeasurement,
                            ),

                            _buildActionCard(
                                context: context,
                                icon: Icons.insights_rounded,
                                title: 'Statistiche',
                                subtitle:
                                    'Visualizza trend e andamento nel tempo.',
                                color: AppColors.secondary,
                                onTap: _openStatistics,
                            ),
                        ],
                    ),                
                const SizedBox(
                    height: 28,
                ),

                _buildLatestMeasurementCard(
                    context,
                ),
            ],
        );

    }


    // --- User Dashboard --- 
    Widget _buildUserDashboard(
        BuildContext context,
        int patientCount,
        int measurementCount,
        bool isWide,
    ) {

        return Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

                Text(
                    'Panoramica',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                ),

                const SizedBox(
                    height: 12,
                ),

                if (isWide)
                    Row(

                        children: [

                            Expanded(
                                child: _buildMetricCard(
                                    context: context,
                                    icon: Icons.people_alt_rounded,
                                    value:
                                        patientCount.toString(),
                                    label: 'Pazienti',
                                    color: AppColors.primary,
                                    onTap: _openPatients,
                                ),
                            ),

                            const SizedBox(
                                width: 16,
                            ),
                            Expanded(
                                child: _buildMetricCard(
                                    context: context,
                                    icon: Icons.favorite_rounded,
                                    value:
                                        measurementCount.toString(),
                                    label: 'Misurazioni',
                                    color: AppColors.heartRate,
                                    onTap: () {

                                        setState(() {

                                            _currentSection =
                                                NavigationSection.measurements;
                                        });
                                    },
                                ),
                            ),
                        ],
                    )
                else

                    Column(

                        children: [

                            _buildMetricCard(
                                context: context,
                                icon: Icons.people_alt_rounded,
                                value:
                                    patientCount.toString(),
                                label: 'Pazienti',
                                color: AppColors.primary,
                                onTap: _openPatients,
                            ),                                                                
                            _buildMetricCard(
                                context: context,
                                icon: Icons.favorite_rounded,
                                value:
                                    measurementCount.toString(),
                                label: 'Misurazioni',
                                color: AppColors.heartRate,
                                onTap: () {

                                    setState(() {

                                        _currentSection =
                                            NavigationSection.measurements;
                                    });
                                },
                            ),
                        ],
                    ),
                const SizedBox(
                    height: 28,
                ),

                Text(
                    'Azioni rapide',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                ),

                const SizedBox(
                    height: 12,
                ),

                _buildQuickActionTile(
                    context: context,
                    icon: Icons.person_add_alt_1_rounded,
                    title: 'Aggiungi paziente',
                    subtitle:
                        'Crea un nuovo profilo paziente.',
                    onTap: () async {

                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const CreatePatientPage(),
                            ),
                        );
                    },
                ),

                const SizedBox(
                    height: 10,
                ),
                _buildQuickActionTile(
                    context: context,
                    icon: Icons.people_alt_rounded,
                    title: 'Gestisci pazienti',
                    subtitle:
                        'Visualizza e modifica i pazienti.',
                    onTap: _openPatients,
                ),

                const SizedBox(
                    height: 10,
                ),

                _buildQuickActionTile(
                    context: context,
                    icon: Icons.insights_rounded,
                    title: 'Visualizza statistiche',
                    subtitle:
                        'Analizza le misurazioni disponibili.',
                    onTap: _openStatistics,
                ),
            ],
        );
    }


    Widget _buildMetricCard({
        required BuildContext context,
        required IconData icon,
        required String value,
        required String label,
        required Color color,
        required VoidCallback onTap,
    }) {

        return Card(

            child: InkWell(

                onTap: onTap,

                child: Padding(

                    padding: const EdgeInsets.all(22),

                    child: Row(

                        children: [

                            Container(

                                width: 52,
                                height: 52,

                                decoration: BoxDecoration(

                                    color: color.withValues(
                                        alpha: 0.10,
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(
                                            AppRadius.lg,
                                        ),
                                ),

                                child: Icon(
                                    icon,
                                    color: color,
                                    size: 26,
                                ),
                            ),
                            const SizedBox(
                                width: 16,
                            ),

                            Expanded(

                                child: Column(

                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [

                                        Text(
                                            value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                        ),

                                        const SizedBox(
                                            height: 2,
                                        ),

                                        Text(
                                            label,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                        ),
                                    ],
                                ),
                            ),

                            Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.textTertiary,
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

    Widget _buildActionCard({
        required BuildContext context,
        required IconData icon,
        required String title,
        required String subtitle,
        required Color color,
        required VoidCallback onTap,
    }) {

        return Card(

            child: InkWell(

                onTap: onTap,

                child: Padding(

                    padding: const EdgeInsets.all(22),

                    child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                            Container(

                                width: 50,
                                height: 50,

                                decoration: BoxDecoration(

                                    color: color.withValues(
                                        alpha: 0.10,
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(
                                            AppRadius.lg,
                                        ),
                                ),

                                child: Icon(
                                    icon,
                                    color: color,
                                    size: 26,
                                ),
                            ),

                            const SizedBox(
                                height: 18,
                            ),

                            Text(
                                title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge,
                            ),

                            const SizedBox(
                                height: 6,
                            ),

                            Text(
                                subtitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium,
                            ),

                            const SizedBox(
                                height: 14,
                            ),

                            Row(

                                children: [

                                    Text(
                                        'Apri',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                    ),

                                    const SizedBox(
                                        width: 4,
                                    ),

                                    const Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 17,
                                        color: AppColors.primary,
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

    Widget _buildQuickActionTile({
        required BuildContext context,
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
    }) {

        return Card(

            child: InkWell(

                onTap: onTap,

                child: Padding(

                    padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                    ),

                    child: Row(

                        children: [

                            Container(

                                width: 44,
                                height: 44,

                                decoration: BoxDecoration(

                                    color: AppColors.primaryLight,

                                    borderRadius:
                                        BorderRadius.circular(
                                            AppRadius.md,
                                        ),
                                ),

                                child: Icon(
                                    icon,
                                    color: AppColors.primary,
                                    size: 21,
                                ),
                            ),

                            const SizedBox(
                                width: 14,
                            ),

                            Expanded(

                                child: Column(

                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [

                                        Text(
                                            title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                        ),

                                        const SizedBox(
                                            height: 3,
                                        ),

                                        Text(
                                            subtitle,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                        ),
                                    ],
                                ),
                            ),

                            const Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.textTertiary,
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

    Widget _buildLatestMeasurementCard(BuildContext context) {

        final user = ref.watch(currentUserProvider);

        if (user?.patientId == null) {
            return const SizedBox.shrink();
        }

        // user and patientId exist 
        final patientId = user!.patientId!; 


        // Measurements for this patient already sorted from newest to oldest 
        // (patientMeasurementsProvider in blood_pressure_measurements_provider) 
        final measurements = ref.watch(
            patientMeasurementsProvider(patientId) 
        );

        
        // Since the provider already sorted the list, first is equal to newest measurement
        final latestMeasurement =
            measurements.isEmpty
                ? null
                : measurements.first;

        return Card(

            child: Padding(

            padding: const EdgeInsets.all(22),

                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                        Row(
                            children: [

                                Expanded(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, 

                                        children: [

                                            Text(
                                                "Ultima misurazione registrata",
                                                style: Theme.of(context).textTheme.titleLarge,
                                            ),

                                            const SizedBox(height: 16),

                                            Text(
                                                measurements.isEmpty
                                                    ? 'Nessun dato disponibile'
                                                    : 'Il tuo valore più recente',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                            ),
                                        ],
                                    ), 
                                ),

                            ], 
                        ), 

                        const SizedBox(height: 18), 

                        if (latestMeasurement == null)
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14), 

                                child: Text(
                                    'Registra la tua prima misurazione per iniziare a visualizzare qui i tuoi dati',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                ), 
                            )

                        else ...[

                            BloodPressureCard(

                                measurement: latestMeasurement,

                                embedded: true,

                                compact: false,

                                showPatientName: false,

                                onTap: () {

                                    Navigator.push(

                                        context,

                                        MaterialPageRoute(

                                            builder: (_) => MeasurementDetailPage(
                                                measurement: latestMeasurement,
                                            ),
                                        ),
                                    );

                                },

                            ),

                            const SizedBox(height: 10),

                            Align(
                                alignment: Alignment.centerRight,

                                /*
                                child: TextButton(
                                    child: const Text("Guarda tutte le misurazioni"),
                                    onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Scaffold(
                                                    appBar: AppBar(
                                                        title: const Text("Tutte le misurazioni"),
                                                    ),
                                                    body: MeasurementsPage(
                                                        patientId: patientId,
                                                    ),
                                                ),
                                            ),
                                        );
                                    },
                                ),
                                */
                                child: TextButton.icon(

                                    onPressed: () {

                                        setState(() {

                                            _currentSection =
                                                NavigationSection.measurements;
                                        });
                                    },

                                    icon: const Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 17,
                                    ),

                                    label: const Text(
                                        'Tutte le misurazioni',
                                    ),
                                ),                                
                            ),  
                        ],

                    ],
                ),
            ),
        );
    }



    // --- Complete Patient Account Profile --- 
    Widget _buildCompleteProfileCard(BuildContext context) {

        return Card(
            child: Padding(
                padding: const EdgeInsets.all(24), 
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [

                        Container(
                            width: 58, 
                            height: 58, 

                            decoration: BoxDecoration(

                                color: AppColors.primaryLight, 

                                borderRadius: BorderRadius.circular(AppRadius.lg), 
                            ), 
                            
                            child: const Icon(
                                //Icons.person_add,  // person_add //monitor_health
                                Icons.person_add_alt_1_rounded, 
                                color: AppColors.primary, 
                                size: 28, 
                            ), 
                        ), 
                            

                        const SizedBox(height: 16), 

                        Text(
                            'Completa il tuo profilo', 
                            style: Theme.of(context).textTheme.headlineSmall, 
                        ), 

                        const SizedBox(height: 8), 

                        Text(
                            'Inserisci i tuoi dati anagrafici e antropometrici per iniziare a registrare e monitorare le misurazioni della pressione.', 
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium, 
                        ), 

                        const SizedBox(height: 20), 

                        FilledButton.icon(
                            onPressed: () async {

                                await Navigator.push(
                                    
                                    context, 

                                    MaterialPageRoute(
                                        
                                        builder: (_) => const CreatePatientPage(), 

                                    ), 
                                
                                ); 
                            }, 

                            icon: const Icon(
                                Icons.arrow_forward_rounded, 
                                size: 19, 
                            ), 

                            label: const Text('Completa il profilo'), 
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

                        Container(
                            width: 58,
                            height: 58,

                            decoration: BoxDecoration(

                                color: AppColors.primaryLight,

                                borderRadius:
                                    BorderRadius.circular(
                                        AppRadius.lg,
                                    ),
                            ),
                            child: const Icon(
                                Icons.people_alt_rounded,
                                color: AppColors.primary,  
                                size: 28, 
                            ), 

                        ),

                        const SizedBox(height: 16), 

                        Text(
                            'Aggiungi il tuo primo paziente', 
                            style: Theme.of(context).textTheme.headlineSmall, 
                        ), 

                        const SizedBox(height: 8), 

                        Text(
                            'Crea il profilo del tuo primo paziente per iniziare a monitorarne le misurazioni e i dati clinici.', 
                            style: Theme.of(context).textTheme.bodyMedium
                        ), 

                        const SizedBox(height: 20), 

                        FilledButton.icon(
                            
                            onPressed: () async {

                                await Navigator.push(
                                    context, 

                                    MaterialPageRoute(

                                        builder: (_) => const CreatePatientPage(), 
                                    ), 
                                );
                            },

                            icon: const Icon(
                                Icons.add_rounded, 
                                size: 19, 
                            ), 
                            label: const Text(
                                'Aggiungi un paziente', 
                            ), 
                        ), 
                    ], 
                ), 
            ), 
        ); 
    }

}