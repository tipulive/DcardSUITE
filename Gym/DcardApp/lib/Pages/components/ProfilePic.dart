

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dcard/models/Participated.dart';
import 'package:dcard/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Query/CardQuery.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Query/ParticipatedQuery.dart';
import '../../Utilconfig/ConstantClassUtil.dart';
import '../../Utilconfig/HideShowState.dart';
class ProfilePic extends GetxController{
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode?result;
  QRViewController?controller;


  bool cameraValue=false;
  String urLink='${ConstantClassUtil.urlApp}/images/userProfile/';
  bool flashvalue=false;
  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) async{
      print(scanData);
      result=scanData;
      if(result!=null)
        {
          print(result!.code);
          confirmCard(result!.code);
          controller.pauseCamera();
        }

      /*setState((){
        result=scanData;
      });*/
     // await scanMethod();
    });
  }
  confirmCard(qrCode){
    // ${(Get.put(HideShowState()).delivery)[Get.put(HideShowState()).indexCountData]["currentQty"]}
    // (Get.put(StockQuery()).dispatchOrder)[Get.put(HideShowState()).indexCountData]["productCode"];

    String lastFive = "******${qrCode.substring(qrCode.length - 8)}";
    String confirmText="Confirm if it is your Card $lastFive ?";
    Get.dialog(
      AlertDialog(
        title: Text(confirmText, style: TextStyle(fontSize: 14),),
        content: Text('Do you Want To Add This Card to This Package?'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(

              //primary: Colors.grey[300],
              backgroundColor: Colors.red,
              elevation:0,
            ),
            onPressed: () async{
              Get.back(canPop: false);

              //await payment();
                await addTothisPackage(qrCode);

            },
            child: const Text('Yes',style:TextStyle(
                color: Colors.white
            ),),
          ),
          ElevatedButton(
            onPressed: () {

              Get.back(canPop: false); // close the alert dialog
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
   viewMembers() async{
     final response= (await ParticipatedQuery().getAllParticipatePackage(User(uid:(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"] ?? 'none' ))).data;
     if (response!["status"]) {


       print(response["result"]);
       viewUsers(response["result"].cast<Map<String, dynamic>>());
       //viewUsers(users);
     }
     else{
       Get.snackbar("Error", "${response["result"]}",backgroundColor: Color(0xff9a1c55),
           colorText: Color(0xffffffff),
           titleText: Text("Error"),

           icon: Icon(Icons.access_alarm),
           duration: Duration(seconds: 8));
     }
  }
  viewUsers(List<Map<String, dynamic>> users) {

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // scrollable list of users
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: users.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final data = users[index];

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person, color: Colors.blue),
                            title: Text(
                              ConstantClassUtil().capitalize(data["name"]),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text("Name"),
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.phone, color: Colors.green),
                            title: Text(
                              ConstantClassUtil()
                                  .extractAfterUnderscore(data["phoneNumber"]),
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: const Text("Phone"),
                          ),

                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.monetization_on,
                                color: Colors.orange),
                            title: Text(
                              "******${data["cardUid"].substring(data["cardUid"].length - 8)}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text("Card"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text("Close"),
              ),
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Future<void> addTothisPackage(qrCode) async {

    //loader is needed here

    final response = (await ParticipatedQuery().participantInPackage(
      Participated(
        uid: (Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["packUid"] ?? 'none',
        carduid: qrCode,
      ),
      User(
        uid: (Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"] ?? 'none',
      ),
    )).data;
    // your API here
    if (response!["status"]) {
      Get.put(HideShowState()).isCameraHiden(true);
      //Get.close(1);
      Get.snackbar("Success", "${response["result"]}",backgroundColor: Color(0xff9a1c55),
          colorText: Color(0xffffffff),
          titleText: Text("Participate"),

          icon: Icon(Icons.access_alarm),
          duration: Duration(seconds: 5));

    }else{
      String lastFive = "******${qrCode.substring(qrCode.length - 8)}";
      Get.put(HideShowState()).isCameraHiden(true);
      Get.snackbar("Error on This Card $lastFive", "${response["result"]}",backgroundColor: Color(0xff9a1c55),
          colorText: Color(0xffffffff),
          titleText: Text("Error"),

          icon: Icon(Icons.access_alarm),
          duration: Duration(seconds: 8));
    }
  }
  Widget cameraSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
        activeColor: Colors.red,
        activeTrackColor: Colors.red.withValues(alpha:0.4),
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.blueAccent,

        value: cameraValue,
        onChanged:(value)async{
         /* setState((){
            cameraValue=value;

            //print(value);
          });*/
          await controller!.resumeCamera();
        }
    ),
  );
  Widget flashSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
        activeColor: Colors.red,
        activeTrackColor: Colors.red.withValues(alpha:0.4),
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.blueAccent,

        value:flashvalue,
        onChanged:(value)async{
         /* setState((){
            flashvalue=value;

            //print(value);
          });*/
          await controller!.toggleFlash();
        }
    ),
  );

  Widget profile(){

    return Column(

      children: <Widget>[

        SizedBox(
          width: 100,
          height: 100,

          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: '$urLink/${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["photo_url"]??'none'}',
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        SizedBox(height:6.0),

        Text("${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["name"]??'none'}",style:GoogleFonts.pacifico(fontSize: 18,color: Colors.teal,fontWeight:FontWeight.w100),),


        SizedBox(height:3.0),
        //Text("Eric Ford",style: TextStyle(color: Colors.teal,fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                //shape: BoxShape.circle,
                //border: Border.all(color: Colors.black,width: 2)
              ),
              child: Icon(Icons.add_call
                ,size: 15,
                color: Colors.deepPurple,
                ),
            ),
            //SizedBox(width: 1,),
            Text("${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["PhoneNumber"]??'none'}",style: GoogleFonts.robotoCondensed(fontSize: 18,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min, // keeps text+icon close
          children: [
            InkWell(
              onTap: (){
                //viewMembers Assigned
                viewMembers();
              },
                child: Text("${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["packName"]??'none'}",style:GoogleFonts.pacifico(fontSize: 18,color: Colors.blue,fontWeight:FontWeight.w100),)),

            const SizedBox(width: 8), // spacing between text and icon
            IconButton(
              onPressed: () {
                // your QR scanner action here
                Get.put(HideShowState()).isCameraHiden(false);
              },
              icon: const Icon(Icons.qr_code_scanner, size: 24),
            ),
          ],
        ),
        Obx(() {
          if (Get.put(HideShowState()).isCameraVisible.value) {
            return SizedBox.shrink(); // completely remove from tree (no space left)
          }
          return SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                QRView(
                  key: qrkey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cameraSwitch(),
                    const SizedBox(width: 10),
                    flashSwitch(),
                    Image.asset(
                      flashvalue ? 'images/on.png' : 'images/off.png',
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),

      ],

    );
  }


}
