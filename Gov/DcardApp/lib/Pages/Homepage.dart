

import 'dart:convert';
import 'package:dcard/Query/CardQuery.dart';
import 'package:dcard/Query/TopupQuery.dart';
import 'package:dcard/models/CardModel.dart';
import 'package:dcard/models/Topups.dart';

import '../Pages/ProfilePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:wakelock/wakelock.dart';
import 'package:get/get.dart';




import 'package:dcard/models/Participated.dart';
import 'package:dcard/models/Promotions.dart';
import '../Query/AdminQuery.dart';
import '../Pages/components/BottomNavigator/HomeNavigator.dart';


import 'package:cool_alert/cool_alert.dart';


import 'package:dcard/Query/PromotionQuery.dart';
import '../Query/ParticipatedQuery.dart';
import '../Utilconfig/HideShowState.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});



  @override
  State<Homepage> createState() => _HomepageState();


}
class _HomepageState extends State<Homepage> {


  PromotionQuery promotionState=Get.put(PromotionQuery());
  AdminQuery adminStatedata=Get.put(AdminQuery());

  TextEditingController PromoName=TextEditingController();
  TextEditingController uidInput=TextEditingController(text:'nopromotion');//uid promo
  TextEditingController uidInput2=TextEditingController(text:'kebineericMuna_1668935593');//userid of user that will be available after qr scan
  TextEditingController uidInput3=TextEditingController();//input data to submit
  TextEditingController uidInput4=TextEditingController();
  TextEditingController uidInput5=TextEditingController(text:"0");
  TextEditingController uidInput6=TextEditingController();
  TextEditingController uidInput7=TextEditingController();
  TextEditingController uidInput8=TextEditingController();
  TextEditingController ClientName=TextEditingController();
  String PromoMsg="nopromotion";
  String subscriberText="DOROTHELTD";
  String startedDate="none";
  String endedDate="none";
  String subscriberPromo="none";
  bool showprofile=false;
  bool showOveray=false;
  bool IsSubmitted=false;
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode?result;
  QRViewController?controller;
  var _groupVal ="male";

  bool optionVal=true;
  List items=["male","female","others","Keb2"];

  bool Cameravalue=false;
  bool Flashvalue=false;
  var ResultDatas;
  late Map<String, dynamic> passData;


  @override

  @override
  Widget build(BuildContext context)
  {


    /*void reassemble(){
      super.reassemble();
      //controller!.resumeCamera();
      if(Platform.isAndroid)
      {
        controller!.resumeCamera();

      }else if (Platform.isIOS)
      {
        controller!.pauseCamera();
      }
    }*/

    //hidekeyboard();
    //UserQuery userQueryData = Get.put(UserQuery());



    // ParticipatedQuery participatedState=Get.put(ParticipatedQuery());

    //Map<String,dynamic> Promo_data=promotionState.obj["resultData"]??promotionState.obj;

    //FocusScope.of(context).unfocus();//hide keyboard on screen loadin
    return Scaffold(
      body:Stack(
        children: [
          Column(
            children: [
              Obx(
                    () =>Visibility(
                  visible:Get.put(HideShowState()).isCameraVisible.value,
                  child: Expanded(
                      flex: 5,
                      child:Stack(
                        alignment:Alignment.bottomCenter,
                        children: [
                          QRView(key: qrkey,onQRViewCreated: _onQRViewCreated,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  CameraSwitch(),
                                  //SizedBox(width: 10.0,),

                                  // SizedBox(width: 10.0,),
                                  FlashSwitch(),
                                  Image.asset(
                                    Flashvalue ? 'images/on.png' : 'images/off.png',
                                    height: 30,
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      )

                  ),

                ),
              ),

              Visibility(
                visible: true,
                child: Expanded(
                  flex: 2,
                  child: SingleChildScrollView(

                    child: Center(
                        child:Column(
                          children: [

                            (result!=null)?Text("barcode Type ${describeEnum(result!.format)} Data ${result!.code}"): const Text("Scan Code"),








                          ],
                        )

                    ),
                  ),
                ),
              ),
            ],
          ),
          if(showOveray)
            Positioned.fill(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white70,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),

        ],
      ) ,
      bottomNavigationBar:HomeNavigator(),

      // This trailing comma makes auto-formatting nicer for build methods.

    );

  }
  Widget wigsubmitParticipate(){

    return
      (passData["expiredIn"]=="yes")?Container(
        child:(passData["statusValid"]!="0")?Column(
          children: [
            Container(

              child: TextField(
                controller: uidInput6,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter your Weight',
                  hintText: 'Enter your Weight',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                  ),

                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),

                  ),
                ),
              ),

            ),
            SizedBox(height:10.0,),

            FloatingActionButton.extended(
              label: Text('Participate'), // <-- Text
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              icon: Icon( // <-- Icon
                Icons.thumb_up,
                size: 24.0,
              ),
              onPressed: ()async =>{
                submitParticipate()
              },
            ),
          ],
        ):Visibility(
            visible: false,
            child: Text("")),
      ):Visibility(
          visible: false,
          child: Text(""));


    //
  }
submitParticipate() async{
  Get.put(HideShowState()).isVisible(true);

  /* setState(() {


                        showOveray=true;
                      }),*/

  if(uidInput5.text=="0")
  {

    await Get.put(ParticipatedQuery()).ParticipateEventOnline(Participated(uid:uidInput.text,uidUser:uidInput2.text,inputData:uidInput3.text,weight:uidInput6.text,inputAction:uidInput7.text),Promotions(reach:uidInput4.text,gain:uidInput5.text,promo_msg:PromoMsg));
    if((Get.put(ParticipatedQuery()).obj)["resultData"]["status"])
    {
      /*setState(() {

                              showOveray=false;
                            }),*/
      Get.put(HideShowState()).isVisible(false);
      uidInput3.text="";
      Get.close(1);
      controller!.resumeCamera();

      Get.snackbar("Success", "Data Submitted",backgroundColor: Color(0xff9a1c55),
          colorText: Color(0xffffffff),
          titleText: Text("Participate"),

          icon: Icon(Icons.access_alarm),
          duration: Duration(seconds: 5));




    }else{
      Get.put(HideShowState()).isVisible(false);
      Get.close(1);
      controller!.resumeCamera();

      Get.snackbar("Error", "Something Wrong Contact System Admin",backgroundColor: Color(0xff9a1c55),
          colorText: Color(0xffffffff),
          titleText: Text("Participate"),

          icon: Icon(Icons.access_alarm),
          duration: Duration(seconds: 5));
    }


  }
  else{
    //
    await Get.put(ParticipatedQuery()).ParticipateEventOnline(Participated(uid:uidInput.text,uidUser:uidInput2.text,inputData:uidInput3.text,weight:uidInput6.text,inputAction:uidInput7.text),Promotions(reach:uidInput4.text,gain:uidInput5.text,promo_msg:PromoMsg));
    //print((Get.put(ParticipatedQuery()).obj)),
    if((Get.put(ParticipatedQuery()).obj)["resultData"]["reach"]!=null)
    {
      /* setState(() {


                            showOveray=false;
                          }),*/
      Get.put(HideShowState()).isVisible(false);
      uidInput3.text="";
      Get.close(1);
      controller!.resumeCamera();
      CoolAlert.show(
        context: context,
        backgroundColor:Color(0xff940e4b),
        type: CoolAlertType.success,
        title:"Congratulation !!!",
        text: "${subscriberPromo!=subscriberText?'You Reach ${(Get.put(ParticipatedQuery()).obj)["resultData"]["reach"]} and':''} You win ${(Get.put(ParticipatedQuery()).obj)["resultData"]["gain"]} !",

      );



      //Get.back(),

    }else{
      if((Get.put(ParticipatedQuery()).obj)["resultData"]["status"])
      {
        /*setState(() {

                              showOveray=false;
                            }),*/
        Get.put(HideShowState()).isVisible(false);
        uidInput3.text="";
        Get.close(1);
        controller!.resumeCamera();

        Get.snackbar("Success", "Data Submitted",backgroundColor: Color(0xff9a1c55),
            colorText: Color(0xffffffff),
            titleText: Text("Participate"),

            icon: Icon(Icons.access_alarm),
            duration: Duration(seconds: 5));




      };


      //print((Get.put(ParticipatedQuery()).obj)),
    };
    //
    //
  }
}
  ScanPopup(encodedData){

    Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height:800,

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(

                          height: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: ListView(
                            children: [

                              SingleChildScrollView(child: MyTextWidget(encodedData))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                HomeNavigator(),

                Positioned(
                  right: 15.0,
                  bottom:70,
                  child: FloatingActionButton(
                    onPressed:()async {
                      Get.put(HideShowState()).isVisible(true);
                      ResultDatas=(await Get.put(TopupQuery()).GetBalance(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}"))).data;
                      if(ResultDatas["status"])
                      {
                        await Get.put(TopupQuery()).updateTopupState(ResultDatas);
                        Get.put(HideShowState()).isVisible(false);
                        Get.to(() => ProfilePage());
                      }
                      else{

                        await Get.put(TopupQuery()).updateTopupState(ResultDatas);
                        Get.put(HideShowState()).isVisible(false);
                        Get.to(() => ProfilePage());
                      }


                    },
                    tooltip: 'Increment',
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("images/profile.jpg",
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                    child:  Obx(
                          () =>Visibility(
                        visible: Get.put(HideShowState()).isVisible.value,
                        child: Container(
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    )
                ),

                Positioned(
                    top: 0,

                    child:  Obx(
                          () =>Visibility(
                        visible: Get.put(HideShowState()).isVisible.value,
                        child: CircularProgressIndicator(),
                      ),
                    )
                ),
              ],
            );
        },
      ),
    ).whenComplete(() {
      controller!.resumeCamera();
      //do whatever you want after closing the bottom sheet
    });
  }
  Widget MyTextWidget(String encodedData){

      passData = jsonDecode(utf8.decode(base64Decode(encodedData)));


    //passData=utf8.decode(base64Decode(passData));
    //print(passData);

    if (promotionState.obj["id"] == 1 ||
        promotionState.obj["resultData"] == null ||
        promotionState.obj["resultData"]["result"] == null ||
        promotionState.obj["resultData"]["result"].isEmpty) {
      uidInput4.text="100";

        uidInput2.text=passData["uid"];


      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            ScanUser(passData),

            Visibility(
              visible:false,
              child: TextField(
                controller: uidInput,
                //obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                  border: OutlineInputBorder(),
                  labelText: 'Uid of Promotion ',
                  hintText: 'Uid of Promotion',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),

                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Visibility(
              visible:false,
              child: TextField(
                controller: uidInput2,
                //obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                  border: OutlineInputBorder(),
                  labelText: 'UserID',
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),

                ),
              ),
            ),
            //SizedBox(height: 10.0,),
            Visibility(
              visible:false,
              child: TextField(
                controller: ClientName,
                enabled: false,
                //obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),

                ),
              ),
            ),
            SizedBox(height: 10.0,),
        wigsubmitParticipate(),
            //Center(child: Text("Something Wrong Contact Sytem Admin")),
        // Center(child: CircularProgressIndicator()),
          ],
        ),
      );
    }
    //if((promotionState.obj["id"])==1) return Center(child: CircularProgressIndicator());
    PromoName.text="${(promotionState.obj["resultData"]["result"][0]["promoName"])}";
    PromoMsg=(promotionState.obj["resultData"]["result"][0]["promo_msg"]);

    startedDate="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][0]["started_date"]}";
    endedDate="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][0]["ended_date"]}";
    subscriberPromo="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][0]["subscriber"]}";
    PromoMsg=(subscriberPromo!=subscriberText)?PromoMsg:"From $startedDate To $endedDate";

    uidInput.text="${(promotionState.obj["resultData"]["result"][0]["uid"])}";
   // print((promotionState.obj["resultData"]));
    uidInput3.text="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][0]["inputData"]}";
    uidInput4.text="${(promotionState.obj["resultData"]["result"][0]["reach"])}";
    uidInput5.text="${(promotionState.obj["resultData"]["result"][0]["gain"])}";

    uidInput2.text=passData["uid"];
    ClientName.text=passData["name"];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
        
          children: [
            Column(

              children: [

                ScanUser(passData),
                SizedBox(height:10.0,),
                TextField(
                  controller:PromoName,
                 // enabled: false,
                  readOnly: true,
                  //obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                    border: OutlineInputBorder(),
                    labelText: 'Promotion Name',
                    hintText: 'Promotion Name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    isDense: false,
                    suffixIcon:  GestureDetector(
                      child: Icon(Icons.settings),
                      onTap: () {
                        choosePromo();


                        // Perform some action when the icon is pressed
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible:false,
                  child: TextField(
                    controller: uidInput,
                    //obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                      border: OutlineInputBorder(),
                      labelText: 'Uid of Promotion ',
                      hintText: 'Uid of Promotion',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Visibility(
                  visible:false,
                  child: TextField(
                    controller: uidInput2,
                    //obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                      border: OutlineInputBorder(),
                      labelText: 'UserID',
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),

                    ),
                  ),
                ),
                //SizedBox(height: 10.0,),
                Visibility(
                  visible:false,
                  child: TextField(
                    controller: ClientName,
                    enabled: false,
                    //obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),

                    ),
                  ),
                ),



                Visibility(
                  visible: false,
                  child: TextField(
                    controller: uidInput3,
                    minLines: 2, // Minimum lines to show even if user hasn't typed anything
                    maxLines: null,
                    //obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                      border: OutlineInputBorder(),
                      // labelText: 'Enter ${Promo_data["result"][0]["promo_msg"]}',${promotionState.obj["resultData"]["result"][0]["uid"]}

                      //labelText: '${PromoMsg}',

                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),

                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: TextField(
                    controller: uidInput8,
                    enabled: false,

                    minLines: 2, // Minimum lines to show even if user hasn't typed anything
                    maxLines: null,
                    //obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                      border: OutlineInputBorder(),
                      // labelText: 'Enter ${Promo_data["result"][0]["promo_msg"]}',${promotionState.obj["resultData"]["result"][0]["uid"]}
                      hintText: PromoMsg,
                      //labelText: '${PromoMsg}',

                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      isDense: false,
                      suffixIcon:  GestureDetector(
                        child: Icon(Icons.settings),
                        onTap: () {
                          choosePromo();


                          // Perform some action when the icon is pressed
                        },
                      ),

                    ),
                  ),
                ),

                Visibility(
                  visible:false,
                  child: TextField(
                    controller: uidInput4,
                    //obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                      border: OutlineInputBorder(),
                      labelText: 'reach',
                      hintText: 'reache',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),

                    ),
                  ),
                ),

                Visibility(
                  visible:false,
                  child: TextField(
                    controller: uidInput5,
                    //obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                      border: OutlineInputBorder(),
                      labelText: 'gain',
                      hintText: 'gain',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),

                    ),
                  ),
                ),
                         wigsubmitParticipate()



              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget ScanUser(passData){
    return
      Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text("Recently In:${passData["recentIn"]} ")),
              Text(passData["name"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 2),
              Center(child: Text("Weight:${passData["weight"]} Kg")),
              (passData["statusValid"]=="0")?
              Center(
                child: Text(
                  "Please Pay for New Subscription!",
                  style: TextStyle(color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ):
              Center(
                child: Text(
                  "Valid: ${passData["statusValid"]} days Left",
                  style: TextStyle(
                    color: int.parse(passData["statusValid"]) <= 5 ? Colors.red:Colors.green,
                    fontSize:int.parse(passData["statusValid"]) <= 5 ?18:16,
                  ),
                ),
              ),
              (passData["statusValid"]!="0")?Center(child: Text("Type:${passData["packType"]}")):
              Visibility(
                  visible: false,
                  child: Text("")),
              Text(PromoMsg),

              (passData["expiredIn"]=="yes")?Visibility(
                visible: false,
                  child: Text("submit again")):Text(
                "${passData["name"] } Is In Gym Mode",
                style: TextStyle(color: Colors.blue,
                  fontSize:16,
                ),
              ),

            ],
          ),
        ),
      );
  }
choosePromo(){
  _groupVal=uidInput.text;
  Get.dialog(
    AlertDialog(
      title: Center(child: const Text('Choose Promotion')),
      content:SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget> [


            if(((Get.put(PromotionQuery()).obj)["id"])==1)...[Center(child: CircularProgressIndicator())],

            for(var i=0;i<(Get.put(PromotionQuery()).obj)["resultData"]["result"].length;i++)
              RadioListTile(
                title: Text("${i==null?"none":(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["promoName"]}"),
                value: "${i==null?"none":(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["uid"]}",
                //value:"${items[i]}",

                groupValue:_groupVal,
                onChanged: (value){

                  _groupVal=value.toString();
                  print(_groupVal);
                  //value="male";

                  uidInput.text=_groupVal;
                  PromoName.text="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["promoName"]}";
                  PromoMsg="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["promo_msg"]}";
                  startedDate="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["started_date"]}";
                  endedDate="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["ended_date"]}";
                  subscriberPromo="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["subscriber"]}";

                  uidInput3.text="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["inputData"]}";
                  uidInput4.text="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["reach"]}";
                  uidInput5.text="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["gain"]}";

                  setState(() {
                    PromoMsg=(subscriberPromo!=subscriberText)?PromoMsg:"From $startedDate To $endedDate";

                  });





                  //print(_groupVal);
                  //Get.back(result: value);
                  Get.back();
                },
              ),

          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}
  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) async{
      setState((){
        result=scanData;
      });
      await scanMethod();
    });
  }
  scanMethod() async{

    // uidInput2.text="${result!.code}";
    //uidInput2.text="${(await Get.put(CardQuery()).GetDetailCardOnline(CardModel(uid:'${result!.code}')))["UserDetail"]["uid"]}";
    if(result!=null)
    {

      controller!.pauseCamera();
      setState(() {
        showOveray=true;
      });
      try {


        // controller!.pauseCamera();
        //controller!.pauseCamera();
        var ResultData=(await Get.put(CardQuery()).GetDetailCardOnline(CardModel(uid:'${result!.code}'))).data;
        if(ResultData["status"])
        {
          setState(() {
            showOveray=false;
          });
          await promotionState.getAllPromotionEventOnline();
          //print(ResultData["UserDetail"]["uid"]);
          String encodedData = base64Encode(utf8.encode(jsonEncode(ResultData["UserDetail"])));
          ScanPopup(encodedData);
          (await Get.put(CardQuery()).updateCardState(ResultData));
        }
        else{
          controller!.pauseCamera();
          setState(() {
            showOveray=false;
          });
          CoolAlert.show(
            context: context,
            backgroundColor:Color(0xff940e4b),
            type: CoolAlertType.error,
            title:"Error !!!",
            text: "This Card is not exist",

          ).then((value) {
            // Event to trigger when the alert is dismissed
            controller!.resumeCamera();
          });
          //uidInput2.text="${ResultData["status"]}";
        }

      } catch (e) {
        setState(() {
          showOveray=false;
        });
        //return false;
        //print(e);
      }

    }
    else{

      setState(() {
        showOveray=false;
      });
      uidInput2.text="test";
    }



  }
  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  Widget CameraSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
        activeColor: Colors.red,
        activeTrackColor: Colors.red.withOpacity(0.4),
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.blueAccent,

        value: Cameravalue,
        onChanged:(value)async{
          setState((){
            Cameravalue=value;

            //print(value);
          });
          await controller!.resumeCamera();
        }
    ),
  );
  Widget FlashSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
        activeColor: Colors.red,
        activeTrackColor: Colors.red.withOpacity(0.4),
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.blueAccent,

        value:Flashvalue,
        onChanged:(value)async{
          setState((){
            Flashvalue=value;

            //print(value);
          });
          await controller!.toggleFlash();
        }
    ),
  );

  @override
  void initState()
  {
    super.initState();
    //getapi();
    setState(() {
      showOveray=false;
    });
  }

//Method

//method
}


