import 'package:dcard/Pages/ParticipateHistPage.dart';
import 'package:dcard/models/Participated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Query/CardQuery.dart';

import '../../Query/ParticipatedQuery.dart';

class ActiveComp extends StatelessWidget {
  const ActiveComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView(


      children: [

        profile(),
        const SizedBox(height: 6.0,),
        divLine(),
        for(var i=0;i<(Get.put(ParticipatedQuery()).active)["resultData"]["result"].length;i++)
          ...[

                 detailsProfile("EventID",Icons.account_balance_wallet,"${(Get.put(ParticipatedQuery()).active)["resultData"]["result"][i]["uid"]}",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff),
                 const SizedBox(height:5,),

          ]




      ],
    );
  }

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

        //Text("${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["name"]??'none'}",style:GoogleFonts.pacifico(fontSize: 18,color: Colors.teal,fontWeight:FontWeight.w100),),
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
              child: Icon(Icons.phone
                ,size: 18,
                color: Colors.black,),
            ),
            SizedBox(width: 1,),
            // Text("${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["PhoneNumber"]??'none'}",style: GoogleFonts.robotoCondensed(fontSize: 18,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
          ],
        ),
      ],
    );
  }
}
Widget divLine(){
  return Container(
    margin: const EdgeInsets.all(8),
    child: Row(

      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(


                constraints: const BoxConstraints(maxWidth: 200,maxHeight: 5),
                //color: Color.fromRGBO(13,44,64, 0.4),
                color: Colors.white70
            ),
          ),
        ),
        const SizedBox(width: 100,),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(


                constraints: const BoxConstraints(maxWidth: 200,maxHeight: 5),
                //color: Color.fromRGBO(13,44,64, 0.4),
                color: Colors.white70
            ),
          ),
        )
      ],
    ),
  );
}

Widget detailsProfile(IconText,icon,IconDescr,listBackground,IconrightText,iconright,IconDescrRight,listBackgroundRight){


  return ClipRRect(
    //borderRadius: BorderRadius.circular(32),
    child: Container(
      padding: EdgeInsets.all(8),
      //margin: const EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(8,0,8,0),
      width: 400,
      height: 50,
      //color:Color(0xffffffff),
      color:Color(listBackground),

      child: Row(

        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(

              shape: BoxShape.circle,
              border: Border.all(color: Colors.yellow,width: 1.5),



            ),
            child: Icon(
              icon,color:
            Colors.amber,size: 22,),

          ),
          SizedBox(width:3,),
          Text("${IconText}:",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
          SizedBox(width:5,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 3.9),
              child: Text("${IconDescr}",style:GoogleFonts.pacifico(fontSize: 15)),
            ),
          ),

          Expanded(//right
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(

                  width: 30,
                  height: 30,

                  child:
                  GestureDetector(
                      onTap: () async{
                        // This function will be called when the icon is tapped.
                        // myfunct();
                        //print(IconText);
                       // (await Get.put(ParticipatedQuery()).getParticipateHistEventOnline(Participated(uid:"${IconDescr}",uidUser:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));

                        Get.to(() =>ParticipateHistPage());
                      },
                      child: Icon(iconright,color:
                      Colors.teal,size: 22,)
                  )





                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}


