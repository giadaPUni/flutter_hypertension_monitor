import 'package:flutter/material.dart';

import 'package:flutter_hypertension_monitor/data/models/blood_pressure_measurement.dart';
import 'package:flutter_hypertension_monitor/core/theme/app_colors.dart';

class PressureStatusChip extends StatelessWidget {

    const PressureStatusChip({
        super.key, 
        required this.measurement, 
    }); 

    final BloodPressureMeasurement measurement; 

    @override
    Widget build(BuildContext context) {

        final status = _status(measurement); 

        return Chip(

            visualDensity: VisualDensity.compact, 

            backgroundColor: status.color.withValues(
                alpha: 0.15,
            ),

            side: BorderSide(
                color: status.color, 
            ), 

            avatar: Icon(
                status.icon, 
                size: 18, 
                color: status.color, 
            ), 

            label: Text(

                status.label, 

                style: TextStyle(
                    color: status.color, 
                    fontWeight: FontWeight.w600, 
                ), 
            ), 
        );
    }

    _PressureStatus _status(
        BloodPressureMeasurement measurement, 
    ) {
        final sys = measurement.systolicPressure; 
        final dia = measurement.diastolicPressure;  

        if (sys < 120 && dia < 80) {
            return _PressureStatus(
                label: 'Normale', 
                color: AppColors.success, 
                icon: Icons.check_circle, 
            ); 
        }

        if (sys < 130 && dia < 80) {
            return _PressureStatus(
                label: 'Normale-Alta',
                color: AppColors.warning,
                icon: Icons.trending_up,
            );
        }

        if (sys < 140 || dia < 90) {
            return _PressureStatus(
                label: 'Alta',
                color: Colors.orange,
                icon: Icons.warning_amber,
            );
        }

        return _PressureStatus(
            label: 'Ipertensione',
            color: AppColors.error,
            icon: Icons.favorite,
        );

    }

}

class _PressureStatus {

    const _PressureStatus({
        required this.label, 
        required this.color, 
        required this.icon, 
    }); 

    final String label; 
    final Color color; 
    final IconData icon;
}