import 'dart:convert';
import 'dart:io';

import 'package:dcard/Query/AdminQuery.dart';
import 'package:dcard/models/Participated.dart';
import 'package:dcard/models/Promotions.dart';
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
        "name":"Unknown",
        "uid":""
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
  dynamic orderCount = {
    "status":false,
    "resultData":[
      {
        "name":"none",
        "uid":"0s"
      }
    ],
  };
  updateOrderCount(orderVal){
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
        "uidclient":user.uid,
        "productCode":product.uid,
        "req_qty":product.qty,
        "ref":"test",
        "comment":"ok",
        "statusForm":"none",
        "orderIdFromEdit":product.subscriber //this is orderId

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
  submitOrder(Participated participatedData,Promotions promotionData) async{

    try {

      var params =  {
        "uid":participatedData.uid,
        "uidUser":participatedData.uidUser,
        "OrderId":participatedData.subscriber,
        "inputData":participatedData.inputData,
        "all_total":promotionData.token,
        "reach":promotionData.reach,
        "gain":promotionData.gain,
        "systemUid":promotionData.uid

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
  editTOrder(QuickBonus product,User userData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {
//optionCase

        "productCode":product.productName,
        "req_qty":product.qty,
        "uid":product.uid,
        "uidclient":userData.uid,
        "statusForm":"editOrder"

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
  deleteTSingleOrder(QuickBonus product) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "productCode":product.productName,
        "uid":product.uid

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
  orderViewCount(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {
        "LimitEnd":topupData.startlimit,
        "LimitStart":topupData.endlimit,  //page
      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/OrderViewCount";
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
  orderViewByUid(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {
        "orderId":topupData.uid,
        "LimitEnd":topupData.startlimit,
        "LimitStart":topupData.endlimit,  //page
      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/OrderViewByUid";
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
  stockCount(Topups topupData,QuickBonus product,User user) async{//balance and Bonus Widthdraw History
    try {

      var params =  {


        "uid":topupData.uid,
        "productCode":product.uid,
        "qty_Transport":product.qty,
        "stockName":product.subscriber,
        "uidTransport":user.uid,
        "ref":user.name,
        "status":product.status,
        "comment":product.description


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
        "systemUid":"PointSales1",
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