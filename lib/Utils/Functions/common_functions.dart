import 'package:intl/intl.dart';
import 'package:javacode/Modules/Models/order_response_model.dart';

class CommonFunctions {
  final formatCurrency = NumberFormat.decimalPattern();

  String convertDate(String date, String format) {
    var dateFormat = DateFormat('yyyy-MM-dd');

    var formattedDate = dateFormat.parse(date);

    var outputFormat = DateFormat(format);
    var outputDate = outputFormat.format(formattedDate);

    return outputDate;
  }

  String getListMenuName(List<MenuOrder> data) {
    List<String> result = data.map((MenuOrder e) {
      return e.nama ?? "";
    }).toList();

    return result.join(", ");
  }
}
