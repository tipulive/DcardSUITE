import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Promotions.dart';
import '../models/Admin.dart';

import '../DatabaseHelper.dart';
import '../Utilconfig/ConstantClassUtil.dart';

import 'AdminQuery.dart';
class PromotionQuery extends GetxController{

  AdminQuery adminStatedata=Get.put(AdminQuery());
  //create promotions or events
  //search promotions as default promotions
  //disable promotion //online to offline
  //sync events online to offline vice versa
  //get event details and save to stateManagement

  Map<String,dynamic> obj={
    "name":"name",
    "id":1,
    "result":[
      {
        "id":10
      }
    ],
  }.obs;

  getAllPromotionEventOnline() async{
    try {

      var params =  {

        "uidUser":"kebineericMuna_1668935593",

        //"options": [1,2,3],
      };

      String Authtoken =(adminStatedata.obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetAllPromotionEvent";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${Authtoken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {


       // return (response.data).length;
        updateEventState(response.data);
        return response.data;
        //print(response.data);



      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }

  CreateEventOnine(Promotions PromotionData) async{
    try {

      var params =  {
        "promoName":PromotionData.promoName,
        "promoMsg":PromotionData.promo_msg,
        "reach":PromotionData.reach,
        "gain":PromotionData.gain,
        "started_date":PromotionData.started_date,
        "ended_date":PromotionData.ended_date,
        "status":PromotionData.status

        //"uid":"kebineericMuna_1668935593",//userid

        //"options": [1,2,3],
      };
      String Authtoken =(adminStatedata.obj)["result"][0]["AuthToken"];

      var url="${ConstantClassUtil.urlLink}/CreatePromotionEvent";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${Authtoken}"
        }),
        data: jsonEncode(params),
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
  createEvent(Promotions event) async {
//event status //on/off/default/close  //on means created,off/disable for view/default means other default will be on//close means event is expired
  //one event must be default only in table of one company

    Database db = await DatabaseHelper.instance.database;

    int t1=0;
    await db.transaction((txn) async{
      int id1 = await txn.rawInsert(
          'INSERT INTO promotions(uid,uidCreator,"subscriber","token","promoName","promo_msg","reach","gain","started_date","ended_date","status") VALUES("${event.uid}","${(adminStatedata.obj)["result"][0]["uid"]}","${(adminStatedata.obj)["result"][0]["subscriber"]}","100","${event.promoName}","Discount Msg","${event.reach}","${event.gain}","06/11/2022","07/11/2022","On")');

      t1=id1;
    });
    return t1;




  }
  getPromotioEvent() async {//search User with uid and get userDetails here i will add my authentication Details here uid is card ui

    Database db = await DatabaseHelper.instance.database;
    List<Map>list=await db.rawQuery("Select *from promotions where status='Default' limit 1");
    if((list.length)>0)
    {
      //there is user associated with this Account
      // updateState();
      updateEventState(list);
      return list;
    }
    else{
      List<Map>list=await db.rawQuery("Select *from promotions where status='On' limit 1");//select open event by asc
      updateEventState(list);
      return list;
    }
  }

  setDefaultPromotioEvent(Promotions event) async {//search User with uid and get userDetails here i will add my authentication Details here uid is card ui

    Database db = await DatabaseHelper.instance.database;
    int count = await db.rawUpdate(//here is to update status to On where there is status Default
        'UPDATE promotions SET status = ? WHERE status= ? limit 1',
        ['On','Default']);


    if((count)>0)
    {

      int count1 = await db.rawUpdate(//here is to update status to On where there is status Default
          'UPDATE promotions SET status = ? WHERE uid = ? limit 1',
          ['On',event.uid]);

      if(count1>0)
        {
          getPromotioEvent();//means update state management
        }
      else
        {
          return 1;
        }

    }
    else{
      int count1 = await db.rawUpdate(//here is to update status to On where there is status Default
          'UPDATE promotions SET status = ? WHERE uid = ? limit 1',
          ['On',event.uid]);

      if(count1>0)
      {
        getPromotioEvent();//means update state management
      }
      else
      {
        return 1;
      }
      //return count;
    }
  }

  setOfftPromotioEvent(Promotions event) async {//search User with uid and get userDetails here i will add my authentication Details here uid is card ui

    Database db = await DatabaseHelper.instance.database;
    int count = await db.rawUpdate(
        'UPDATE promotions SET status = ? WHERE uid = ?',
        ['Off',event.uid]);


    if((count)>0)
    {
      //there is user associated with this Account
      // updateState();

      getPromotioEvent();//means update state management
    }
    else{
      return count;
    }
  }
  setClosetPromotioEvent(Promotions event) async {//search User with uid and get userDetails here i will add my authentication Details here uid is card ui

    Database db = await DatabaseHelper.instance.database;
    int count = await db.rawUpdate(
        'UPDATE promotions SET status = ? WHERE uid = ?',
        ["Close",event.uid]);


    if((count)>0)
    {
      //there is user associated with this Account
      // updateState();

      getPromotioEvent();//means update state management
    }
    else{
      return count;
    }
  }

  updateEventState(list){ //save user

    obj={
      "id":4,
      "resultData":list
    };
    update();




  }







  Future<List<Promotions>> getGroceries() async {
    Database db = await DatabaseHelper.instance.database;
    var groceries = await db.query('groceries', orderBy: 'name');
    List<Promotions> promotionsList = groceries.isNotEmpty
        ? groceries.map((c) => Promotions.fromMap(c)).toList()
        : [];
    return promotionsList;
  }

  Future<int> add(Promotions promotionsdata) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('groceries', promotionsdata.toMap());
  }

  Future<List<Promotions>> getData() async{
    Database db = await DatabaseHelper.instance.database;
    var groceries=await db.rawQuery('SELECT *FROM groceries');
    List<Promotions> promotionsList = groceries.isNotEmpty
        ? groceries.map((c) => Promotions.fromMap(c)).toList()
        : [];
    return promotionsList;

  }
  Future addData() async{
    Database db = await DatabaseHelper.instance.database;
    await db.rawQuery('INSERT INTO testdata(name) VALUES("ndaje")');
  }
  testdata(Promotions promotionsdata) async {

    Database db = await DatabaseHelper.instance.database;
    //await db.rawQuery('INSERT INTO groceries(name) VALUES("${Promotionsdata.name}")');
    int t1=0;
    await db.transaction((txn) async{
      int id1 = await txn.rawInsert(
          'INSERT INTO groceries(name) VALUES("${promotionsdata.uid}")');

      t1=id1;
    });
    return t1;


  }


  getMyData() async{
    Database db = await DatabaseHelper.instance.database;
    List<Map> list=await db.rawQuery('select *from groceries');
    return list;
  }
  void onReady() async{
    super.onReady();
    await getAllPromotionEventOnline();
  }
  void onInit() async{

    await getAllPromotionEventOnline();
  }
}