import 'package:hive_flutter/hive_flutter.dart';
import 'package:javacode/Modules/Models/Hive/menu_hive_model.dart';

part 'order_hive_model.g.dart';

@HiveType(typeId: 3)
class OrderHive extends HiveObject{
  
  @HiveField(0)
  int? idUser;
  @HiveField(1)
  int? idVoucher;
  @HiveField(2)
  double? potongan = 0;
  @HiveField(3)
  double? totalBayar = 0;
  
  @HiveField(4)
  List<MenuHive>? menu = [];
}