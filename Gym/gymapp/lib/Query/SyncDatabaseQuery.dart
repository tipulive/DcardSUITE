import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/CardModel.dart';
import '../DatabaseHelper.dart';
import '../Utilconfig/ConstantClassUtil.dart';
import '../Query/CardQuery.dart';



class SyncDatabaseQuery{ //online and offline download

  getSyncOnCard() async{ //download Card online
    Database db = await DatabaseHelper.instance.database;
    List<Map>list=await db.rawQuery("Select *from Syncon where actionName='add' and tableName='cards' limit 1");
    if((list.length)>0)
    {
      //there is user associated with this Account
      // updateState();
      //updateCardState(list);
       //return "test";
      return (await CardQuery().getCardSearch(CardModel(uid:list[0]["versionCount"])));

    }
    else{
      return list.length;

    }
  }
  getSyncOffCard() async{ //download Card online
    Database db = await DatabaseHelper.instance.database;
    List<Map>list=await db.rawQuery("Select *from Syncoff where actionName='add' and tableName='cards' limit 1");
    if((list.length)>0)
    {
      //there is user associated with this Account
      // updateState();
      //updateCardState(list);
      return list[0]["versionCount"];

    }
    else{
      return list.length;

    }
  }




}