import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_hypertension_monitor/features/statistics/statistics_provider.dart';

import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/data/models/patient.dart';
import 'package:flutter_hypertension_monitor/features/patients/patients_provider.dart';
import 'package:flutter_hypertension_monitor/features/measurements/measurements_provider.dart';
import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';


class StatisticsPage extends ConsumerStatefulWidget {

  const StatisticsPage({
    super.key,
  });

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
} 


class _StatisticsPageState extends ConsumerState<StatisticsPage> {

  @override
  Widget build(BuildContext context) {

    final currentUser = ref.watch(
      currentUserProvider, 
    ); 


    final selectedPatientId = ref.watch(
      selectedStatisticsPatientProvider,
    ); 


    if (currentUser == null) {
      return const Center(
        child: Text('Nessun utente autenticato'), 
      ); 
    }

    // Patient Account 
    if (currentUser.isPatient) {

      final patientId = currentUser.patientId; 

      if (patientId == null) {
        return const Center(
          child: Text('Nessun paziente associato'),
        ); 
      }

      return _StatisticsContent(
        patientId: patientId, 
      ); 
    }

    // User Account 

    final patients = ref.watch(
      patientsProvider,
    ); 

    if (patients.isEmpty) {
      return const Center(
        child: Text('Nessun paziente disponibile'), 
      ); 
    }

    // Check wethert the selected patient still exists
    final selectedPatientExists = patients.any(
      (patient) => patient.id == selectedPatientId,
    );


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Padding(
          padding: const EdgeInsets.all(16),

          child: _PatientSelector(
            patients: patients, 
            selectedPatientId: selectedPatientExists ? selectedPatientId : null, 
            onChanged: (value) {
              ref
                .read(selectedStatisticsPatientProvider.notifier,
                )
                .select(value); 
            },
          ),

          /*
          child: Row(

            crossAxisAlignment: CrossAxisAlignment.center, 

            children: [
              Text(
                'Paziente', 
                style: Theme.of(context)
                  .textTheme
                  .titleMedium, 
              ), 

              const SizedBox(height: 16), 

              SizedBox( 
                width: 240, 
                child: DropdownButtonFormField<String>(

                  initialValue: selectedPatientId,

                  decoration: InputDecoration(

                    hintText: 'Seleziona un paziente',

                    isDense: true, 

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, 
                      vertical: 10, 
                    ), 

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context)
                          .colorScheme
                          .outline,
                      ),                    
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context)
                          .colorScheme
                          .primary,
                        width: 2,
                      ),
                    ),
                  ), 

                  items: patients.map(
                    (Patient patient) {

                      return DropdownMenuItem<String>(

                        value: patient.id,

                        child: Text(
                          '${patient.firstName} '
                          '${patient.lastName}',
                          overflow: TextOverflow.ellipsis, 
                        ),
                      );
                    },
                  ).toList(),

                  onChanged: (value) {
                    setState(() {
                      selectedPatientId = value;
                    });
                  },
                ),

              ),


            ],
          ), 
          */


        ),

        Expanded(
          child: selectedPatientId == null 
            ? const Center(
                child: Text(
                  'Seleziona un paziente per visualizzare le statistiche', 
                  textAlign: TextAlign.center, 
                ),
              )
            : _StatisticsContent(
                patientId: selectedPatientId, 
              ), 
        ), 
      ],
    ); 
  }
}


class _PatientSelector extends StatelessWidget {

  const _PatientSelector({
    required this.patients,
    required this.selectedPatientId,
    required this.onChanged,
  });

  final List<Patient> patients;
  final String? selectedPatientId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.sizeOf(context).width;

    final isNarrow = width < 500;

    final dropdown = DropdownButtonFormField<String>(
      initialValue: selectedPatientId,

      decoration: InputDecoration(
        hintText: 'Seleziona un paziente',

        isDense: true,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: patients.map(
        (Patient patient) {

          return DropdownMenuItem<String>(
            value: patient.id,

            child: Text(
              '${patient.firstName} ${patient.lastName}',
              overflow: TextOverflow.ellipsis,
            ),
          );

        },
      ).toList(),

      onChanged: onChanged,
    );        

    if (isNarrow) {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Paziente',
            style: Theme.of(context)
              .textTheme
              .titleMedium,
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: dropdown,
          ),
        ],
      );
    }

    return Row(
      children: [

        Text(
          'Paziente',
          style: Theme.of(context)
            .textTheme
            .titleMedium,
        ),

        const SizedBox(width: 16),

        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 320,
            ),
            child: dropdown,
          ),
        ),
      ],
    );
  }

}



class _StatisticsContent extends ConsumerWidget {

  const _StatisticsContent({
    required this.patientId, 
  }); 

  final String patientId; 

  @override
  Widget build(
    BuildContext context, 
    WidgetRef ref, 
  ) {


    final statistics = ref.watch(
      bloodPressureStatisticsProvider(patientId),
    ); 

    final measurements = ref.watch(
      patientMeasurementsProvider(patientId),
    );

    if (statistics.measurementCount == 0) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 

          children: [

            Icon(
              Icons.analytics_outlined, 
              size: 70, 
              color: Colors.grey, 
            ), 

            SizedBox(height: 20), 

            Text('Non sono presenti misurazioni'), 

            SizedBox(height: 8), 

            Text(
              'Aggiungi alcune misurazioni per vedere le statistiche', 
              textAlign: TextAlign.center, 
            ), 
          ], 
        ), 
      ); 
    }

    return SingleChildScrollView(

      padding: const EdgeInsets.all(16), 

      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width >= 600
              ? 1000
              : double.infinity, 
          ), 


          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start, 

            children: [
              Text(
                'Statistiche', 
                style: Theme.of(context)
                  .textTheme
                  .headlineMedium, 
              ),

              const SizedBox(height: 8), 

              Text(
                '${statistics.measurementCount} misurazioni', 
                style: Theme.of(context)
                  .textTheme
                  .bodyMedium, 
              ), 

              const SizedBox(height: 24), 

              LayoutBuilder(
                builder: (context, constraints) {

                  if (constraints.maxWidth < 500) {

                    return Column(
                      children: [

                        _StatisticCard(
                          title: 'Pressione sistolica',
                          value: '${statistics.averageSystolic!.toStringAsFixed(0)} mmHg',
                          icon: Icons.arrow_upward,
                        ),

                        const SizedBox(height: 12),

                        _StatisticCard(
                          title: 'Pressione diastolica',
                          value: '${statistics.averageDiastolic!.toStringAsFixed(0)} mmHg',
                          icon: Icons.arrow_downward,
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [

                      Expanded(
                        child: _StatisticCard(
                          title: 'Pressione sistolica',
                          value: '${statistics.averageSystolic!.toStringAsFixed(0)} mmHg',
                          icon: Icons.arrow_upward,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _StatisticCard(
                          title: 'Pressione diastolica',
                          value: '${statistics.averageDiastolic!.toStringAsFixed(0)} mmHg',
                          icon: Icons.arrow_downward,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 12), 

              _StatisticCard(
                title: 'Frequenza cardiaca media', 
                value: '${statistics.averageHeartRate!.toStringAsFixed(0)} bpm', 
                icon: Icons.favorite, 
              ), 

              const SizedBox(height: 24), 

              Text(
                'Intervallo delle misurazioni', 
                style: Theme.of(context)
                  .textTheme
                  .titleLarge, 
              ), 

              const SizedBox(height: 12), 

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16), 

                  child: Column(

                    children: [

                      _RangeRow(
                        label: 'Sistolica', 
                        min: statistics.minSystolic!, 
                        max: statistics.maxSystolic!, 
                        unit: 'mmHg', 
                      ), 

                      const Divider(), 

                      _RangeRow(
                        label: 'Diastolica',
                        min: statistics.minDiastolic!,
                        max: statistics.maxDiastolic!,
                        unit: 'mmHg',                    
                      ), 
                    ], 
                  ), 
                ), 
              ), 

              const SizedBox(height: 32), 

              Text(
                'Andamento', 
                style: Theme.of(context)
                  .textTheme
                  .titleLarge,
              ), 

              const SizedBox(height: 12), 

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _BloodPressureChart(
                    measurements: measurements,
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



class _StatisticCard extends StatelessWidget {

  const _StatisticCard({
    required this.title,
    required this.value,
    required this.icon,
  });


  final String title;
  final String value;
  final IconData icon;


  @override
  Widget build(BuildContext context) {

    return Card(

      child: Padding(

        padding: const EdgeInsets.all(16), 

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start, 

          children: [

            Icon(
              icon, 
              color: Theme.of(context)
                .colorScheme
                .primary, 
            ), 

            const SizedBox(height: 12), 

            Text(
              title, 
              style: Theme.of(context)
                .textTheme
                .bodyMedium,
              maxLines: 2, 
              overflow: TextOverflow.ellipsis, 
            ), 

            const SizedBox(height: 6), 

            Text(
              value, 
              style: Theme.of(context)
                .textTheme
                .titleLarge, 
            ), 
          ], 
        ), 
      ),
    ); 
  }
}


class _RangeRow extends StatelessWidget {

  const _RangeRow({
    required this.label,
    required this.min,
    required this.max,
    required this.unit,
  });


  final String label;
  final int min;
  final int max;
  final String unit;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: Text(label),
        ),

        const SizedBox(width: 8),

        Flexible(
          child: Text(
            '$min - $max $unit',
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ); 
  }

}  

class _BloodPressureChart extends StatelessWidget {

  const _BloodPressureChart({
    required this.measurements,
  });

  final List<BloodPressureMeasurement> measurements;

  @override
  Widget build(BuildContext context) {

    if (measurements.length < 2) {
      return const Center(
        child: Text(
          'Servono almeno due misurazioni per visualizzare l\'andamento.',
          textAlign: TextAlign.center,
        ),
      );
    }

    final colors = Theme.of(context).colorScheme; 

    final chartMeasurements = [...measurements]
      ..sort(
        (a, b) => a.measurementDateTime.compareTo(
          b.measurementDateTime,
        ),
      );

    final spotsSystolic = chartMeasurements
        .asMap()
        .entries
        .map(
          (entry) => FlSpot(
            entry.key.toDouble(),
            entry.value.systolicPressure.toDouble(),
          ),
        )
        .toList();

    final spotsDiastolic = chartMeasurements
        .asMap()
        .entries
        .map(
          (entry) => FlSpot(
            entry.key.toDouble(),
            entry.value.diastolicPressure.toDouble(),
          ),
        )
        .toList();

    final minPressure = chartMeasurements
        .expand(
          (measurement) => [
            measurement.systolicPressure,
            measurement.diastolicPressure,
          ],
        )
        .reduce(
          (a, b) => a < b ? a : b,
        );

    final minY = ((minPressure - 5) / 5).floor() * 5;

    final maxPressure = chartMeasurements
        .expand(
          (measurement) => [
            measurement.systolicPressure,
            measurement.diastolicPressure,
          ],
        )
        .reduce(
          (a, b) => a > b ? a : b,
        );

    final maxY = ((maxPressure + 5) / 5).ceil() * 5;
    
    return Column(
      children: [

        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            _ChartLegendItem(
              color: colors.primary,
              label: 'Sistolica',
            ),

            const SizedBox(width: 24),

            _ChartLegendItem(
              color: colors.secondary,
              label: 'Diastolica',
            ),
          ],
        ),
        const SizedBox(height: 12),

        AspectRatio(
          aspectRatio: MediaQuery.sizeOf(context).width < 600
                ? 1.5
                : 2.2,

          child: LayoutBuilder(
            builder: (context, constraints) {
              final minimumWidth = constraints.maxWidth;

              final requiredWidth =
                  chartMeasurements.length * 80.0;

              final chartWidth = requiredWidth > minimumWidth
                  ? requiredWidth
                  : minimumWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: SizedBox(
                  width: chartWidth,              

                  child: LineChart(

                    LineChartData(
                      lineTouchData: const LineTouchData(enabled: false),
                      minY: minY.toDouble(),
                      maxY: maxY.toDouble(),

                      gridData: const FlGridData(
                        show: true,
                      ),

                      borderData: FlBorderData(
                        show: false,
                      ),

                      titlesData: FlTitlesData(

                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),

                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 45,
                          ),
                        ),

                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(

                            showTitles: true,
                            reservedSize: 48,
                            interval: 1,

                            getTitlesWidget: (value, meta) {

                              final index = value.toInt();

                              if (index < 0 ||
                                  index >= chartMeasurements.length) {
                                return const SizedBox.shrink();
                              }

                              final date =
                                  chartMeasurements[index]
                                      .measurementDateTime;

                              return SideTitleWidget(
                                meta: meta,

                                child: Text(
                                  DateFormat(
                                    'dd/MM\nHH:mm',
                                  ).format(date),

                                  textAlign: TextAlign.center,

                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        // Systolic
                        LineChartBarData(
                          spots: spotsSystolic,

                          isCurved: false,

                          color: colors.primary,

                          barWidth: 3,

                          dotData: const FlDotData(
                            show: true,
                          ),
                        ),

                        // Diastolic
                        LineChartBarData(
                          spots: spotsDiastolic,

                          isCurved: false,

                          color: colors.secondary,

                          barWidth: 3,

                          dotData: const FlDotData(
                            show: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ), 
              ); 
            },
          ),  
        ),

      ],
    );
  }
}

class _ChartLegendItem extends StatelessWidget {

  const _ChartLegendItem({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 6),

        Text(label),
      ],
    );
  }
}