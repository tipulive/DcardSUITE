import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Query/AdminQuery.dart';
import '../Query/ParticipatedQuery.dart';
import '../Query/PromotionQuery.dart';
import '../Query/UserQuery.dart';
import '../Utilconfig/ConstantClassUtil.dart';
import '../models/Admin.dart';
import '../models/Participated.dart';
import '../models/Promotions.dart';
import '../models/User.dart';
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController uidInput=TextEditingController();
  TextEditingController uidInput2=TextEditingController();
  TextEditingController uidInput3=TextEditingController();
  TextEditingController uidInput4=TextEditingController();
  UserQuery userQueryData = Get.put(UserQuery());
  AdminQuery adminStatedata=Get.put(AdminQuery());
  PromotionQuery promotionState=Get.put(PromotionQuery());
  ParticipatedQuery participatedState=Get.put(ParticipatedQuery());
  ConstantClassUtil DateState=Get.put(ConstantClassUtil());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        //scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
                child:Column(
                  children: [

                    TextField(
                      controller: uidInput,
                    ),
                    TextField(
                      controller: uidInput2,
                    ),
                    TextField(
                      controller: uidInput3,
                    ),
                    TextField(
                      controller: uidInput4,
                    ),
                    TextButton(
                        onPressed: () async=>{
                          if((await AdminQuery().addData(Admin(uid:uidInput.text,subscriber: uidInput2.text)))>0)
                            {
                              print("Data is inserted"),
                            }
                          else{
                            // print((await AdminQuery().addData(Admin(uid:uidInput.text,subscriber: uidInput2.text)))),
                          }

                          // Wakelock.enable()
                        },
                        child: const Text("Create Admin")
                    ),
                    TextButton(
                        onPressed: () async=>{



                          if((await UserQuery().addData(User(uid:uidInput.text,subscriber: uidInput2.text)))>0)
                            {
                              //print("User Created"),
                              userQueryData.getUser(User(uid: uidInput.text)),//temporary for testing only
                            }
                          else{
                            print("Error"),
                          }



                          // Wakelock.enable()
                        },
                        child: const Text("Create User")
                    ),
                    TextButton(
                        onPressed: () async=>{
                          //test=new DbQuery().testdata(Grocery(name: uidInput.text)),
                          //print(test)
                          print(await PromotionQuery().createEvent(Promotions(uid:uidInput.text,promoName:uidInput2.text,reach:uidInput3.text,gain:uidInput4.text))
                          ),
                          // Wakelock.enable()
                        },

                        child: const Text("Create Promotion")
                    ),
                    TextButton(
                        onPressed: () async=>{
                          await PromotionQuery().setDefaultPromotioEvent(Promotions(uid:uidInput.text))

                          // Wakelock.enable()
                        },

                        child: const Text("Set Default Promotion")
                    ),
                    Obx(() =>Column(
                      children: [

                        Text(
                            "${userQueryData.store}"
                        ),
                        Text("${(userQueryData.obj)["result"][0]["id"]}"),
                      ],
                    ),


                    ),
                    TextButton(
                        onPressed: () async=> {
                          //print(uidInput.text),
                          print(await promotionState.getPromotioEvent()),
                          // Wakelock.enable()
                        },
                        child: const Text("Get Promotion Event")
                    ),

                    TextButton(
                        onPressed: ()async =>{
                          //deleteData(uidInput.text)
                          // Wakelock.enable()
                          //print(await ParticipatedQuery().participateEvent(Participated(token: uidInput.text,inputData:uidInput4.text ))),

                          if((await participatedState.participateEvent(Participated(token: uidInput.text,inputData:uidInput4.text ))>0))
                            {
                              //then check print participateds obj
                              if(((await participatedState.checkParticipatedReached()).length)>0)
                                {

                                  if(int.parse(participatedState.obj["result"][0]["inputData"])>=int.parse(promotionState.obj["result"][0]["reach"]))
                                    {
                                      print(int.parse(participatedState.obj["result"][0]["inputData"])/int.parse(promotionState.obj["result"][0]["reach"])* int.parse(promotionState.obj["result"][0]["gain"])),
                                    }
                                  else{
                                    print(int.parse(participatedState.obj["result"][0]["inputData"])/int.parse(promotionState.obj["result"][0]["reach"])* int.parse(promotionState.obj["result"][0]["gain"])),
                                    print(participatedState.obj["result"][0]["inputData"])
                                  }
                                  //

                                  //print(participatedState.obj["result"][0]["inputData"])
                                  //print("${(participatedState.obj)}${result}")
                                }
                            }
                          else{

                          }

                        },
                        child: const Text("participate events")
                    ),
                    TextButton(
                        onPressed: () =>{
                          //print(getdata.store)
                          // Wakelock.enable()
                          userQueryData.getUser(User(uid: uidInput.text)),
                        },
                        child: const Text("Scan this is first Step")
                    ),
                    TextButton(
                        onPressed: ()async =>{
                          //Get.to(Home())
                          // Wakelock.enable()
                          print(await DateState.updateDate()),
                        },
                        child: const Text("Get Date and time")
                    ),
                    TextButton(
                        onPressed: ()async =>{
                          //Get.to(Home())
                          // Wakelock.enable()
                          print(await DateState.updateDate()),
                        },
                        child: const Text("date picker Rang")
                    ),

                    TextButton(
                        onPressed: ()async =>{

                          /* if((await checkInternet()))
                       {
                         print("internte")
                       }
                     else{
                       print("no Internet")
            }

                     */

                          //print((await apiData())["products"][2]["title"])
                          //print(await checkInternetStatus()),
                          /*for(var i=0;i<((await apiData())["products"]).length;i++)
                            {
                              //print((await apiData())["products"][i]["title"])
                              DbQuery().testdata(Grocery(name:((await apiData())["products"][i]["title"])))
                            }*/
                          //DbQuery().testdata(Grocery(name:((await apiData())["products"][2]["title"])))
                          print((await apiGetData()))

                        },
                        child: const Text("check internet")
                    ),
                    TextButton(
                        onPressed: ()async =>{
                          //print((await DbQuery().getMyData()))

                        },
                        child: const Text("Send data to online")
                    ),






                  ],
                )

            )

          ],
        ),
      ) ,
      floatingActionButton: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
            child: FloatingActionButton(
              heroTag: "btn1",
              onPressed: null,
              tooltip: 'Increment',
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("images/profile.jpg",
                ),
              ),
            ),
          ),

          FloatingActionButton(
            heroTag: "btn2",
            onPressed: null,
            tooltip: 'Increment',
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("images/profile.jpg",
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

 //Method
  apiPostData(apiData) async{
    try {

      var params =  {
        "item": "itemx",
        "onlineData":apiData,
        //"options": [1,2,3],
      };


      var url='http://10.0.2.2:8000/api/testPostData';
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {

        return response.data;
      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      return false;
      //print(false);
    }
  }
  apiGetData() async{
    try {
      // var url='https://dummyjson.com/products';
      var url='http://10.0.2.2:8000/api/testGetData';
      var response = await Dio().get(url);
      if (response.statusCode == 200) {

        return response.data;
      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      return false;
      //print(false);
    }
  }
//method
}
