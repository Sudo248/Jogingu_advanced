// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RunModelAdapter extends TypeAdapter<RunModel> {
  @override
  final int typeId = 0;

  @override
  RunModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RunModel(
      name: fields[0] as String,
      distance: fields[1] as double,
      avgSpeed: fields[2] as double,
      timeRunning: fields[3] as int,
      caloBunred: fields[5] as int,
      timeStartInMiliseconds: fields[6] as int,
      stepCount: fields[7] as int,
      location: fields[8] as String,
      imageUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RunModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.distance)
      ..writeByte(2)
      ..write(obj.avgSpeed)
      ..writeByte(3)
      ..write(obj.timeRunning)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.caloBunred)
      ..writeByte(6)
      ..write(obj.timeStartInMiliseconds)
      ..writeByte(7)
      ..write(obj.stepCount)
      ..writeByte(8)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RunModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
