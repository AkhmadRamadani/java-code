// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuHiveAdapter extends TypeAdapter<MenuHive> {
  @override
  final int typeId = 4;

  @override
  MenuHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuHive()
      ..id_menu = fields[0] as int?
      ..harga = fields[1] as int?
      ..level = fields[2] as int?
      ..keteranganLevel = fields[3] as String
      ..topping = (fields[4] as List?)?.cast<int>()
      ..toppingDetail = (fields[5] as List?)?.cast<Topping>()
      ..jumlah = fields[6] as int?
      ..nama = fields[7] as String
      ..gambar = fields[8] as String
      ..catatan = fields[9] as String
      ..kategori = fields[10] as String;
  }

  @override
  void write(BinaryWriter writer, MenuHive obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id_menu)
      ..writeByte(1)
      ..write(obj.harga)
      ..writeByte(2)
      ..write(obj.level)
      ..writeByte(3)
      ..write(obj.keteranganLevel)
      ..writeByte(4)
      ..write(obj.topping)
      ..writeByte(5)
      ..write(obj.toppingDetail)
      ..writeByte(6)
      ..write(obj.jumlah)
      ..writeByte(7)
      ..write(obj.nama)
      ..writeByte(8)
      ..write(obj.gambar)
      ..writeByte(9)
      ..write(obj.catatan)
      ..writeByte(10)
      ..write(obj.kategori);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
