
import 'package:dcard/Pages/AllEventPage.dart';
import 'package:dcard/Pages/BalancePage.dart';
import 'package:dcard/Pages/BonusPage.dart';
import 'package:dcard/Pages/WBonusHistPage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Query/CardQuery.dart';
import '../../Query/TopupQuery.dart';
import '../../Utilconfig/HideShowState.dart';
import '../../models/Topups.dart';
import '../ActiveEventPage.dart';
import'../../Pages/components/ProfilePic.dart';

class ProfileComp extends StatefulWidget {
  const ProfileComp({Key? key}) : super(key: key);

  @override
  State<ProfileComp> createState() => _ProfileCompState();
}

class _ProfileCompState extends State<ProfileComp> {
  var ResultData;
  final TextEditingController balance = TextEditingController();
  final TextEditingController description = TextEditingController();
  bool showOveray=false;

  var ResultDatas;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(


        children: [

        ProfilePic().profile(),
    const SizedBox(height: 6.0,),
    divLine(),
    GestureDetector(
        onTap: (){
          balancefunc();
        },
        child: detailsProfile("Balance",Icons.account_balance_wallet,"${(Get.put(TopupQuery()).obj)["resultData"]["result"].length>0?(Get.put(TopupQuery()).obj)["resultData"]["result"][0]["balance"]:"0"}\$",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,balancefunc)),
    const SizedBox(height:5,),
    GestureDetector(
        onTap: (){
          bonusfunc();
        },
        child: detailsProfile("Bonus",Icons.redeem,"${(Get.put(TopupQuery()).obj)["resultData"]["result"].length>0?(Get.put(TopupQuery()).obj)["resultData"]["result"][0]["bonus"]:"0"}\$",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,bonusfunc)),
    const SizedBox(height:5,),
    GestureDetector(
        onTap: (){
          eventfunc();
        },
        child: detailsProfile("Event",Icons.calendar_month_outlined,"",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,eventfunc)),//Last Time Purchase
    const SizedBox(height:5,),
    //   detailsProfile("Status",Icons.track_changes,"Redeemed",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,Statusfunc),

    GestureDetector(
        onTap: (){
          topupFunc();
        },
        child: detailsProfile("Top Up",Icons.paid,"",0xbfebf1ef,"textright",Icons.arrow_forward,"200\$",0xffffffff,topupFunc)),
    const SizedBox(height:5,),
    GestureDetector(
        onTap: (){
          editTopupfunc();
        },
        child: detailsProfile("Edit Balance",Icons.account_balance,"",0xbfebf1ef,"textright",Icons.arrow_forward,"200\$",0xffffffff,editTopupfunc)),
    const SizedBox(height:5,),
    GestureDetector(
        onTap: (){
          withdrawFunc();
        },
        child: detailsProfile("WithDraw Balance",Icons.payments_rounded,"",0xbfebf1ef,"textright",Icons.arrow_forward,"200\$",0xffffffff,withdrawFunc)),
    const SizedBox(height:5,),
    GestureDetector(
        onTap: (){
          redeemBonus();
        },
        child: detailsProfile("Widraw Bonus",Icons.redeem,"",0xbfebf1ef,"textright",Icons.arrow_forward,"200\$",0xffffffff,bonusHistory)),
          const SizedBox(height:5,),
          GestureDetector(
              onTap: (){
                bonusHistory();
              },
              child: detailsProfile("Withdraw Bonus History",Icons.redeem,"",0xbfebf1ef,"textright",Icons.arrow_forward,"200\$",0xffffffff,bonusHistory)),







    ],
    ),


      ],
    );
  }

  topupFunc() async{
    balance.text="";
    description.text="";
    Get.bottomSheet(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                height: 230,

                child: Column(
                  children: [
                    Container(

                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView(
                        children: [
                          SizedBox(height: 10.0,),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget> [

                                  TextField(
                                    controller:balance,
                                    keyboardType: TextInputType.number,
                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Balance',
                                      hintText: 'Enter Balance',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  TextField(
                                    controller:description,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Description',
                                      hintText: 'Enter Description',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Center(
                                    child: FloatingActionButton.extended(
                                      label: Text('Add Balance'), // <-- Text
                                      backgroundColor: Color(0xff052336),
                                      icon: Icon( // <-- Icon
                                        Icons.paid,
                                        size: 24.0,
                                      ),
                                      onPressed: ()async =>{
                                        Get.put(HideShowState()).isprofileVisible(true),
                                        /*setState(() {

                                          showOveray=true;

                                        }),*/
                                        ResultData=(await Get.put(TopupQuery()).AddBalanceOnline(Topups(uid:"1",uidCreator:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}",amount:balance.text,desc:description.text))).data,

                                        if(ResultData["status"])
                                          {
                                          Get.put(HideShowState()).isprofileVisible(false),
                                            /*setState(() {
                                              showOveray=false;

                                            }),*/
                                            Get.snackbar("Success", "Balance Added Successfuly",backgroundColor: Color(0xff9a1c55),
                                                colorText: Color(0xffffffff),
                                                titleText: const Text("Balance",style:TextStyle(color:Color(
                                                    0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                                icon: Icon(Icons.access_alarm),
                                                duration: Duration(seconds: 4)),

                                            ResultDatas=(await Get.put(TopupQuery()).GetBalance(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}"))).data,
                                            if(ResultDatas["status"])
                                              {
                                                await Get.put(TopupQuery()).updateTopupState(ResultDatas),
                                                setState(() {

                                                  Get.put(TopupQuery()).obj;

                                                }),
                                                Get.close(1),

                                              }

                                          }else{
                                          Get.put(HideShowState()).isprofileVisible(false),
                                          Get.snackbar("Error", "Balance",backgroundColor: Color(
                                              0xffdc2323),
                                              colorText: Color(0xffffffff),
                                              titleText: const Text("Something is Wrong Please Contact System Admin",style:TextStyle(color:Color(
                                                  0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                              icon: Icon(Icons.access_alarm),
                                              duration: Duration(seconds: 4))
                                        }

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
                child:  Obx(
                      () =>Visibility(
                    visible: Get.put(HideShowState()).profVisible.value,
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
                    visible: Get.put(HideShowState()).profVisible.value,
                    child: Container(
                      //padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
            ),


          ],
        )
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });
  }
  editTopupfunc() async{
    balance.text="${(Get.put(TopupQuery()).obj)["resultData"]["result"][0]["balance"]}";
    description.text="${(Get.put(TopupQuery()).obj)["resultData"]["result"][0]["description"]}";
    Get.bottomSheet(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                height: 230,

                child: Column(
                  children: [
                    Container(

                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView(
                        children: [
                          SizedBox(height: 10.0,),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget> [

                                  TextField(
                                    controller:balance,
                                    //obscureText: true,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Balance',
                                      hintText: 'Enter Balance',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  TextField(
                                    controller:description,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Description',
                                      hintText: 'Enter Description',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Center(
                                    child: FloatingActionButton.extended(
                                      label: Text('Edit Balance'), // <-- Text
                                      backgroundColor: Color(0xff9a1c55),
                                      icon: Icon( // <-- Icon
                                        Icons.account_balance,
                                        size: 24.0,
                                      ),
                                      onPressed: ()async =>{
                                        Get.put(HideShowState()).isprofileVisible(true),
                                        ResultData=(await Get.put(TopupQuery()).EditBalanceOnline(Topups(uid:"1",uidCreator:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}",amount:balance.text,desc:description.text))).data,

                                        if(ResultData["status"])
                                          {
                                            Get.put(HideShowState()).isprofileVisible(false),
                                            Get.snackbar("Success", "Balance Edited Successfuly",backgroundColor: Color(0xff9a1c55),
                                                colorText: Color(0xffffffff),
                                                titleText: const Text("Balance",style:TextStyle(color:Color(
                                                    0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                                icon: Icon(Icons.access_alarm),
                                                duration: Duration(seconds: 4)),

                                            ResultDatas=(await Get.put(TopupQuery()).GetBalance(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}"))).data,
                                            if(ResultDatas["status"])
                                              {
                                                await Get.put(TopupQuery()).updateTopupState(ResultDatas),
                                                setState(() {
                                                  Get.put(TopupQuery()).obj;
                                                }),
                                                Get.close(1),

                                              }

                                          }else{
                                          Get.put(HideShowState()).isprofileVisible(false),
                                          Get.snackbar("Error", "Something is Wrong Please Contact System Admin",backgroundColor: Color(
                                              0xffdc2323),
                                              colorText: Color(0xffffffff),
                                              titleText: const Text("Balance",style:TextStyle(color:Color(
                                                  0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                              icon: Icon(Icons.access_alarm),
                                              duration: Duration(seconds: 4))
                                        }

                                      },




                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Positioned.fill(
                              child:  Obx(
                                    () =>Visibility(
                                  visible: Get.put(HideShowState()).profVisible.value,
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
                                  visible: Get.put(HideShowState()).profVisible.value,
                                  child: Container(
                                    //padding: EdgeInsets.all(16),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


          ],
        )
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });
  }

  withdrawFunc() async{
    balance.text="";
    description.text="";
    Get.bottomSheet(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                height: 230,

                child: Column(
                  children: [
                    Container(

                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView(
                        children: [
                          SizedBox(height: 10.0,),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget> [

                                  TextField(
                                    controller:balance,
                                    keyboardType: TextInputType.number,
                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Balance',
                                      hintText: 'Enter Balance',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  TextField(
                                    controller:description,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Description',
                                      hintText: 'Enter Description',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Center(
                                    child: FloatingActionButton.extended(
                                      label: Text('WithDraw'), // <-- Text
                                      backgroundColor: Color(0xff9a1c55),
                                      icon: Icon( // <-- Icon
                                        Icons.payments_rounded,
                                        size: 24.0,
                                      ),
                                      onPressed: ()async =>{
                                        Get.put(HideShowState()).isprofileVisible(true),
                                        ResultData=(await Get.put(TopupQuery()).RedeemBalanceOnline(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}",amount:balance.text,desc:description.text))).data,
                                        if(ResultData["status"])
                                          {
                                            Get.put(HideShowState()).isprofileVisible(false),
                                            Get.snackbar("Success", "Successfully Withdraw",backgroundColor: Color(0xff9a1c55),
                                                colorText: Color(0xffffffff),
                                                titleText: const Text("Balance",style:TextStyle(color:Color(
                                                    0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                                icon: Icon(Icons.access_alarm),
                                                duration: Duration(seconds: 4)),

                                            ResultDatas=(await Get.put(TopupQuery()).GetBalance(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}"))).data,
                                            if(ResultDatas["status"])
                                              {
                                                await Get.put(TopupQuery()).updateTopupState(ResultDatas),
                                                setState(() {
                                                  Get.put(TopupQuery()).obj;
                                                }),
                                                Get.close(1),

                                              }

                                          }else{
                                          Get.put(HideShowState()).isprofileVisible(false),
                                          Get.snackbar("Error", "insufficient Balance in Your Account",backgroundColor: Color(
                                              0xffdc2323),
                                              colorText: Color(0xffffffff),
                                              titleText: const Text("Balance",style:TextStyle(color:Color(
                                                  0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                              icon: Icon(Icons.access_alarm),
                                              duration: Duration(seconds: 4))
                                        }

                                      },




                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Positioned.fill(
                              child:  Obx(
                                    () =>Visibility(
                                  visible: Get.put(HideShowState()).profVisible.value,
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
                                  visible: Get.put(HideShowState()).profVisible.value,
                                  child: Container(
                                    //padding: EdgeInsets.all(16),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


          ],
        )
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });
  }
  redeemBonus() async{
    balance.text="";
    description.text="";
    Get.bottomSheet(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                height: 230,

                child: Column(
                  children: [
                    Container(

                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView(
                        children: [
                          SizedBox(height: 10.0,),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget> [

                                  TextField(
                                    controller:balance,
                                    keyboardType: TextInputType.number,
                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Balance',
                                      hintText: 'Enter Balance',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  TextField(
                                    controller:description,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Description',
                                      hintText: 'Enter Description',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Center(
                                    child: FloatingActionButton.extended(
                                      label: Text('Redeem'), // <-- Text
                                      backgroundColor: Color(0xff9a1c55),
                                      icon: Icon( // <-- Icon
                                        Icons.redeem,
                                        size: 24.0,
                                      ),
                                      onPressed: ()async =>{
                                        Get.put(HideShowState()).isprofileVisible(true),
                                        ResultData=(await Get.put(TopupQuery()).RedeemBonusOnline(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}",amount:balance.text,desc:description.text))).data,
                                        if(ResultData["status"])
                                          {
                                            Get.put(HideShowState()).isprofileVisible(false),
                                            Get.snackbar("Success", "Successfully Redeem Bonus",backgroundColor: Color(0xff9a1c55),
                                                colorText: Color(0xffffffff),
                                                titleText: const Text("Bonus",style:TextStyle(color:Color(
                                                    0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                                icon: Icon(Icons.access_alarm),
                                                duration: Duration(seconds: 4)),

                                            ResultDatas=(await Get.put(TopupQuery()).GetBalance(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}"))).data,
                                            if(ResultDatas["status"])
                                              {
                                                await Get.put(TopupQuery()).updateTopupState(ResultDatas),
                                                setState(() {
                                                  Get.put(TopupQuery()).obj;
                                                }),
                                                Get.close(1),

                                              }

                                          }else{
                                          Get.put(HideShowState()).isprofileVisible(false),
                                          Get.snackbar("Error", "insufficient Bonus in Your Account",backgroundColor: Color(
                                              0xffdc2323),
                                              colorText: Color(0xffffffff),
                                              titleText: const Text("Bonus",style:TextStyle(color:Color(
                                                  0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                              icon: Icon(Icons.access_alarm),
                                              duration: Duration(seconds: 4))
                                        }

                                      },




                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Positioned.fill(
                              child:  Obx(
                                    () =>Visibility(
                                  visible: Get.put(HideShowState()).profVisible.value,
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
                                  visible: Get.put(HideShowState()).profVisible.value,
                                  child: Container(
                                    //padding: EdgeInsets.all(16),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


          ],
        )
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });
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
         Text("${iconText}:",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
         SizedBox(width:5,),
         Expanded(
           child: Container(
             padding: EdgeInsets.only(top: 3.9),
             child: Text("${iconDescr}",style:GoogleFonts.pacifico(fontSize: 15)),
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

 balancefunc() async{
   //(await Get.put(TopupQuery()).GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));

   Get.to(() =>BalancePage());
}
bonusfunc() async{
  //(await Get.put(TopupQuery()).GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));

  Get.to(() =>BonusPage());
}
bonusHistory() async{
  //(await Get.put(TopupQuery()).GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));

  Get.to(() =>WBonusHistPage());
}
eventfunc() async{
  //(await Get.put(ParticipatedQuery()).getCountParticipateEventOnline(Participated(uidUser:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));

  //Get.to(() =>EventsPage());
  Get.to(() =>AllEventPage());

}
statusfunc() async{
  (await Get.put(TopupQuery()).GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));

  Get.to(() =>ActiveEventPage());
}
/*Topupfunc() async{
  (await Get.put(TopupQuery()).GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));

  Get.to(() =>ActiveEventPage());
}*/







