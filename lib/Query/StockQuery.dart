import 'dart:convert';
import 'dart:io';

import 'package:dcard/Query/AdminQuery.dart';
import 'package:dcard/models/User.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../Utilconfig/ConstantClassUtil.dart';

import '../models/Topups.dart';
import '../models/QuickBonus.dart';



class StockQuery extends GetxController{

  dynamic dataCartui = {
    "id":1,
    "cartshow":false,
    "resultData":[
      {
        "id":10
      }
    ],
  };
  dynamic order = {
    "status":false,
    "resultData":[
      {
        "name":"none",
        "uid":"0s"
      }
    ],
  };
  updateOrder(orderVal){
    order = {
      "status":false,
      "resultData":orderVal,
    };
    update();
  }

  num orderSum=0;
  updateSumOrder(totalVal){
    orderSum=totalVal;
    update();
  }
  num dept=0;
  updateDeptOrder(deptVal){
    dept=deptVal;
    update();
  }
num counterCart=0;
dynamic dataTest=[];
  void updateCartui(dynamicData,cartUid,bolCartUid,bolresultData,Counter) {
    counterCart=counterCart + Counter;

    if(dataTest.length>0)
      {
        dataTest["resultData"]=dynamicData;
        dataCartui={
          "datalenght":dataTest.length,
          "countData":counterCart,
          "products":{},

          "cartUid":(bolCartUid==true)?cartUid:(Get.put(StockQuery()).dataCartui)["cartUid"],
          "resultData":dataTest["resultData"],
          "cartshow":false,
          //"resultData":(bolresultData==true)?dynamicData:(Get.put(StockQuery()).dataCartui)["resultData"],

        };
      }
      else{
      dataTest=dynamicData;
      dataCartui={
        "datalenght":dataTest.length,
        "countData":counterCart,
        "products":{},

        "cartUid":(bolCartUid==true)?cartUid:(Get.put(StockQuery()).dataCartui)["cartUid"],
        "resultData":dataTest,
        "cartshow":false,
        //"resultData":(bolresultData==true)?dynamicData:(Get.put(StockQuery()).dataCartui)["resultData"],

      };
    }
    //



   // dataCartui["resultData"]=(Get.put(StockQuery().dataCartui["id"]==1));

        update();
  }


  spendingOrder(Topups TopupData) async{

    try {

      var params =  {
        "uid":TopupData.uid,//just to avoid error nothing else
        "uidUser":TopupData.uidCreator,//uidUser
        "balance":TopupData.amount,
        "description":TopupData.desc

        //"options": [1,2,3],
      };
      String Authtoken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/placeOrder";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${Authtoken}"
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {

        //updateParticipateState(response.data);
        return response;



      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }

  }//not done Spending as depense

  searchProduct(QuickBonus product,) async{
    try {

      var params =  {

        "productCode":product.uid,
        "productName":product.productName,


      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="http://10.0.2.2:8000/api/SearchProduct";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {




       return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;

    }
  } //Search all product based on name or ProductCode
  searchProductQr(Topups TopupData) async{
    try {

      var params =  {

        "productCode":TopupData.uid,

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/searchProductQr";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {


        // return (response.data).length;
        //updateEventState(response.data);
        //return "hello";

        //updateBalanceHistState(response.data);
        //return response.data;

        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  } //Search all product based on Qr Code not done
  placeOrder(QuickBonus product,User user) async{

    try {

      var params =  {
        /*"uid":TopupData.uid,//just to avoid error nothing else
        "uidUser":TopupData.uidCreator,//uidUser
        "balance":TopupData.amount,
        "description":TopupData.desc,*/
        "uidclient":user.uid,
        "productCode":product.uid,
        "req_qty":product.qty,
        "ref":"test",
        "comment":"ok",
        "statusForm":"none",
        "orderIdFromEdit":product.productName //this is orderId

        //"options": [1,2,3],
      };
      String Authtoken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/placeOrder";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${Authtoken}"
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {

        //updateParticipateState(response.data);
        return response;



      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }

  }
  submitOrder(Topups TopupData) async{

    try {

      var params =  {

        "balance":TopupData.amount,
        "description":TopupData.desc,

        "uid":"Nyota_1672353378",
        "uidUser":"kebineericMuna_1674160265",
        "OrderId":"aKCrj",
        "inputData":"50",
        "all_total":"500",
        "reach":"1200",
        "gain":"350",
        "systemUid":"PointSales_1"

        //"options": [1,2,3],
      };
      String Authtoken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/SubmitOrder";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${Authtoken}"
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {

        //updateParticipateState(response.data);
        return response;



      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }

  }
  editTOrder(Topups topupData,User userData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":userData.uid,//userid
        "optionCase":topupData.optionCase,//optionCase

        "productCode":"bido_1698592481",
        "req_qty":2,
        "current_qty":10,
        "uid":"KoBZ8"

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/EditTOrder";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {




        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }
  deleteTSingleOrder(Topups topupData,User userData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":userData.uid,//userid
        "optionCase":topupData.optionCase,//optionCase

        "productCode":"bido_1698592481",
        "req_qty":2,
        "current_qty":10,
        "uid":"KoBZ8"

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/deleteTSingleOrder";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {




        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }
  deleteTOrder(Topups topupData,User userData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":userData.uid,//userid
        "optionCase":topupData.optionCase,//optionCase

        "productCode":"bido_1698592481",
        "req_qty":2,
        "current_qty":10,
        "uid":"KoBZ8"

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/deleteTOrder";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {




        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }
  editOGOrder(Topups topupData,User userData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":userData.uid,//userid
        "optionCase":topupData.optionCase,//optionCase

        "productCode":"bido_1698592481",
        "req_qty":2,
        "current_qty":10,
        "uid":"KoBZ8"

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/EditOGOrder";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {


        // return (response.data).length;
        //updateEventState(response.data);
        //return "hello";

        //updateBalanceHistState(response.data);
        //return response.data;

        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }
  viewTempOrder(QuickBonus product,) async{
    try {

      var params =  {

        "uid":product.uid



      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/ViewTempOrder";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {




        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;

    }
  }
  viewUserTempOrder(QuickBonus product) async{
    try {

      var params =  {

        "uid":product.uid,



      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/ViewUserTempOrder";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {




        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;

    }
  }
  getDebt(Topups topupData,User userData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":userData.uid,//userid
        "optionCase":topupData.optionCase,//optionCase

        "cardUid":"TEALTD_7hEnj_1672352175"

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetDebt";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {


        // return (response.data).length;
        //updateEventState(response.data);
        //return "hello";

        //updateBalanceHistState(response.data);
        //return response.data;

        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }
  stockCount(Topups topupData,User userData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":userData.uid,//userid
        "optionCase":topupData.optionCase,//optionCase

        "id":1,
        "productCode":"viva_1693508831",
        "uidTransport":"Qito",
        "qty_Transport":6,
        "stockName":"M crispin",
        "safariId":"test",
        "ref":"NeeMaUid",
        "status":"delivered",
        "comment":"comment Test"


      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/StockCount";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {


        // return (response.data).length;
        //updateEventState(response.data);
        //return "hello";

        //updateBalanceHistState(response.data);
        //return response.data;

        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }
  paidDette(Topups TopupData) async{

    try {

      var params =  {
        "uid":TopupData.uid,//just to avoid error nothing else
        "uidUser":TopupData.uidCreator,//uidUser
        "balance":TopupData.amount,
        "description":TopupData.desc,

        "uidUser":"kebineericMuna_1674160265",

        "inputData":"600",
        "all_total":"2000",
        "ref":"Eric",
        "reach":"1200",
        "gain":"350",
        "systemUid":"PointSales_1",
        "commentData":"karera"

        //"options": [1,2,3],
      };
      String Authtoken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/PaidDette";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${Authtoken}"
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {

        //updateParticipateState(response.data);
        return response;



      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }

  }
  getSafaris(Topups topupData,User userData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":userData.uid,//userid
        "optionCase":topupData.optionCase//optionCase

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetSafaris";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {


        // return (response.data).length;
        //updateEventState(response.data);
        //return "hello";

        //updateBalanceHistState(response.data);
        //return response.data;

        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }//calculate safari Interet
  displayCalculate(Topups topupData,User userData) async{//display Interest
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":userData.uid,//userid
        "optionCase":topupData.optionCase,//optionCase

        "safariId":"Mbona_tbSwL_1697829219",
        "name":"Mbona"

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/displayCalculate";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${authToken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {


        // return (response.data).length;
        //updateEventState(response.data);
        //return "hello";

        //updateBalanceHistState(response.data);
        //return response.data;

        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }//calculate safari Interet  //this maybe in Dashboard







}