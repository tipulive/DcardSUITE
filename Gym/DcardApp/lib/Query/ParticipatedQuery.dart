import 'package:dcard/models/Promotions.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/BonusModel.dart';

import '../models/Participated.dart';
import 'package:get/get.dart';
import '../models/Topups.dart';
import '../models/User.dart';
import 'PromotionQuery.dart';
import 'UserQuery.dart';
import 'AdminQuery.dart';

import '../DatabaseHelper.dart';
import '../Utilconfig/ConstantClassUtil.dart';

class ParticipatedQuery extends GetxController{
  UserQuery userStatedata=Get.put(UserQuery());
  PromotionQuery promotionStateData=Get.put(PromotionQuery());
  AdminQuery adminStateData=Get.put(AdminQuery());

  var isVisible="none".obs;


  isHidden(valData){
    isVisible.value=valData;
  }

  Map<String,dynamic> obj={
    "name":"name",
    "id":1,
    "result":[
      {
        "id":10
      }
    ],
  }.obs;

  Map<String,dynamic> active={
    "name":"name",
    "id":1,
    "result":[
      {
        "id":10
      }
    ],
  }.obs;
  List<dynamic> package= [];
  updatepackage(valData){
    package.clear();

    if (valData != null) {
      package=valData;
    }

    //update();

  }
  Map<String,dynamic> reached={
    "name":"name",
    "id":1,
    "result":[
      {
        "id":10
      }
    ],
  }.obs;
  Map<String,dynamic> hist={
    "name":"name",
    "id":1,
    "result":[
      {
        "id":10
      }
    ],
  }.obs;
  Map<String,dynamic> countData={
    "name":"name",
    "id":1,
    "result":[
      {
        "id":10
      }
    ],
  }.obs;
  Map<String,dynamic> all={
    "name":"name",
    "id":1,
    "result":[
      {
        "id":10
      }
    ],
  }.obs;

  Map<String,dynamic> dataCartui={
    "id":1,
    "cartshow":false,
    "resultData":[
      {
        "id":10
      }
    ],
  }.obs;

 updateCartUi(cartui,cardStatus,updateCartui) {

    dataCartui={
      "id":2,
      "countData":{},
      "products":{},
      "cartshow":cardStatus,
      "resultData":updateCartui?cartui:Get.put(ParticipatedQuery()).dataCartui["resultData"],
    };
    update(); // call update method to update the state
  }

  //Participated in events  after getting user Data
  //search events
  //set events as default one
  //sync events online to offline vice versa
  //get event details and save to stateManagement
getSearchAllStockOnline(Topups topupData,BonusModel bonusData)async{
  try {

    var params =  {
      "productCode":bonusData.productName??'none',//productCode=productName
      "LimitStart":topupData.endlimit,  //page
      "LimitEnd":topupData.startlimit//limit

      //"options": [1,2,3],
    };

    String authToken =(adminStateData.obj)["result"][0]["AuthToken"];
    var url="${ConstantClassUtil.StockLink}/viewSearchAllStock";
    var response = await Dio().get(url,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader:"Bearer $authToken"
        //HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
      }),
      queryParameters: params,
    );
    if (response.statusCode == 200) {

      //updateAllParticipateState(response.data);
      return response;


    } else {
      return false;
      //print(false);
    }
  } catch (e) {
    //return false;
  }
}
getPreviousPriceOnline(Topups topupData,BonusModel bonusData)async{
  try {

    var params =  {

      "productCode":bonusData.productName,  //here productName=productCode
      "limitData":topupData.endlimit??10//limit

      //"options": [1,2,3],
    };

    String authToken =(adminStateData.obj)["result"][0]["AuthToken"];
    var url="${ConstantClassUtil.StockLink}/cardSearchPreviousPrice";
    var response = await Dio().get(url,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader:"Bearer $authToken"
        //HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
      }),
      queryParameters: params,
    );
    if (response.statusCode == 200) {

      //updateAllParticipateState(response.data);
      return response;


    } else {
      return false;
      //print(false);
    }
  } catch (e) {
    //return false;
  }

}
  getAllQuickBonusEventOnline(Topups topupData) async{//all participated events reached or not reached
    try {

      var params =  {

        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit//limit

        //"options": [1,2,3],
      };

      String authToken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetAllQuickBonus";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
          //HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }

  SearchQuickBonusEventOnline(BonusModel bonusData) async{//all participated events reached or not reached
    try {

      var params =  {

        "productName":bonusData.productName, //page


        //"options": [1,2,3],
      };

      String authToken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/SearchQuickBonus";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
          //HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }

  SubmitQuickBonusEventOnline(BonusModel quickData) async{


    try {

      var params =  {
        "uid":quickData.uid,
        "uidUser":quickData.uidUser,
        "quickUid":quickData.quickUid,
        "productName":quickData.productName,
         "qty":quickData.qty,
         "price":quickData.price,
         "status":quickData.status??'on',
         "bonusType":quickData.bonusType,
         "giftName":quickData.giftName,
         "giftPcs":quickData.giftPcs,
         "bonusValue":quickData.bonusValue,
         "totBonusValue":quickData.totBonusValue,
         "description":quickData.description??'none'


        //"options": [1,2,3],
      };
      String authToken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/SubmitQuickBonus";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
          //HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }

  }

  UpdateSubmitQuickBonusEventOnline(BonusModel quickData) async{


    try {

      var params =  {
        "id":quickData.uid,
        "uidUser":quickData.uidUser,
       // "quickUid":quickData.quickUid,
        "productName":quickData.productName,
        "qty":quickData.qty,
        "price":quickData.price,
        "status":quickData.status??'on',
        "bonusType":quickData.bonusType,
        "giftName":quickData.giftName,
        "giftPcs":quickData.giftPcs,
        "bonusValue":quickData.bonusValue,
        "totBonusValue":quickData.totBonusValue,
        "description":quickData.description??'none'


        //"options": [1,2,3],
      };
      String authToken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/UpdateSubmitQuickBonus";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
         // HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }

  }
  ConfirmAllSubmitQuickBonusEventOnline(BonusModel quickData) async{


    try {

      var params =  {
        "uid":quickData.uid,
        "uidUser":quickData.uidUser



        //"options": [1,2,3],
      };
      String authToken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/ConfirmAllSubmitQuickBonus";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
          //HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }

  }
  ConfirmOnlySubmitQuickBonusEventOnline(BonusModel quickData) async{


    try {

      var params =  {
        "id":quickData.uid,
        "uidUser":quickData.uidUser



        //"options": [1,2,3],
      };
      String authToken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/ConfirmOnlySubmitQuickBonus";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $authToken"
         // HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }

  }
  SearchSubmitQuickBonusEventOnline(BonusModel quickData,Topups topupData) async{//this will display all Data in Cart that their status are on


    try {

      var params =  {
        "uidUser":quickData.uidUser,
        "productName":quickData.productName,
        "status":quickData.status,
        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit//limit





        //"options": [1,2,3],
      };
      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/SearchSubmitQuickBonus";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
          //HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }

  }
  GetUidSubmitQuickBonusEventOnline(BonusModel quickData) async{//this will display all Data in Cart that their status are on


    try {

      var params =  {
        "uidUser":quickData.uidUser



        //"options": [1,2,3],
      };
      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetUidSubmitQuickBonus";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
          //HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }

  }
  DeleteAllSubmitQuickBonusEventOnline(BonusModel quickData) async{//this will display all Data in Cart that their status are on


    try {

      var params =  {
        "uid":quickData.uid,
        "uidUser":quickData.uidUser




        //"options": [1,2,3],
      };
      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/DeleteAllSubmitQuickBonus";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
          //HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }

  }
  deleteOnlySubmitQuickBonusEventOnline(BonusModel quickData) async{//this will display all Data in Cart that their status are on


    try {

      var params =  {
        "id":quickData.uid,
        "uidUser":quickData.uidUser




        //"options": [1,2,3],
      };
      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/DeleteOnlySubmitQuickBonus";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
          //HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }

  }

  ParticipateEventOnline(Participated participateddata,Promotions promotionData) async{

    try {

      var params =  {

        "inputAction":"participated",
        "uid":participateddata.uid,//promotion Id
        "uidUser":participateddata.uidUser,
        "userStatus":"member",
        "inputData":participateddata.inputData??"1",
        "weight":participateddata.weight,
        "promo_msg":promotionData.promo_msg,
        "reach":promotionData.reach,
        "gain":promotionData.gain

      };
      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];

      var url="${ConstantClassUtil.urlLink}/ParticipateEvent";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        data: jsonEncode(params),
      );
      //print(params);
      if (response.statusCode == 200) {

       // print(response.data);
        updateParticipateState(response.data);
        return response.data;



      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      print(e);
      //return false;
    }

  }
  ParticipateEditEventOnline(Participated participateddata,Promotions promotionData) async{

    try {

      var params =  {
        "uid":participateddata.uid,
        "uidUser":participateddata.uidUser,
        "inputData":participateddata.inputData,
        "reach":promotionData.reach,
        "gain":promotionData.gain
        //"options": [1,2,3],
      };
      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];

      var url="${ConstantClassUtil.urlLink}/ParticipateEditEvent";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {

       // updateParticipateState(response.data);
        return response;



      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }

  }
  getAllParticipateEventOnline(Participated ParticipatedData,Topups TopupData) async{//all participated events reached or not reached
    try {

      var params =  {

        "uidUser":ParticipatedData.uid,   //"kebineericMuna_1668935593",
        "LimitStart":TopupData.endlimit,  //page
        "LimitEnd":TopupData.startlimit//limit

        //"options": [1,2,3],
      };

      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetAllParticipateEvent";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateAllParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }
  getCountParticipateEventOnline(Participated ParticipatedData) async{//reached
    try {

      var params =  {

        "uidUser":ParticipatedData.uidUser   //"kebineericMuna_1668935593",

        //"options": [1,2,3],
      };

      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/CountParticipateEvent";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        updateCountParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }
  getActiveParticipateEventOnline(Participated ParticipatedData) async{//Active
    try {

      var params =  {

        "uidUser":ParticipatedData.uid,   //"kebineericMuna_1668935593",

        //"options": [1,2,3],
      };

      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetActiveParticipateEvent";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {


        updateActiveParticipateState(response.data);
        return response;

      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }
  getReachedParticipateEventOnline(Participated ParticipatedData) async{//reached
    try {

      var params =  {

        "uidUser":ParticipatedData.uid,   //"kebineericMuna_1668935593",

        //"options": [1,2,3],
      };

      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetReachedParticipateEvent";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        updateReachedParticipateState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }
  getParticipateHistEventOnline(Participated ParticipatedData,Topups TopupData) async{//reached
    try {

      var params =  {
        "uid":ParticipatedData.uid,
        "uidUser":ParticipatedData.uidUser,   //"kebineericMuna_1668935593",
        "LimitStart":TopupData.endlimit,  //page
        "LimitEnd":TopupData.startlimit//limit

        //"options": [1,2,3],
      };

      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetParticipatedHist";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateParticipateHistState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }
  getAllParticipateOnline(Topups topupData,User userData) async{//reached
    try {

      var params =  {
        //"kebineericMuna_1668935593",
        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":userData.name??'none'

        //"options": [1,2,3],
      };

      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetAllParticipate";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateParticipateHistState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }
  getAllPackage(Topups topupData,User userData) async{
    try {

      var params =  {
        //"kebineericMuna_1668935593",
        "inputAction":"viewallpackage",
        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":userData.name??'none'

        //"options": [1,2,3],
      };

      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/package";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateParticipateHistState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }
  participantIn(Topups topupData,User userData) async{
    try {

      var params =  {
        //"kebineericMuna_1668935593",
      "inputAction":"clientparticipant",
      "uid":"gold_1748467262",
      "uidUser":"kebineericMuna_1676390572",
      "userStatus":"member",
      "commentData":"Option",
        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":userData.name??'none'

        //"options": [1,2,3],
      };

      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/participant";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateParticipateHistState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }

  participantGetPayment(Topups topupData) async{
    try {

      var params =  {
        //"kebineericMuna_1668935593",
        "inputAction":"getmembership",
       "advancedSearch":topupData.advancedSearch,
       "searchOption":topupData.optionCase,
       "uidUser":"kebineericMuna_1676390572",
       "userStatus":"member",
        "commentData":"Option",
        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":topupData.name??'none',
        "thisDate":topupData.created_at,
        "toDate":topupData.updated_at??'none'

        //"options": [1,2,3],
      };
//print(params);
      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/payment";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateParticipateHistState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }
  participantPayment(Participated participateddata,User userData) async{
// cash Payment or Card Payment
    try {

      var params =  {
        "inputAction":participateddata.inputAction,
        "uid":participateddata.uid??"none",//packageUid
        "carduid":participateddata.carduid??"none",
       // "PhoneNumber":"+25071113655898",
        "PhoneNumber":userData.phone??"none",
        "name":userData.name??"none",
        "commentData":"Option",
        "createEvenExist":"yes"
        //"options": [1,2,3],
      };
      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];

      var url="${ConstantClassUtil.urlLink}/payment";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {

        // updateParticipateState(response.data);
        return response;
          print(response);


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }

  }
  getAllParticipateHistEventOnline(Topups topupData,User userData) async{//reached
    try {

      var params =  {
        //"kebineericMuna_1668935593",
        "LimitStart":topupData.endlimit,  //page
        "LimitEnd":topupData.startlimit,//limit
        "name":userData.name??'none'

        //"options": [1,2,3],
      };

      String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetAllParticipatedHist";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer $Authtoken"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        //updateParticipateHistState(response.data);
        return response;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
    }
  }
  participateEvent(Participated participateddata) async {



    Database db = await DatabaseHelper.instance.database;

    List<Map> check=await db.rawQuery('select uid,uidUser from participateds where uid="${(promotionStateData.obj)["result"][0]["uid"]}" and uidUser="${(userStatedata.obj)["result"][0]["uid"]}" limit 1 ');

    if(check.length>0)
    {
      // available user then update query
//not limit give me errors
      int count = await db.rawUpdate(//here is to update status to On where there is status Default
          'UPDATE participateds SET inputData=inputData+${participateddata.inputData} WHERE uid= ? and uidUser=?',
          ['${(promotionStateData.obj)["result"][0]["uid"]}','${(userStatedata.obj)["result"][0]["uid"]}']);
      //checkParticipatedReached();
      return count;

    }
    else{
      //N/A insert query
      int t1=0;
      await db.transaction((txn) async{
        int id1 = await txn.rawInsert(
            'INSERT INTO participateds(uid,uidUser,uidCreator,subscriber,inputData,promotion_msg,token,started_date,ended_date,status) '
                'VALUES("${(promotionStateData.obj)["result"][0]["uid"]}","${(userStatedata.obj)["result"][0]["uid"]}","${(adminStateData.obj)["result"][0]["uid"]}","${(adminStateData.obj)["result"][0]["subscriber"]}","${participateddata.inputData}","${(promotionStateData.obj)["result"][0]["promo_msg"]}","${participateddata.token}","${(promotionStateData.obj)["result"][0]["started_date"]}","${(promotionStateData.obj)["result"][0]["ended_date"]}","Active")');


        t1=id1;
      });
      // checkParticipatedReached();
      return t1;

    }


  }
  checkParticipatedReached()async
  {

    Database db = await DatabaseHelper.instance.database;
    List<Map>list=await db.rawQuery('select *from participateds where uid="${(promotionStateData.obj)["result"][0]["uid"]}" and uidUser="${(userStatedata.obj)["result"][0]["uid"]}" ');
    if((list.length)>0)
    {
      //there is user associated with this Account
      // updateState();
      updateParticipateState(list);
      return list;
    }
    else{
      // updateParticipateState(list);
      return list.length;
    }

  }
  updateParticipateState(list){ //save user

    obj={
      "id":4,
      "resultData":list
    };
    update();




  }

  updateActiveParticipateState(list){ //save user

    active={
      "id":4,
      "resultData":list
    };
    update();




  }
  updateReachedParticipateState(list){ //save user

    reached={
      "id":4,
      "resultData":list
    };
    update();




  }
  updateParticipateHistState(list){ //save user

    hist={
      "id":4,
      "resultData":list
    };
    update();




  }
  updateCountParticipateState(list){ //save user

    countData={
      "id":4,
      "resultData":list
    };
    update();




  }
  updateAllParticipateState(list){ //save user

    all={
      "id":4,
      "resultData":list
    };
    update();




  }
  //
  Future<List<Participated>> getGroceries() async {
    Database db = await DatabaseHelper.instance.database;
    var groceries = await db.query('groceries', orderBy: 'name');
    List<Participated> participatedList = groceries.isNotEmpty
        ? groceries.map((c) => Participated.fromMap(c)).toList()
        : [];
    return participatedList;
  }

  Future<int> add(Participated participateddata) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('groceries', participateddata.toMap());
  }

  Future<List<Participated>> getData() async{
    Database db = await DatabaseHelper.instance.database;
    var groceries=await db.rawQuery('SELECT *FROM groceries');
    List<Participated> participatedList = groceries.isNotEmpty
        ? groceries.map((c) => Participated.fromMap(c)).toList()
        : [];
    return participatedList;

  }
  Future addData() async{
    Database db = await DatabaseHelper.instance.database;
    await db.rawQuery('INSERT INTO testdata(name) VALUES("ndaje")');
  }
  testdata(Participated participateddata) async {

    Database db = await DatabaseHelper.instance.database;
    //await db.rawQuery('INSERT INTO groceries(name) VALUES("${Participateddata.name}")');
    int t1=0;
    await db.transaction((txn) async{
      int id1 = await txn.rawInsert(
          'INSERT INTO groceries(name) VALUES("${participateddata.uid}")');

      t1=id1;
    });
    return t1;


  }


  getMyData() async{
    Database db = await DatabaseHelper.instance.database;
    List<Map> list=await db.rawQuery('select *from groceries');
    return list;
  }
}