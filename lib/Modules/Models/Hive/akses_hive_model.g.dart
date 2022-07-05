// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'akses_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AksesAdapter extends TypeAdapter<Akses> {
  @override
  final int typeId = 2;

  @override
  Akses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Akses(
      authUser: fields[0] as bool?,
      authAkses: fields[1] as bool?,
      settingMenu: fields[2] as bool?,
      settingCustomer: fields[3] as bool?,
      settingPromo: fields[4] as bool?,
      settingDiskon: fields[5] as bool?,
      settingVoucher: fields[6] as bool?,
      laporanMenu: fields[7] as bool?,
      laporanCustomer: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Akses obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.authUser)
      ..writeByte(1)
      ..write(obj.authAkses)
      ..writeByte(2)
      ..write(obj.settingMenu)
      ..writeByte(3)
      ..write(obj.settingCustomer)
      ..writeByte(4)
      ..write(obj.settingPromo)
      ..writeByte(5)
      ..write(obj.settingDiskon)
      ..writeByte(6)
      ..write(obj.settingVoucher)
      ..writeByte(7)
      ..write(obj.laporanMenu)
      ..writeByte(8)
      ..write(obj.laporanCustomer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AksesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
