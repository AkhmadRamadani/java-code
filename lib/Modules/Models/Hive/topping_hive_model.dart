import 'package:hive_flutter/hive_flutter.dart';

part 'topping_hive_model.g.dart';

@HiveType(typeId: 5)
class Topping extends HiveObject {
  Topping(
      {this.idDetail,
      this.idMenu,
      this.keterangan,
      this.type,
      this.harga,
      this.isSelected = false});

  @HiveField(0)
  int? idDetail;
  @HiveField(1)
  int? idMenu;
  @HiveField(2)
  String? keterangan;
  @HiveField(3)
  String? type;
  @HiveField(4)
  int? harga;
  @HiveField(5)
  bool? isSelected;

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        idDetail: json["id_detail"],
        idMenu: json["id_menu"],
        keterangan: json["keterangan"],
        type: json["type"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "id_detail": idDetail,
        "id_menu": idMenu,
        "keterangan": keterangan,
        "type": type,
        "harga": harga,
      };
}
