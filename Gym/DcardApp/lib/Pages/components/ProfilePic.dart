import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Query/CardQuery.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Utilconfig/HideShowState.dart';
class ProfilePic extends GetxController{
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode?result;
  QRViewController?controller;


  bool cameraValue=false;

  bool flashvalue=false;
  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) async{
      /*setState((){
        result=scanData;
      });*/
     // await scanMethod();
    });
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
          child: CircleAvatar(
            backgroundImage: AssetImage("images/profile.jpg"),
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
            Text("${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["packName"]??'none'}",style:GoogleFonts.pacifico(fontSize: 18,color: Colors.blue,fontWeight:FontWeight.w100),),

            const SizedBox(width: 8), // spacing between text and icon
            IconButton(
              onPressed: () {
                // your QR scanner action here

              },
              icon: const Icon(Icons.qr_code_scanner, size: 24),
            ),
          ],
        ),
        Container(
          height: 200,
          width: 200,
          child:     Obx(
                () =>Visibility(
              visible:Get.put(HideShowState()).isCameraVisible.value,
              child: Expanded(
                  flex: 2,
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

                              cameraSwitch(),
                              //SizedBox(width: 10.0,),

                              // SizedBox(width: 10.0,),
                              flashSwitch(),
                              Image.asset(
                                flashvalue ? 'images/on.png' : 'images/off.png',
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
        )
      ],

    );
  }
}
