import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Query/AdminQuery.dart';

import '../Utilconfig/HideShowState.dart';
import '../models/Admin.dart';
import '../Utilconfig/ConstantClassUtil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:animate_do/animate_do.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController  uidInput=TextEditingController();
  TextEditingController uidInput2=TextEditingController(text:"+250");
  TextEditingController uidInput3=TextEditingController();
  AdminQuery adminStatedata=Get.put(AdminQuery());
  bool showOveray=false;
  bool _canShowButton=true;
  bool isValid=false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              // Dismiss the keyboard when tapping outside of text field
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              // Ensure that content is pushed above the keyboard
                reverse: true,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/background.png'),
                                fit: BoxFit.fill
                            )
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 30,
                              width: 80,
                              height: 200,
                              child: FadeInUp(duration: Duration(seconds: 1), child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/light-1.png')
                                    )
                                ),
                              )),
                            ),
                            Positioned(
                              left: 140,
                              width: 80,
                              height: 150,
                              child: FadeInUp(duration: Duration(milliseconds: 1200), child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/light-2.png')
                                    )
                                ),
                              )),
                            ),
                            Positioned(
                              right: 40,
                              top: 40,
                              width: 80,
                              height: 150,
                              child: FadeInUp(duration: Duration(milliseconds: 1300), child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/clock.png')
                                    )
                                ),
                              )),
                            ),
                            Positioned(
                              child: FadeInUp(duration: Duration(milliseconds: 1600), child: Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child:Text("Login", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                                ),
                              )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Image.asset(
                          'images/playstore.png',
                          width: 60,
                          height: 60,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:15,right:15),
                        child: Column(
                          children: <Widget>[
                            FadeInUp(duration: Duration(milliseconds: 1800), child: Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),

                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10)
                                    )
                                  ]
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(

                                    child: IntlPhoneField(

                                      controller: uidInput,
                                      keyboardType: TextInputType.number,
                                      initialCountryCode: 'RW',
                                      decoration: InputDecoration(
                                          labelText: 'Phone Number',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          //suffixIcon:Obx(() => Get.put(HideShowState()).isNumberValid.value?Icon(Icons.done,color:Colors.green,):Icon(Icons.dangerous,color:Colors.red,)),
                                          suffixIcon:isValid?const Icon(Icons.done,color:Colors.green,):const Icon(Icons.dangerous,color:Colors.red,)

                                      ),

                                      onChanged: (phone) {

                                        if((uidInput.text).isPhoneNumber)
                                        {
                                          // Get.put(HideShowState()).isValid(true);
                                          setState(() {
                                            isValid=true;
                                          });


                                        }
                                        else{
                                          // Get.put(HideShowState()).isValid(false);

                                          setState(() {
                                            isValid=false;
                                          });
                                          // print("not empty");
                                        }
                                      },
                                      onCountryChanged: (country) {


                                        uidInput2.text="+${country.dialCode}";
                                        if((uidInput.text).isPhoneNumber)
                                        {
                                          //Get.put(HideShowState()).isValid(true);
                                          setState(() {
                                            isValid=true;
                                          });
                                        }
                                        else{
                                          // Get.put(HideShowState()).isValid(false);
                                          setState(() {
                                            isValid=false;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: TextField(
                                      controller: uidInput2,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(90.0),
                                        ),
                                        labelText: 'Ccode',
                                      ),
                                    ),
                                  ),

                                  Container(

                                    child: TextField(

                                      controller: uidInput3,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        labelText: 'Password',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 30,),

                            Visibility(
                              visible: isValid,
                              child: FadeInUp(duration: Duration(milliseconds: 1900), child: Container(
                                height: 50,
                                padding: EdgeInsets.only(left: 10,right: 10),
                                child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(

                                      minimumSize: const Size.fromHeight(50),
                                      backgroundColor:Color.fromRGBO(143, 148, 251, 1),
                                      foregroundColor: Colors.white

                                  ),

                                  child: const Text('Log In'),
                                  onPressed: () async{
                                    //print(uidInput.text);
                                    //print(await loginOnline());
                                    await loginOnline();
                                    // Get.to(() =>Aboutpage());
                                  },
                                ),
                              )),
                            ),

                            SizedBox(height: 20,),
                            Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
                            FadeInUp(duration: Duration(milliseconds: 2000), child: Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
                          ],
                        ),
                      )
                    ],
                  ),
                )

            ),
          ),
          if(showOveray)
            Positioned.fill(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white70,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }






  loginOnline() async{
    // print(await SyncService().SyncDownloadCard());
    //print(await SyncService().SyncUploadCard());
    //print(await CardQuery().SyncOffCardAdd());
    setState(() {
      showOveray=true;
    });
    try {

      var params =  {
        "PhoneNumber":"${uidInput2.text}${uidInput.text}",
        "password":uidInput3.text,
        //"options": [1,2,3],
      };


      var url="${ConstantClassUtil.urlLink}/AdminLoginPhone";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          // HttpHeaders.authorizationHeader:""
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        //print(params);
        // print("done");
        //return response.data;
        //return response.data["User"]["name"];
        if((await AdminQuery().addData(Admin(uid:response.data["User"]["uid"],name:response.data["User"]["name"],subscriber:response.data["User"]["subscriber"],AuthToken: response.data["token"],email: response.data["User"]["email"],phone: response.data["User"]["tel"])))>0)
        {
          //Get.to(Homepage());
          //Get.to(() => Homepage());
          Get.put(HideShowState()).isCameraVisible(true);
          await adminStatedata.auth();


          Get.toNamed('/home');
          //Get.toNamed('/sale');

        }
        else{
          // print((await AdminQuery().addData(Admin(uid:uidInput.text,subscriber: uidInput2.text)))),
        }


      } else {
        //return false;
        setState(() {
          showOveray=false;
        });

        Get.toNamed('/ErrorPage');
      }
    } catch (e) {
      //return false;
      setState(() {
        showOveray=false;
      });

      Get.toNamed('/ErrorPage');
    }


  }

  void topupfunc() {
    Get.bottomSheet(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 200,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView(
                        children: [
                          const SizedBox(height: 10.0,),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget> [

                                  const TextField(

                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Balance',
                                      hintText: 'Enter Balance',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  const SizedBox(height: 10.0,),
                                  const TextField(

                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Description',
                                      hintText: 'Enter Description',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  const SizedBox(height: 10.0,),
                                  Center(
                                    child: FloatingActionButton.extended(
                                      label: const Text('Add Balance'), // <-- Text
                                      backgroundColor: Colors.black,
                                      icon: const Icon( // <-- Icon
                                        Icons.thumb_up,
                                        size: 24.0,
                                      ),
                                      onPressed: ()async =>{


                                      },




                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Positioned(

              child: Container(
                padding: const EdgeInsets.all(16),
                child: const CircularProgressIndicator(),
              ),
            ),
          ],
        )
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });
  }
  void showon(){
    Get.bottomSheet(
      Stack(
        children: [
          // your BottomSheet content goes here
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text('BottomSheet Content'),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );

  }
}






