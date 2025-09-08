import 'package:sqflite/sqflite.dart';
import '../models/User.dart';
import '../models/Syncoff.dart';
import '../models/Syncon.dart';
import 'package:get/get.dart';
import '../Query/AdminQuery.dart';
import '../DatabaseHelper.dart';
class UserQuery extends GetxController{
  AdminQuery adminStatedata=Get.put(AdminQuery());
  //first Step is to save user state after scanning card
  var store=8.obs;
  Map<String,dynamic> obj={
  "name":"name",
  "id":1,
    "result":[
      {
        "id":10
      }
    ],
}.obs;

  Future SyncOffAdd(User userdata,Syncoff syncoffdata) async{//this is every time you will add new user

    //
    if(((await adminStatedata.auth()).length)>0) {
      Database db = await DatabaseHelper.instance.database;
      List<Map>list=await db.rawQuery("Select *from Syncoff where tableName='users' and actionName='add' limit 1 ");
      if((list.length)>0)
      {
        //update Process
        int t1=0;
        await db.transaction((txn) async{
          int id1 = await txn.rawInsert(
              'INSERT INTO users(uid,uidCreator,subscriber) VALUES("${userdata.uid}","${(adminStatedata.obj)["result"][0]["uid"]}","${(adminStatedata.obj)["result"][0]["subscriber"]}")');

          t1=id1;
        });

        if(t1>=1)
        {

          int count = await db.rawUpdate(//here is to update status to On where there is status Default
              'UPDATE Syncoff SET versionCount="${syncoffdata.versionCount}"+versionCount WHERE tablename= ? and actionName=? limit 1',
              ['users','add']);


          return count;

        }


      }
      else{
        //Add Process

        int t1=0;
        await db.transaction((txn) async{
          int id1 = await txn.rawInsert(
              'INSERT INTO users(uid,uidCreator,subscriber) VALUES("${userdata.uid}","${(adminStatedata.obj)["result"][0]["uid"]}","${(adminStatedata.obj)["result"][0]["subscriber"]}")');

          t1=id1;
        });

        if(t1>=1)
        {
          int t2=0;
          await db.transaction((txn) async{
            int id2 = await txn.rawInsert(
                'INSERT INTO Syncoff(uid,versionCount,subscriber,actionName,tableName) VALUES("${userdata.uid}","${syncoffdata.versionCount}","${(adminStatedata.obj)["result"][0]["subscriber"]}","add","users")');

            t2=id2;
          });
          return t2;

        }


      }






    }



  }
  Future addData(User userdata) async{


    if(((await adminStatedata.auth()).length)>0) {



      Database db = await DatabaseHelper.instance.database;

      int t1=0;
      await db.transaction((txn) async{
        int id1 = await txn.rawInsert(
            'INSERT INTO users(uid,carduid,name,phone,email,photo_url,uidCreator,subscriber) VALUES("${userdata.uid}","${userdata.carduid}","${userdata.name}","${userdata.phone}","email","photo_url","${(adminStatedata.obj)["result"][0]["uid"]}","${(adminStatedata.obj)["result"][0]["subscriber"]}")');

        t1=id1;
      });

      return t1;


    }

  }
  getUser(User userdata) async {//search User with uid and get userDetails here i will add my authentication Details here uid is card ui

    Database db = await DatabaseHelper.instance.database;
    List<Map>list=await db.rawQuery("Select *from users where uid='${userdata.uid}'");
    if((list.length)>0)
    {
      //there is user associated with this Account
      // updateState();
      updateUserState(list);
      return list;
    }
    else{
      return list.length;
    }
  }

  updateUserState(list){ //save user
    store.value=7;
    obj={
      "id":4,
      "result":list
    };
    update();




  }










  getMyData() async{

    Database db = await DatabaseHelper.instance.database;
    List<Map> list=await db.rawQuery('select *from groceries');
    return list;
  }

  //
  Future<List<User>> getGroceries() async {
    Database db = await DatabaseHelper.instance.database;
    var groceries = await db.query('groceries', orderBy: 'name');
    List<User> userList = groceries.isNotEmpty
        ? groceries.map((c) => User.fromMap(c)).toList()
        : [];
    return userList;
  }

  Future<int> add(User userdata) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('groceries', userdata.toMap());
  }

  Future<List<User>> getData() async{
    Database db = await DatabaseHelper.instance.database;
    var groceries=await db.rawQuery('SELECT *FROM groceries');
    List<User> userList = groceries.isNotEmpty
        ? groceries.map((c) => User.fromMap(c)).toList()
        : [];
    return userList;

  }

  testdata(User userdata) async {

    Database db = await DatabaseHelper.instance.database;
    //await db.rawQuery('INSERT INTO groceries(name) VALUES("${Userdata.name}")');
    int t1=0;
    await db.transaction((txn) async{
      int id1 = await txn.rawInsert(
          'INSERT INTO groceries(name) VALUES("${userdata.name}")');

      t1=id1;
    });
    return t1;


  }



}