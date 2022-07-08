import 'package:hive/hive.dart';
import 'package:javacode/Modules/Models/Hive/topping_hive_model.dart';

part 'menu_hive_model.g.dart';

@HiveType(typeId: 4)
class MenuHive extends HiveObject {
  @HiveField(0)
  int? id_menu;
  @HiveField(1)
  int? harga;
  @HiveField(2)
  int? level;
  @HiveField(3)
  String keteranganLevel = "0";
  @HiveField(4)
  List<int>? topping = [];
  @HiveField(5)
  List<Topping>? toppingDetail = [];
  @HiveField(6)
  int? jumlah;
  @HiveField(7)
  String nama = "";
  @HiveField(8)
  String gambar = "";
  @HiveField(9)
  String catatan = "";
  @HiveField(10)
  String kategori = "";
}
