// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicalHistoryAdapter extends TypeAdapter<MedicalHistory> {
  @override
  final typeId = 2;

  @override
  MedicalHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicalHistory(
      id: fields[0] as String?,
      patientId: fields[1] as String,
      familyHistoryHypertension: fields[2] == null ? false : fields[2] as bool,
      diabetes: fields[3] == null ? false : fields[3] as bool,
      cardiovascularDisease: fields[4] == null ? false : fields[4] as bool,
      kidneyDisease: fields[5] == null ? false : fields[5] as bool,
      antihypertensiveTherapy: fields[6] == null ? false : fields[6] as bool,
      allergies: fields[7] == null ? '' : fields[7] as String,
      notes: fields[8] == null ? '' : fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MedicalHistory obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.patientId)
      ..writeByte(2)
      ..write(obj.familyHistoryHypertension)
      ..writeByte(3)
      ..write(obj.diabetes)
      ..writeByte(4)
      ..write(obj.cardiovascularDisease)
      ..writeByte(5)
      ..write(obj.kidneyDisease)
      ..writeByte(6)
      ..write(obj.antihypertensiveTherapy)
      ..writeByte(7)
      ..write(obj.allergies)
      ..writeByte(8)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicalHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
