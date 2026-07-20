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
      smoker: fields[7] == null ? false : fields[7] as bool,
      alcoholConsumption: fields[8] == null ? false : fields[8] as bool,
      sedentaryLifestyle: fields[9] == null ? false : fields[9] as bool,
      highSaltDiet: fields[10] == null ? false : fields[10] as bool,
      dyslipidemia: fields[11] == null ? false : fields[11] as bool,
      previousStroke: fields[12] == null ? false : fields[12] as bool,
      sleepApnea: fields[13] == null ? false : fields[13] as bool,
      currentTherapy: fields[14] == null ? '' : fields[14] as String,
      allergies: fields[15] == null ? '' : fields[15] as String,
      notes: fields[16] == null ? '' : fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MedicalHistory obj) {
    writer
      ..writeByte(17)
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
      ..write(obj.smoker)
      ..writeByte(8)
      ..write(obj.alcoholConsumption)
      ..writeByte(9)
      ..write(obj.sedentaryLifestyle)
      ..writeByte(10)
      ..write(obj.highSaltDiet)
      ..writeByte(11)
      ..write(obj.dyslipidemia)
      ..writeByte(12)
      ..write(obj.previousStroke)
      ..writeByte(13)
      ..write(obj.sleepApnea)
      ..writeByte(14)
      ..write(obj.currentTherapy)
      ..writeByte(15)
      ..write(obj.allergies)
      ..writeByte(16)
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
