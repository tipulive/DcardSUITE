import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Admin.dart';

import '../DatabaseHelper.dart';
class AdminQuery extends GetxController{

  var adminAuth=1.obs;
//Create object to save Admin state after login
  Map<String,dynamic> obj={
    "name":"Admin",
    "id":1,
    "result":0,
  }.obs;

void onReady(){
  super.onReady();
  auth();
}
  auth() async{//this is our Admin Auth template

    Database db = await DatabaseHelper.instance.database;
    //List<Map> list=await db.rawQuery("select *from admins where uid='ndaje' limit 1");
    List<Map> list=await db.rawQuery("select *from admins limit 1");
    //return list;
    if((list.length)>0)
    {
      //there is user associated with this Account
      // updateState();
      updateAdminState(list);
      return list;
    }
    else{
      //updateAdminState(list);
      return list.length;
    }

  }
  logout() async{//this is our Admin Auth template

    Database db = await DatabaseHelper.instance.database;
    //List<Map> list=await db.rawQuery("select *from admins where uid='ndaje' limit 1");
    int result=await db.rawDelete("DELETE FROM `admins` WHERE id=1");
    //return list;
    if(result>0)
    {
      //there is user associated with this Account
      // updateState();
      updateAdminState(0);
      return result;
    }
    else{
      //updateAdminState(list);
      return result;
    }

  }

  updateAdminState(list){ //save State
    adminAuth.value=9;
    obj={
      "id":4,
      "result":list
    };
    update();




  }

  Future addData(Admin adminData) async{
    Database db = await DatabaseHelper.instance.database;

    int t1=0;
    await db.transaction((txn) async{
      int id1 = await txn.rawInsert(
          'INSERT OR REPLACE INTO admins(uid,name,subscriber,AuthToken,email,phone) VALUES("${adminData.uid}","${adminData.name}","${adminData.subscriber}","${adminData.AuthToken}","${adminData.email}","${adminData.phone}")');

      t1=id1;
    });
    return t1;
  }








  Future<int> add(Admin admindata) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('groceries', admindata.toMap());
  }

  Future<List<Admin>> getData() async{
    Database db = await DatabaseHelper.instance.database;
    var groceries=await db.rawQuery('SELECT *FROM groceries');
    List<Admin> adminList = groceries.isNotEmpty
        ? groceries.map((c) => Admin.fromMap(c)).toList()
        : [];
    return adminList;

  }

  testdata(Admin admindata) async {

    Database db = await DatabaseHelper.instance.database;
    //await db.rawQuery('INSERT INTO groceries(name) VALUES("${Admindata.name}")');
    int t1=0;
    await db.transaction((txn) async{
      int id1 = await txn.rawInsert(
          'INSERT INTO groceries(name) VALUES("${admindata.name}")');

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