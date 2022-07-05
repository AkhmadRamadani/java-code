import 'package:hive/hive.dart';

part 'akses_hive_model.g.dart';

@HiveType(typeId: 2)
class Akses extends HiveObject{
    Akses({
        this.authUser,
        this.authAkses,
        this.settingMenu,
        this.settingCustomer,
        this.settingPromo,
        this.settingDiskon,
        this.settingVoucher,
        this.laporanMenu,
        this.laporanCustomer,
    });

    @HiveField(0)
    bool? authUser;
    
    @HiveField(1)
    bool? authAkses;
    
    @HiveField(2)
    bool? settingMenu;
    
    @HiveField(3)
    bool? settingCustomer;
    
    @HiveField(4)
    bool? settingPromo;
    
    @HiveField(5)
    bool? settingDiskon;
    
    @HiveField(6)
    bool? settingVoucher;
    
    @HiveField(7)
    bool? laporanMenu;
    
    @HiveField(8)
    bool? laporanCustomer;

    factory Akses.fromJson(Map<String, dynamic> json) => Akses(
        authUser: json["auth_user"],
        authAkses: json["auth_akses"],
        settingMenu: json["setting_menu"],
        settingCustomer: json["setting_customer"],
        settingPromo: json["setting_promo"],
        settingDiskon: json["setting_diskon"],
        settingVoucher: json["setting_voucher"],
        laporanMenu: json["laporan_menu"],
        laporanCustomer: json["laporan_customer"],
    );

    Map<String, dynamic> toJson() => {
        "auth_user": authUser,
        "auth_akses": authAkses,
        "setting_menu": settingMenu,
        "setting_customer": settingCustomer,
        "setting_promo": settingPromo,
        "setting_diskon": settingDiskon,
        "setting_voucher": settingVoucher,
        "laporan_menu": laporanMenu,
        "laporan_customer": laporanCustomer,
    };
}
