// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      idUser: fields[0] as int?,
      email: fields[1] as String?,
      nama: fields[2] as String?,
      pin: fields[3] as String?,
      foto: fields[4] as String?,
      mRolesId: fields[5] as int?,
      isGoogle: fields[6] as int?,
      isCustomer: fields[7] as int?,
      roles: fields[8] as String?,
      akses: fields[9] as Akses?,
      token: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.idUser)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.nama)
      ..writeByte(3)
      ..write(obj.pin)
      ..writeByte(4)
      ..write(obj.foto)
      ..writeByte(5)
      ..write(obj.mRolesId)
      ..writeByte(6)
      ..write(obj.isGoogle)
      ..writeByte(7)
      ..write(obj.isCustomer)
      ..writeByte(8)
      ..write(obj.roles)
      ..writeByte(9)
      ..write(obj.akses)
      ..writeByte(10)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
