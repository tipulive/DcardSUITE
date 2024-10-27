import 'dart:convert';
import 'dart:io';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Query/AdminQuery.dart';

import '../Query/StockQuery.dart';
import '../Utilconfig/HideShowState.dart';
import '../models/Admin.dart';
import '../Utilconfig/ConstantClassUtil.dart';
import 'package:animate_do/animate_do.dart';

import '../models/Participated.dart';
import '../models/Promotions.dart';
import 'SetSalePage.dart';

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
  TextEditingController uidInput2=TextEditingController(text:"");
  TextEditingController uidInput3=TextEditingController();
  AdminQuery adminStatedata=Get.put(AdminQuery());
  bool showOveray=false;
  bool isValid=false;
  String tokenNumber="";

  final List<CountryModel> countries = [
    CountryModel(name: 'USD',fName:'USA', flag: '🇺🇸'),
    CountryModel(name: 'FC',fName:'DR Congo',flag: '🇨🇩'),
    //CountryModel(name: 'GBP',fName:'United Kingdom', flag: '🇬🇧'),
   // CountryModel(name: 'FRW', fName:'Rwanda',flag: '🇷🇼'), // Rwanda

    // Add more countries as needed
  ];

  String? selectedCountry;


  @override
  void initState() {
    super.initState();
    // Set the default selected country to "United States"
    _initBluetooth();
    selectedCountry = 'USD';

  }

  //printer//

  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;
  bool _connected = false;

  // Initialize Bluetooth without enabling it explicitly
  void _initBluetooth() async {
    try {
      // Get bonded devices directly without checking if Bluetooth is enabled
      List<BluetoothDevice> devices = await printer.getBondedDevices();
      setState(() {
        _devices = devices;

      });
      print("test keb ${_devices[0].name}");
      _connectToPrinter(_devices[0]);
    } catch (e) {
      print('Error initializing Bluetooth: $e');
    }
  }

  // Connect to a Bluetooth printer
  void _connectToPrinter(BluetoothDevice device) async {
    if (_connected) {
      print("already connected");
    } else {
      try {
        await printer.connect(device);
        print("connected");
        setState(() {
          _connected = true;
        });
      } catch (e) {
        print('Error connecting to printer: $e');
        setState(() {
          _connected = true;
        });
      }
    }
  }
  void _printReceipt(curDate,curTime,name,token2,uid,cashPower,amount,currencyD) async {
    if (_connected) {
      // Store name and header
      // Barcode for receipt validation (EAN13)


      printer.printCustom("Cash P/No:${cashPower}", 3, 1);  // Bold, Centered
      printer.printNewLine();
      printer.printCustom("Thank you for shopping with us!", 1, 1);  // Normal, Centered
      printer.printNewLine();

      // Customer and purchase details
      printer.printLeftRight("Date:", curDate, 0);
      printer.printLeftRight("Time:", curTime, 0);
      printer.printLeftRight("Cashier:", name, 0);

      printer.printNewLine();

      // Purchase items
      printer.printCustom("Token", 1, 1);
      printer.printNewLine();
      printer.printCustom(token2, 1, 1);

      printer.printNewLine();

      // Total cost
      printer.printLeftRight("Total:", "${currencyD} ${amount}", 1);
      printer.printNewLine();

      // Mobile money payment info
      printer.printCustom("Payment via POS", 1, 1);
      printer.printCustom("Transaction ID: ${uid}", 0, 1);
      printer.printNewLine();

      // Barcode for receipt validation (EAN13)
      //printer.printQRcode("123456789012", 300, 300, 1);  // Type: EAN13, Height: 100
      printer.printQRcode("${uid}", 250, 250,1);
      printer.printNewLine();
      printer.printCustom("Powered by Ericsoft!", 1, 1);
      printer.printNewLine();

      // Add powered by line
      printer.printCustom("Powered by Ericsoft", 0, 1);  // Normal, Centered
      printer.printNewLine();
      printer.paperCut();

      // Optionally disconnect after printing
      await printer.disconnect();
      setState(() {
        _connected = false;
      });
    }
  }
  void _printSample() async {
    if (_connected) {
      // Store name and header
      // Barcode for receipt validation (EAN13)


      printer.printCustom("Your Local Store", 3, 1);  // Bold, Centered
      printer.printNewLine();
      printer.printCustom("Thank you for shopping with us!", 1, 1);  // Normal, Centered
      printer.printNewLine();

      // Customer and purchase details
      printer.printLeftRight("Date:", "2024-09-22", 0);
      printer.printLeftRight("Time:", "13:30", 0);
      printer.printLeftRight("Cashier:", "Eric Ford", 0);
      printer.printNewLine();

      // Purchase items
      printer.printCustom("Item Description", 1, 0);
      printer.printLeftRight("Sugar (1kg)", "RWF 1000", 0);
      printer.printLeftRight("Milk (500ml)", "RWF 500", 0);
      printer.printLeftRight("Bread (1 loaf)", "RWF 700", 0);
      printer.printLeftRight("Sugar (1kg)", "RWF 1000", 0);
      printer.printLeftRight("Milk (500ml)", "RWF 500", 0);
      printer.printLeftRight("Bread (1 loaf)", "RWF 700", 0);

      printer.printNewLine();

      // Total cost
      printer.printLeftRight("Total:", "RWF 2200", 1);
      printer.printNewLine();

      // Mobile money payment info
      printer.printCustom("Payment via MTN Mobile Money", 1, 1);
      printer.printCustom("Transaction ID: 1234567890", 0, 1);
      printer.printNewLine();

      // Barcode for receipt validation (EAN13)
      //printer.printQRcode("123456789012", 300, 300, 1);  // Type: EAN13, Height: 100
      printer.printQRcode("123456789012", 250, 250,1);
      printer.printNewLine();
      printer.printCustom("Powered by Ericsoft!", 1, 1);
      printer.printNewLine();

      // Add powered by line
      printer.printCustom("Powered by Ericsoft", 0, 1);  // Normal, Centered
      printer.printNewLine();
      printer.paperCut();

      // Optionally disconnect after printing
      await printer.disconnect();
      setState(() {
        _connected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:Stack(
            children: [
              Column(

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


                        //Menu top
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
                                      Get.to(() =>const SetSalePage());


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

                  Text(tokenNumber,style: TextStyle(color:Colors.blue),),
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
                                  controller: uidInput,
                                  keyboardType: TextInputType.number,
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
                                  controller: uidInput2,
                                  keyboardType: TextInputType.number,
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
                        InkWell(
                          onTap: () async{
                            // print("${inputDataDept.text} ${(Get.put(StockQuery())).orderSum } ${Get.put(StockQuery().order["resultData"][0]["uid"])}");
                            (Get.put(StockQuery()).updateHideLoader(false));

                            try {
                              var resultData=(await StockQuery().buyUtility(Participated(uid:"Nyota_1672353378"
                                  ,uidUser:"${Get.put(AdminQuery()).obj["result"][0]["uid"]}",subscriber:"${(Get.put(StockQuery()).order["resultData"][0]["uid"])}",inputData:uidInput2.text,ref:uidInput.text,currency: selectedCountry ),Promotions(
                                  token:"${(Get.put(StockQuery())).orderSum }",reach:"1200",gain:"350",uid:"PointSales1"
                              ))).data;
                              if(resultData["status"])
                              {
                                // print(resultData);



                                num totalVal=0;

                                (Get.put(StockQuery()).updateSumOrder(totalVal));
                                _printReceipt(resultData["curDay"],resultData["curTime"],resultData["name"],resultData["token2"],resultData["token"],uidInput.text,uidInput2.text,selectedCountry);
                                (Get.put(StockQuery()).updateHideLoader(true));
                                setState(() {
                                  tokenNumber="Token:${resultData["token2"]}";
                                  /*showOver=false;
                        cartData.clear();
                        //(Get.put(StockQuery()).updateOrder(orderVal));
                        (Get.put(StockQuery()).updateDeptOrder(0));
                        inputDataDept.text="";*/

                                  // dataSearch.clear();

                                });
                                //(Get.put(StockQuery()).updateHidePickClick(true));
                                //pickDefaultUser(true,true);
                              }
                              else{

                                (Get.put(StockQuery()).updateHideLoader(true));
                              }
                            } catch (e) {
                              (Get.put(StockQuery()).updateHideLoader(true));
                            }

                          },
                          child: FadeInUp(duration: const Duration(milliseconds: 1900), child: Container(
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
                        ),



                      ],
                    ),
                  ),

                ],
              ),

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






