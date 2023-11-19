import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ConstantClassUtil extends GetxController
{
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm aaa');
  var formatted = (formatter.format(now)).obs;
  //static final urlLink="http://10.0.2.2:8000/api";//Testing Link
  static final urlLink="https://card.appdev.live/api"; //production Link


  //static final StockLink="http://10.0.2.2:8050/api";//Testing Link
  static final StockLink="https://stock.appdev.live/api";//production Link


  updateDate() async{
   final DateTime now = DateTime.now();
   final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    formatted.value=formatter.format(now);
    return formatted;
    //update();
  }
}