// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderHiveAdapter extends TypeAdapter<OrderHive> {
  @override
  final int typeId = 3;

  @override
  OrderHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderHive()
      ..idUser = fields[0] as int?
      ..idVoucher = fields[1] as int?
      ..potongan = fields[2] as int?
      ..totalBayar = fields[3] as int?
      ..menu = (fields[4] as List?)?.cast<MenuHive>();
  }

  @override
  void write(BinaryWriter writer, OrderHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.idUser)
      ..writeByte(1)
      ..write(obj.idVoucher)
      ..writeByte(2)
      ..write(obj.potongan)
      ..writeByte(3)
      ..write(obj.totalBayar)
      ..writeByte(4)
      ..write(obj.menu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
