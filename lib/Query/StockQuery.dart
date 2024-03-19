import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../Query/AdminQuery.dart';
import '../../../models/Participated.dart';
import '../../../models/Promotions.dart';
import '../../../models/User.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../Utilconfig/ConstantClassUtil.dart';

import '../models/Topups.dart';
import '../models/QuickBonus.dart';



class StockQuery extends GetxController{

  String selectedOption = 'Code';
  updateSelected(valData){
    selectedOption=valData!;
    update();
  }
  bool resizable=true;
  updateResizable(valData)
  {
    resizable=false;
    update();
  }

  List<dynamic> dispatchOrder = [];
  updateDispatchOrder(valData){
    dispatchOrder.clear();

    if (valData != null) {
      dispatchOrder.addAll(valData);
    }

    update();

  }
  List<dynamic> dispatchOrder2= [];
  updateDispatchOrder2(valData){
    dispatchOrder2.clear();

    if (valData != null) {
      dispatchOrder2.addAll(valData);
    }

    //update();

  }
  bool paidDeptScanHide=true;
  updatePaidDeptScanHide(valdata)
  {
    paidDeptScanHide=valdata;
    update();
  }
  bool hideComp=true;
  updatehideComp(valdata)
  {
    hideComp=valdata;
    update();
  }

  bool hideaddCart=false;
  updateHideaddCart(valdata)
  {
    hideaddCart=valdata;
    update();
  }
  bool hidePickClick=true;
  updateHidePickClick(valdata)
  {
    hidePickClick=valdata;
    update();
  }
  Map<String, dynamic> userProfile=
  {
    //"uid": "kebineericMuna_1674160265",
    "uid": "none",
    "name": "unknown",

    "email": "on@gmail.com",
    "phone": "782389359",
    "Ccode": "+250",
    "country": "Rwanda",
    "initCountry": "none",
    "PhoneNumber": "+250782389359",
    "carduid": "TEALTD_7hEnj_1672352175"
  }
  ;
  updateUserProfile(valData)
  {
    //userProfile.clear();
    userProfile=valData;
    update();
  }
  var dataSearch = [];
  updatedataSearch(valdata)
  {
    dataSearch=valdata;
    update();
  }
  Map<String, dynamic> clientDebt=
  {
    "debt":0,
    "uidUser":"none",
    "name":"none"
  };
  updateClientDebt(valData)
  {
    clientDebt=valData;
    update();
  }
  String textMessage="";
  updateTextMessage(valData)
  {
    textMessage=valData;
    update();
  }
  bool hideProductList=false;
  updateHideProductList(valdata)
  {
    hideProductList=valdata;
    update();
  }
  bool hideLoader=true;
  updateHideLoader(valdata)
  {
    hideLoader=valdata;
    update();
  }

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
        "uid":"none"
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
  void updateCartui(dynamicData,cartUid,bolCartUid,bolresultData,counterD) {
    counterCart=counterCart + counterD;

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


  spendingOrder(Topups topupData) async{

    try {

      var params =  {
        "uid":topupData.uid,//just to avoid error nothing else
        "uidUser":topupData.uidCreator,//uidUser
        "balance":topupData.amount,
        "description":topupData.desc

        //"options": [1,2,3],
      };
      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/placeOrder";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
    }

  }//not done Spending as depense
  searchUser(User user,Topups topData) async{
    try {

      var params =  {

        "name":user.name,
        "phoneNumber":user.phone,
        "platform":user.platform,
        "isStatus":user.status,//offNotPick means gonna pick any
        "isAdmin":topData.optionCase,
        "limitData":topData.startlimit,
        "searchOption":topData.searchOption,
        "sortOrder":topData.sortOrder??'ASC'


      };
      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/SearchUser";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
  product(QuickBonus product,Topups topupData) async{//this is all about Products
    try {

      var params =  {

        "productCode":product.uid,
        "productName":product.productName,
        "productQr":product.status,
        "isProductAction":topupData.optionCase,//product get Action(search,edit,view)
        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,
        "withTotal":topupData.purpose??false,


      };
      //print(params);

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/Products";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
  updateProducts(QuickBonus product) async{//this is all about Products
    try {

      var params =  {

        "productCode":product.uid,
        "productName":product.productName,
        "price":product.price,
        "pcs":product.giftPcs,
        "actionStatus":product.status



      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/updateProducts";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
  } //Search all prod
  searchProductQr(Topups topupData) async{
    try {

      var params =  {

        "productCode":topupData.uid,

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/searchProductQr";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
    }
  } //Search all product based on Qr Code not done
  updateInOrder(QuickBonus quickData,Participated user) async{//balance and Bonus Widthdraw History
    try {

      var params =  {


        "uid":"${quickData.uid}",
        "productCode":"${quickData.productName}",
        "commentData":"${quickData.description}",
        "isCommentData":"${quickData.status}",
        'newUidUser':"${user.uidUser}",
        'isStatus':"${user.status}"


      };
      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/updateDataOrder";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }
  }//calculate safari Interet

  placeOrder(QuickBonus product,User user) async{

    try {

      var params =  {
        "uidClient":user.uid,
        "productCode":product.uid,
        "req_qty":product.reqQty,

        "ref":"test",
        "comment":"ok",
        "statusForm":"none",
        "orderIdFromEdit":product.subscriber //this is orderId


        //"options": [1,2,3],
      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/placeOrder";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
      //return false;
      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/SubmitOrder";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
    }

  }
  editOrder(Topups topData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {
//optionCase

        "uid":topData.uid,
        "orderAction":"EditOrder"


      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/EditOrder";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
  viewSales(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":topupData.name,
        "searchOption":topupData.optionCase,
        "advancedSearch":topupData.advancedSearch,
        "thisDate":topupData.created_at,
        "toDate":topupData.updated_at??'none'

      };
      //print(params);
      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/viewSales";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
  }//calculate safari Interet
  viewSalesByUid(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {
        "orderId":topupData.uid,
        "LimitEnd":topupData.startlimit,
        "LimitStart":topupData.endlimit,  //page
      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/viewSalesByUid";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
    }
  }

  editTOrder(QuickBonus product,User userData) async{//balance and Bonus Widthdraw History
    String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];


    var headers = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer $authToken'
    };


    var request = http.Request('GET', Uri.parse('${ConstantClassUtil.urlLink}/EditTOrder'));
    request.body = '''
{
  "productCode":"${product.productName}",
  "req_qty":${product.reqQty},
  "currentQtyEdit":${product.reqQty},
  "uid": "${product.uid}",
  "uidClient": "${userData.uid}",
  "statusForm": "editOrder"
}
''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      dynamic jsonResponse = jsonDecode(responseBody); // Parse JSON response
      return jsonResponse;
      // Return the response body as a string
    } else {
      // Handle non-200 status codes appropriately, potentially throwing an error
      throw Exception('HTTP request failed with status code ${response.statusCode}');
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
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
  deleteTOrder(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {


        "uid":topupData.uid,//userid



      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/deleteTOrder";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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


      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/EditOGOrder";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
  getDebt(User userData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {


        "cardUid":userData.carduid//userid


      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetDebt";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
    }
  }
  stockViewDeliver(Topups topupData,QuickBonus product) async{//balance and Bonus Widthdraw History
    try {

      var params =  {


        "uid":topupData.uid,
        "productCode":product.uid,
        "productExist":topupData.optionCase



      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/StockViewDeliver";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
  stockCount(Topups topupData,QuickBonus product,User user) async{

    try {

      var params =  {
        //just to avoid error nothing else
        //"uidUser":TopupData.uidCreator,//uidUser
        "uid":topupData.uid,
        "productCode":product.uid,
        "qty_Transport":product.qty,
        "stockName":product.subscriber,
        "uidTransport":user.uid,
        "ref":user.name,
        "status":product.status,
        "comment":product.description






        //"options": [1,2,3],
      };
      print(params);

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/StockCount";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }

  }

  addSpending(Topups topupData) async{

    try {

      var params =  {
        //just to avoid error nothing else
        //"uidUser":TopupData.uidCreator,//uidUser
        "safariId":topupData.uid,
        "safariName":topupData.name,
        "balance":topupData.amount,
        "purpose":topupData.purpose,
        "status":"GeneralSpend",
        "commentData":topupData.desc,
        "systemUid":"PointSales1",
        "options":topupData.optionCase






        //"options": [1,2,3],
      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/addSpending";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }

  }
  updateSpending(Topups topupData) async{

    try {

      var params =  {
        "safariId":topupData.safariId,
        "uid":topupData.uid,
        "amount":"${topupData.amount}",
        "purpose":topupData.purpose,
        "actionStatus":topupData.optionCase,//action delete,edit both safari and others
        "status":"GeneralSpend",
        "commentData":topupData.desc,
        "systemUid":"PointSales1"

        //"options": [1,2,3],
      };
      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/updateSpending";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
    }

  }

  viewSpending(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {


        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":topupData.name,
        "options":topupData.optionCase,
        "safariId":topupData.uid,
        "searchOption":topupData.searchOption



      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/viewSpending";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }
  }
  paidDept(User userData) async{

    try {

      var params =  {


        "uidUser":userData.uid,

        "inputData":userData.inputData,
        "all_total":"2000",
        "ref":"none",
        "reach":"1200",
        "gain":"350",
        "systemUid":"PointSales1",
        "commentData":"karera"

        //"options": [1,2,3],
      };
      String authtoken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/PaidDept";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authtoken"
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

    }

  }
  editPaidDept(Topups topupData) async{

    try {

      var params =  {
        "uid":topupData.uid,//just to avoid error nothing else
        "uidUser":topupData.uidCreator,//uidUser
        "balance":topupData.amount,
        "description":topupData.desc,


        "inputData":"600",
        "all_total":"2000",
        "ref":"Eric",
        "reach":"1200",
        "gain":"350",
        "systemUid":"PointSales1",
        "commentData":"karera"

        //"options": [1,2,3],
      };
      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/EditPaidDept";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }

  }

  viewDept(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":topupData.name,
        'viewAll':topupData.optionCase??'false',
        "searchOption":topupData.searchOption


      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/viewDept";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }
  }//calculate safari Interet

  viewPaidDept(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":topupData.name,
        "searchOption":topupData.searchOption


      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/viewPaidDept";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }
  }//
  viewSafeBalance(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":topupData.name,
        "searchOption":topupData.searchOption

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/viewSafeBalance";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }
  }//
  viewBorrowBalance(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":topupData.name,
        "searchOption":topupData.searchOption

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/viewBorrowBalance";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }
  }
  viewSafeBorrow(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":topupData.uid,
        "isSafe":topupData.optionCase,
        "searchOption":topupData.searchOption,
        "name":topupData.name

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/viewSafeBorrow";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }
  }
  repaidBack(Topups topupData) async{

    try {

      var params =  {


        "uidReceiver":topupData.uid,

        "amount":topupData.amountBalance,
        //"amount":5,
        "commentData":topupData.desc,
        "systemUid":"PointSales1"

        //"options": [1,2,3],
      };
      // print(params);
      String authtoken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/repaidBack";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authtoken"
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

    }

  }
  confirmRepaidBack(User userData) async{

    try {

      var params =  {


        "uid":userData.uid //uid of paidDette

        //"options": [1,2,3],
      };
      String authtoken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/confirmRepaidBack";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authtoken"
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

    }

  }
  viewRepay(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":topupData.uid,
        "IsReceiver":topupData.optionCase,//true for safe false for borrower
        "searchOption":topupData.searchOption,
        "name":topupData.name

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/viewRepay";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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

    }
  }
  //
  getSafaris(Topups topupData) async{//balance and Bonus Widthdraw History
    try {

      var params =  {

        /* "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "uid":userData.uid,//userid
        "optionCase":topupData.optionCase//optionCase
*/
        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":topupData.name,
        "searchOption":topupData.searchOption

      };

      String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetSafaris";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
          HttpHeaders.authorizationHeader:"Bearer $authToken"
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
    }
  }//calculate safari Interet  //this maybe in Dashboard







}