import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ConstantClassUtil extends GetxController
{
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm aaa');
  var formatted = (formatter.format(now)).obs;
  //static final urlLink="http://10.0.2.2:8000/api";//Testing Link
 // npm install -g localtunnel  lt --port 8000   test Link
  static final urlLink="https://0529-105-178-104-163.ngrok-free.app/api";//
  //static final urlLink="https://card.appdev.live/api"; //production Link


  //static final StockLink="http://10.0.2.2:8050/api";//Testing Link
  static final StockLink="https://stock.appdev.live/api";//production Link


  updateDate() async{
   final DateTime now = DateTime.now();
   final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    formatted.value=formatter.format(now);
    return formatted;
    //update();
  }
  String formatMinutes(int totalMinutes) {
    if (totalMinutes < 60) {
      return '$totalMinutes minute${totalMinutes == 1 ? '' : 's'}';
    } else {
      final hours = totalMinutes ~/ 60;       // integer division
      final minutes = totalMinutes % 60;
      if (minutes == 0) {
        return '$hours hour${hours == 1 ? '' : 's'}';
      } else {
        return '$hours hour${hours == 1 ? '' : 's'} $minutes min${minutes == 1 ? '' : 's'}';
      }
    }
  }
  truncateWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...'; // Adding ellipsis
    }
  }
}