// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_measurement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodPressureMeasurementAdapter
    extends TypeAdapter<BloodPressureMeasurement> {
  @override
  final typeId = 3;

  @override
  BloodPressureMeasurement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodPressureMeasurement(
      id: fields[0] as String?,
      patientId: fields[1] as String,
      systolicPressure: (fields[2] as num).toInt(),
      diastolicPressure: (fields[3] as num).toInt(),
      heartRate: (fields[4] as num).toInt(),
      measurementDateTime: fields[5] as DateTime?,
      notes: fields[6] == null ? '' : fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BloodPressureMeasurement obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.patientId)
      ..writeByte(2)
      ..write(obj.systolicPressure)
      ..writeByte(3)
      ..write(obj.diastolicPressure)
      ..writeByte(4)
      ..write(obj.heartRate)
      ..writeByte(5)
      ..write(obj.measurementDateTime)
      ..writeByte(6)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureMeasurementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
