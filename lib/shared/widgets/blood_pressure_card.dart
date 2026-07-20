import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/shared/widgets/pressure_status_chip.dart';

class BloodPressureCard extends StatelessWidget {

    const BloodPressureCard({

        super.key, 
        required this.measurement, 
        this.patientName, 
        this.showPatientName = false, 
        this.embedded = false, 
        this.compact = false, 
        this.onTap, 

    }); 

    final BloodPressureMeasurement measurement; 

    final String? patientName; 

    final bool showPatientName; 
    
    // if the card is inside another card, it is possible to not use another
    final bool embedded; 

    // compact version 
    final bool compact; 

    final VoidCallback? onTap; 

    @override 
    Widget build(BuildContext context) {

        final content = InkWell(

            borderRadius: BorderRadius.circular(16), 

            onTap: onTap, 

            child: Padding(

                padding: EdgeInsets.all(
                    compact ? 12 : 20,
                ),

                child: _buildContent(context), 
                
            ),
        ); 

        if (embedded) {
            return content; 
        }

        return Card(
            child:content, 
        ); 
        
    }


    Widget _buildContent(BuildContext context) {

        return Column(

            crossAxisAlignment: CrossAxisAlignment.start, 

            children: [

                // pression 

                Row(

                    children: [

                        Icon(
                            Icons.favorite, 

                            size: compact ? 18: 24, 
                        ), 

                        const SizedBox(width: 12), 

                        Expanded(
                            
                            child: Text(

                                '${measurement.systolicPressure}/${measurement.diastolicPressure} mmHg', 
                                
                                style: compact
                                    ? Theme.of(context).textTheme.titleLarge
                                    : Theme.of(context).textTheme.headlineMedium,  
                            ), 
                        ), 

                        PressureStatusChip(
                            measurement: measurement, 
                        ), 
                    ], 
                ), 

                const SizedBox(height: 12), 

                // heart rate 

                Row(

                    children: [

                        const Icon(
                            Icons.monitor_heart_outlined, 
                            size: 18, 
                        ), 

                        const SizedBox(width: 8), 

                        Text(
                            '${measurement.heartRate} bpm', 
                        ), 
                    ], 
                ), 

                const SizedBox(height: 8), 

                // date 

                Row(

                    children: [

                        const Icon(
                            Icons.calendar_today_outlined, 
                            size: 18, 
                        ), 

                        const SizedBox(width: 8), 

                        Text(
                            DateFormat(
                                'dd/MM/yyyy HH:mm', 
                            ).format(
                                measurement.measurementDateTime, 
                            ),
                        ), 
                    ],
                ), 

                // patient name (User only case)

                if (showPatientName && patientName != null) ...[

                    const SizedBox(height: 8), 

                    Row(

                        children: [

                            const Icon(
                                Icons.person_outline, 
                                size: 18, 
                            ), 

                            const SizedBox(width: 8),

                            Expanded(
                                child: Text(
                                    patientName!, 
                                ), 
                            ), 
                        ], 
                    ), 
                ], 

                // notes 
                
                if (measurement.notes.isNotEmpty) ...[

                    const SizedBox(height: 12), 

                    const Divider(), 

                    const SizedBox(height: 8), 

                    Text(
                        
                        measurement.notes, 

                        style: Theme.of(context)
                            .textTheme
                            .bodySmall, 
                    ), 
                ], 
            ], 
        ); 

    }


}


