import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Query/CardQuery.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
class ProfilePic extends GetxController{
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');


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
      ],
    );
  }
}
