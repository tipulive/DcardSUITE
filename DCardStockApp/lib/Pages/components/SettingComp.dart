


import 'package:dcard/Pages/SetEditCardNoPage.dart';
import 'package:dcard/Pages/SetStockPage.dart';
import 'package:dcard/Pages/SetWithdrawBonusPage.dart';
import 'package:dcard/Query/AdminQuery.dart';
import 'package:dcard/Query/TopupQuery.dart';
import 'package:dcard/Utilconfig/HideShowState.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../SetPartHistPage.dart';
import '../SetPartPage.dart';
import '../SetQuickBoHistPage.dart';
import '../SetWithdrawBalancePage.dart';



class SettingComp extends StatefulWidget {
  const SettingComp({Key? key}) : super(key: key);

  @override
  State<SettingComp> createState() => _SettingCompState();
}

class _SettingCompState extends State<SettingComp> {

  bool showOveray=false;
  var balance="0";
  var bonus="0";


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(


          children: [

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Get.put(AdminQuery()).obj["result"][0]["name"],
                  style:GoogleFonts.bebasNeue(fontSize:20),
                ),
              ),
            ),

            divLine(),
            GestureDetector(
                onTap: (){
                  viewStock();
                },
                child: detailsProfile("Stocks",Icons.calendar_month_outlined,"",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,viewStock)),//Last Time Purchase
            const SizedBox(height:5,),

            GestureDetector(
                onTap: (){
                  partHistfunc();
                },
                child: detailsProfile("Participate History",Icons.calendar_month_outlined,"",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,partHistfunc)),//Last Time Purchase
            const SizedBox(height:5,),

            GestureDetector(
                onTap: (){
                  partfunc();
                },
                child: detailsProfile("Participate",Icons.calendar_month_outlined,"",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,partfunc)),//Last Time Purchase
            const SizedBox(height:5,),
            GestureDetector(
                onTap: (){
                  quickBoHistfunc();
                },
                child: detailsProfile("QuickBonus",Icons.paid,"",0xbfebf1ef,"textright",Icons.arrow_forward,"200\$",0xffffffff,quickBoHistfunc)),
            const SizedBox(height:5,),

            GestureDetector(
                onTap: (){
                  editCardfunc();
                },
                child: detailsProfile("Edit Card",Icons.account_balance,"",0xbfebf1ef,"textright",Icons.arrow_forward,"200\$",0xffffffff,editCardfunc)),

            const SizedBox(height:5,),
            GestureDetector(
              onTap: (){
                withdrawBalanceFunc();
              },
                child: detailsProfile('WithDraw Balance',Icons.payments_rounded,"$balance\$",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,withdrawBalanceFunc)),
            const SizedBox(height:5,),
            GestureDetector(
                onTap: (){
                  withdrawBonusFunc();
                },
                child: detailsProfile("Bonus History",Icons.redeem,"$bonus\$",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,withdrawBonusFunc)),
            const SizedBox(height:5,),
            GestureDetector(
                onTap: () {
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
                          child: const Text('Yes'),
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
                child: detailsProfile("Logout",Icons.account_balance,"",0xbfebf1ef,"textright",Icons.power,"200\$",0xffffffff,logout)),








          ],
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
    );
  }


  void initState()
  {
    super.initState();
    //getapi();
    scrolldata();

  }


  @override
  void dispose() {

    super.dispose();
  }

  scrolldata()async
  {
    if(showOveray) return;
    showOveray=true;

    var resul=(await TopupQuery().getCompanyRecord()).data;

    if(resul["status"])
    {
      setState(() {
        showOveray=false;
        balance=resul["result"][0]["balance"];
        bonus=resul["result"][0]["bonus"];


      });
    }

    else{

      setState(() {
        showOveray=false;
        balance="0";
        bonus="0";


      });
    }

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

Widget detailsProfile(iconText,icon,iconDescr,listBackground,iconrightText,iconright,iconDescrRight,listBackgroundRight,Function myfunct){


  return ClipRRect(
    //borderRadius: BorderRadius.circular(32),
    child: Container(
      padding: const EdgeInsets.all(8),
      //margin: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(8,0,8,0),
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
          const SizedBox(width:3,),
          Text(iconText+":",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
          const SizedBox(width:5,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 3.9),
              child: Text(iconDescr,style:GoogleFonts.pacifico(fontSize: 15)),
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
                        onTap: () {
                          // This function will be called when the icon is tapped.
                          myfunct();
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

viewStock() async{
  //(await Get.put(TopupQuery()).GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));
  Get.to(() =>SetStockPage());

}
partfunc() async{
  //(await Get.put(ParticipatedQuery()).getCountParticipateEventOnline(Participated(uidUser:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));

  Get.to(() =>SetPartPage());


}
partHistfunc() async{
  //(await Get.put(ParticipatedQuery()).getCountParticipateEventOnline(Participated(uidUser:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));

  Get.to(() =>SetPartHistPage());


}
quickBoHistfunc() async{
  //(await Get.put(TopupQuery()).GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));
  Get.to(() =>SetQuickBoHistPage());

}

editCardfunc() async{
  Get.to(() =>SetEditCardNoPage());
}
logout() async{
  Get.dialog(
    AlertDialog(
      title: Text('Confirmation'),
      content: Text('Do you Want to Logout?'),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(

            //primary: Colors.grey[300],
            backgroundColor: Color(0xff9a1c55),
            elevation:0,
          ),
          onPressed: () async{
            //Get.put(HideShowState()).setHomenavigator(0);
            Get.put(HideShowState()).setHomenavigator(0);
            await Get.put(AdminQuery()).logout();

            Get.toNamed('/Login');
          },
          child: Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(); // close the alert dialog
          },
          child: Text('Close'),
        ),
      ],
    ),
  );
}

withdrawBonusFunc(){
  Get.to(() =>SetWithdrawBonusPage());
}
withdrawBalanceFunc(){
  Get.to(() =>SetWithdrawBalancePage());
}







