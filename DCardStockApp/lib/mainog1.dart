import 'package:dcard/Pages/ProfilePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wakelock/wakelock.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:dcard/models/Admin.dart';
import 'package:dcard/models/Participated.dart';
import 'package:dcard/models/Promotions.dart';
import 'Query/AdminQuery.dart';

import 'models/User.dart';
import 'Query/UserQuery.dart';


import 'package:dcard/Query/PromotionQuery.dart';
import 'package:dcard/Query/ParticipatedQuery.dart';
import 'package:dcard/Dateconfig/DateClassUtil.dart';

void main() {
  /*this will make apps not going to sleep Mode*/

  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  //i may add  Wakelock.disable(); // to make apps to go on sleep mode
  /*this will make apps not going to sleep Mode*/
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Demo Project'),
    );
  }
}


class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController uidInput=TextEditingController();
  TextEditingController uidInput2=TextEditingController();
  TextEditingController uidInput3=TextEditingController();
  TextEditingController uidInput4=TextEditingController();

  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode?result;
  QRViewController?controller;
  @override
  void reassemble(){
    super.reassemble();
    if(Platform.isAndroid)
    {
      controller!.resumeCamera();
    }else if (Platform.isIOS)
    {
      controller!.pauseCamera();
    }
  }
  @override
  @override
  void hidekeyboard() {

  print("hide keyboard");
  }
  @override
  Widget build(BuildContext context)
  {
    //hidekeyboard();
    UserQuery userQueryData = Get.put(UserQuery());
    AdminQuery adminStatedata=Get.put(AdminQuery());
    PromotionQuery promotionState=Get.put(PromotionQuery());
    ParticipatedQuery participatedState=Get.put(ParticipatedQuery());
    DateClassUtil DateState=Get.put(DateClassUtil());
    //FocusScope.of(context).unfocus();//hide keyboard on screen loading
    return Scaffold(
      body:Column(
        children: [
          Expanded(
              flex: 5,
              child:QRView(key: qrkey,onQRViewCreated: _onQRViewCreated,)

          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(

              child: Center(
                  child:Column(
                    children: [
                      (result!=null)?Text("barcode Type ${describeEnum(result!.format)} Data ${result!.code}"): const Text("Scan Code"),
                      Visibility(
                        visible: true,
                        child: TextField(

                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Enter fees',
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            suffixIcon:  GestureDetector(
                              child: Icon(Icons.settings),
                              onTap: () {
                                print("open change promotion");
                                // Perform some action when the icon is pressed
                              },
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: ()async =>{
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
                          child: const Text("Participate")
                      ),
                      TextButton(
                          onPressed: () async=>{
                          await controller!.toggleFlash(),
                           // Wakelock.enable()
                          },
                          child: const Text("Enable")
                      ),
                      TextButton(
                          onPressed: () async=>{
                            await controller!.resumeCamera(),
                            // Wakelock.enable()
                          },
                          child: const Text("resume")
                      ),


                    ],
                  )

              ),
            ),
          ),
        ],
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed:()async =>{
          Get.to(ProfilePage()),
        },
        tooltip: 'Increment',
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage("images/profile.jpg",
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

  }

  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) {
      setState((){
        result=scanData;
      });
    });
  }
  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }




}
