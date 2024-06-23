import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Query/AdminQuery.dart';

import '../Utilconfig/HideShowState.dart';
import '../models/Admin.dart';
import '../Utilconfig/ConstantClassUtil.dart';
import 'package:animate_do/animate_do.dart';

class CountryModel {
  final String name;
  final String fName;
  final String flag;

  CountryModel({required this.name, required this.fName, required this.flag});
}
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController  uidInput=TextEditingController();
  TextEditingController uidInput2=TextEditingController(text:"+250");
  TextEditingController uidInput3=TextEditingController();
  AdminQuery adminStatedata=Get.put(AdminQuery());
  bool showOveray=false;
  bool isValid=false;

  final List<CountryModel> countries = [
    CountryModel(name: 'USD',fName:'USA', flag: '🇺🇸'),
    CountryModel(name: 'FC',fName:'DR Congo',flag: '🇨🇩'),
    CountryModel(name: 'GBP',fName:'United Kingdom', flag: '🇬🇧'),
    CountryModel(name: 'FRW', fName:'Rwanda',flag: '🇷🇼'), // Rwanda

    // Add more countries as needed
  ];

  String? selectedCountry;
  @override
  void initState() {
    super.initState();
    // Set the default selected country to "United States"
    selectedCountry = 'USD';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height:300,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff050f15), Color(0xff081017)],
                      stops: [0, 1],
                      begin: Alignment.center,
                      end: Alignment.center,
                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(96))



                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeInUp(duration: const Duration(seconds: 1), child: Container(
                        decoration: const BoxDecoration(
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
                      child: FadeInUp(duration: const Duration(milliseconds: 1200), child: Container(
                        decoration: const BoxDecoration(
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
                      child: FadeInUp(duration: const Duration(milliseconds: 1300), child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/clock.png')
                            )
                        ),
                      )),
                    ),


                    Positioned(
                      right: 0,
                      top: -20,
                      width: 80,
                      height: 150,
                      child: FadeInUp(duration: const Duration(milliseconds: 1300), child: PopupMenuButton(
                        color: Colors.white,

                        itemBuilder:(container)=>[
                          PopupMenuItem(
                              child: InkWell(
                                onTap: () async{



                                },
                                child: const Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.today,
                                          color: Colors.blue,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left:10.0),
                                          child: Text("Sales",style: TextStyle( fontWeight: FontWeight.bold),),
                                        ),

                                      ],
                                    ),
                                    Divider(
                                      height: 20, // Adjust the height as needed
                                      thickness: 0.2, // Adjust the thickness as needed
                                      color: Colors.grey,
                                    ),

                                  ],
                                ),
                              )
                          ),
                          PopupMenuItem(
                              child: InkWell(
                                onTap: () async{



                                },
                                child: const Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.today,
                                          color: Colors.blue,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left:10.0),
                                          child: Text("Purchase",style: TextStyle( fontWeight: FontWeight.bold),),
                                        ),

                                      ],
                                    ),
                                    Divider(
                                      height: 20, // Adjust the height as needed
                                      thickness: 0.2, // Adjust the thickness as needed
                                      color: Colors.grey,
                                    ),

                                  ],
                                ),
                              )
                          ),
                          PopupMenuItem(
                              child: InkWell(
                                onTap: () async{



                                },
                                child: const Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.today,
                                          color: Colors.blue,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left:10.0),
                                          child: Text("Account",style: TextStyle( fontWeight: FontWeight.bold),),
                                        ),

                                      ],
                                    ),
                                    Divider(
                                      height: 20, // Adjust the height as needed
                                      thickness: 0.2, // Adjust the thickness as needed
                                      color: Colors.grey,
                                    ),

                                  ],
                                ),
                              )
                          ),
                          PopupMenuItem(
                              child: InkWell(
                                onTap: () async{

                                  Get.dialog(
                                    AlertDialog(
                                      title: const Text('Confirmation'),
                                      content: const Text('Do you Want to Logout?'),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(

                                            //primary: Colors.grey[300],
                                            backgroundColor: const Color(0xff9a1c55),
                                            elevation:0,
                                          ),
                                          onPressed: () async{
                                            await Get.put(AdminQuery()).logout();

                                            Get.toNamed('/Login');
                                          },
                                          child: const Text('Yes',style: TextStyle(
                                              color: Colors.white
                                          ),),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back(); // close the alert dialog
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  );

                                },
                                child: const Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.power,
                                          color: Colors.redAccent,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left:10.0),
                                          child: Text("Logout",style: TextStyle( fontWeight: FontWeight.bold),),
                                        ),

                                      ],
                                    ),
                                    Divider(
                                      height: 20, // Adjust the height as needed
                                      thickness: 0.2, // Adjust the thickness as needed
                                      color: Colors.grey,
                                    ),

                                  ],
                                ),
                              )
                          ),
                        ],
                        offset: const Offset(-30, 90),
                        child:InkWell(

                          child: Ink(

                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(

                                Icons.menu, // Replace with your desired icon
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                    ),
                    Positioned(
                      child: FadeInUp(duration: const Duration(milliseconds: 1600), child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text("Sell", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                        ),
                      )),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeInUp(duration: const Duration(milliseconds: 1800), child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color.fromRGBO(143, 148, 251, 1)),
                          boxShadow: const [
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
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Meter No:",
                                  hintStyle: TextStyle(color: Colors.grey[700])
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(

                              decoration: InputDecoration(

                                border: InputBorder.none,
                                hintText: "Enter Amount",
                                hintStyle: TextStyle(color: Colors.grey[700]),

                                suffixIcon: Padding(

                                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value:selectedCountry,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedCountry=newValue!;
                                        });
                                      },
                                      items:countries.map((country) {
                                        return DropdownMenuItem<String>(
                                          value: country.name,
                                          child: Row(
                                            children: <Widget>[
                                              Text(country.flag),
                                              const SizedBox(width: 5),
                                              Text(country.name),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),

                                labelStyle: const TextStyle(color: Colors.black), // Customize label color
                                //floatingLabelBehavior: FloatingLabelBehavior.always, // Always show the label above the TextField
                              ),
                              onChanged: (text) async{

                                //viewData(text,selectedCountry.toLowerCase());

                                //print(this._data[index]["total_var"]);
                                // print("Text changed to: $text");
                              },
                            ),
                          ),

                        ],
                      ),
                    )),
                    const SizedBox(height: 30,),
                    FadeInUp(duration: const Duration(milliseconds: 1900), child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]
                          )
                      ),
                      child: const Center(
                        child: Text("Purchase", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    )),



                  ],
                ),
              )
            ],
          ),
        )
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






