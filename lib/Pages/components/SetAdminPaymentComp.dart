import 'dart:math';


import 'package:dStock/Pages/components/Spendings/GenSpendingComp.dart';
import 'package:dStock/Pages/components/Spendings/StockSpendingComp.dart';

import '../../../Utilconfig/HideShowState.dart';
import '../../../models/QuickBonus.dart';

import '../../../models/Topups.dart';
import '../../../models/User.dart';
import 'package:get/get.dart';

import '../../Query/StockQuery.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';


import '../SetPage2.dart';
import 'adminPayments/BorrowPaymentComp.dart';
import 'adminPayments/SafePaymentComp.dart';






class SetAdminPaymentComp extends StatefulWidget {
  const SetAdminPaymentComp({Key? key}) : super(key: key);

  @override
  State<SetAdminPaymentComp> createState() => _SetAdminPaymentCompState();
}

class _SetAdminPaymentCompState extends State<SetAdminPaymentComp> {

  final ScrollController _scrollController = ScrollController();// detect scroll
  final List<dynamic> _data = [];
  List<dynamic> thisListOrder = [];
  List<dynamic> orderData = [];


  var bottomResult=[];
  num countData=0;
  var resultData="";

  int _page=0;
  int limit=0;
  bool hasMoreData=true;
  bool isLoading=false;
  num qtyProduct=1;
  String productCode="";


  String clientOrder="";
  String orderId="";
  bool btnExpenseHide=false;
  bool btnExpenseEditHide=false;
  TextEditingController balance=TextEditingController();
  TextEditingController purpose=TextEditingController();
  TextEditingController commentData=TextEditingController();
  TextEditingController uidEdit=TextEditingController();

  TextEditingController balanceEdit=TextEditingController();
  TextEditingController purposeEdit=TextEditingController();
  TextEditingController commentDataEdit=TextEditingController();
  String safariId="none";
  String safariName="SafariName";
  String options="others";
  num inputData=0;
  int maxLength = 15; // Set your desired maximum length








  bool showOveray=false;



  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        ListView(


          children: [



            divLine(),
            GestureDetector(
                onTap: (){
                  safePayment();
                },
                child: detailsProfile("Safe Balance",Icons.calendar_month_outlined,"",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,safePayment)),//Last Time Purchase
            const SizedBox(height:5,),
            GestureDetector(
                onTap: (){
                  borrowPayment();
                },
                child: detailsProfile("Borrow Balance",Icons.calendar_month_outlined,"",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,borrowPayment)),//Last Time Purchase








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
    //return Center(child: Text("hello"));




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

                  GestureDetector(
                      onTap: () {
                        // This function will be called when the icon is tapped.
                        myfunct();
                      },
                      child: Icon(iconright,color:
                      Colors.teal,size: 22,)
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  safePayment() async{

    Get.to(() =>SetPage2(dynamicMethod: () {
      return const SafePaymentComp();
    }),arguments:{
      "title":"Safe Balance",
    });

  }
  borrowPayment() async{

    Get.to(() =>SetPage2(dynamicMethod: () {
      return const BorrowPaymentComp();
    }),arguments:{
      "title":"Borrow Balance",
    });

  }

  @override
  void initState()
  {
    super.initState();
    //getapi();

    quickData();
    _scrollController.addListener(_scrollListener);

  }
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _page=_page+10;

      quickData();
    }
  }


  @override
  void dispose() {


    _scrollController.dispose();
    super.dispose();
  }



  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
  IconData _getRandomIcon() {
    Random random = Random();
    List<IconData> icons = [Icons.favorite,Icons.star,Icons.thumb_up,Icons.access_time,Icons.access_time,Icons.fastfood,Icons.directions_bike,      Icons.directions_walk,      Icons.directions_car,      Icons.directions_boat,      Icons.airplanemode_active,      Icons.airport_shuttle,      Icons.beach_access,      Icons.camera,      Icons.movie,      Icons.music_note,      Icons.spa,      Icons.palette,      Icons.account_balance,      Icons.attach_money,    ];
    return icons[random.nextInt(icons.length)];
  }


  //

  quickData()
  {
    viewData('test',false);

  }
  viewData(nameVal,searchVal) async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;

    var resultData=(await StockQuery().viewSpending(Topups(startlimit:limit,endlimit:_page,name:nameVal,searchOption:searchVal))).data;

    if(resultData["status"])
    {



      if(resultData["result"]!=0)
      {
        setState(() {
          isLoading=false;
          hasMoreData=false;
          _data.clear();
          _data.addAll(resultData["result"]);

        });
      }
      else{
        setState(() {
          isLoading=false;
          hasMoreData=false;
          _data.clear();


        });
      }




    }
    else{
      setState(() {
        isLoading=false;
        hasMoreData=false;
        _data.clear();


      });
    }
  }
  thisOrder2()async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;

    var resultData=(await StockQuery().orderViewByUid(Topups(uid:"${orderData[0]}",startlimit:limit,endlimit:_page))).data;


    if(resultData["status"])
    {
      setState(() {
        isLoading=false;
        hasMoreData=false;


        thisListOrder.clear();
        thisListOrder.addAll(resultData["result"]);


      });
      return true;
    }
    else{
      return false;
    }

  }

  thisOrder()async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;


    var resultData=(await StockQuery().viewSalesByUid(Topups(uid:"${orderData[0]}",startlimit:limit,endlimit:_page))).data;
    // var resultData=(await StockQuery().orderViewByUid(Topups(uid:"0s",startlimit:limit,endlimit:_page))).data;
    //print(resultData);
    if(resultData["status"])
    {

      return resultData;
    }
    else{
      return false;
    }




  }

  void viewThisOrder() {

    Get.bottomSheet(

      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            Container(

              padding:const EdgeInsets.all(5.0),
              height: 600,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [

                  Center(child: Text("Client:${orderData[1]}")),
                  Center(child: Text("UID:${orderData[0]}")),

                  Expanded(
                    child: ListView.builder(


                      itemCount:thisListOrder.length+1,
                      itemBuilder: (context, index) {

                        if(index<thisListOrder.length)
                        {

                          (Get.put(HideShowState())).isDelivery(thisListOrder);



                          //Get.put(HideShowState())).isDelivery(thisListOrder[index]);


                          return Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Card(
                              elevation:0.5,
                              //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                              //color:Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                //side: BorderSide(color:_data[index]["color_var"]??true?Colors.white:Colors.green, width: 2),
                              ),

                              child: Column(
                                children: [
                                  // Text("sum:${orderSum}"),
                                  ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor:getRandomColor(),
                                        child: Icon(_getRandomIcon()),
                                      ),
                                      title:Row(
                                        children: [
                                          Expanded(

                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                RichText(
                                                  text: TextSpan(
                                                    text:"${thisListOrder[index]["productName"]} (${thisListOrder[index]["pcs"]} pcs):",
                                                    style: DefaultTextStyle.of(context).style,
                                                    children: const <TextSpan>[


                                                    ],
                                                  ),
                                                ),
                                                Text("Price:${(thisListOrder[index]["price"])}"),


                                                Text.rich(
                                                    TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Qty ${thisListOrder[index]["totalQty"]}:',

                                                          ),

                                                          WidgetSpan(

                                                            child: IntrinsicWidth(
                                                              stepWidth: 0.5,
                                                              child: TextField(


                                                                keyboardType: TextInputType.number,
                                                                decoration: const InputDecoration(
                                                                  hintText: '-1-',
                                                                  // hintText: '   -${(((Get.put(HideShowState()).delivery)[index]["totalQty"])!=((Get.put(HideShowState()).delivery)[index]["totalCount"]))?(((Get.put(HideShowState()).delivery)[index]["totalQty"]-(Get.put(HideShowState()).delivery)[index]["totalCount"])):1}-',
                                                                  hintStyle: TextStyle(color: Colors.red),
                                                                  contentPadding: EdgeInsets.all(0),
                                                                  isDense: true,



                                                                ),
                                                                style: const TextStyle(
                                                                  color: Colors.blue, // Set the text color to red

                                                                ),
                                                                onChanged: (text) {
                                                                  if((double.tryParse(text) != null)){
                                                                    (Get.put(HideShowState()).delivery)[index]["currentQty"]=num.parse(text);



                                                                    if(((Get.put(HideShowState()).delivery)[index]["totalQty"])>=(Get.put(HideShowState()).delivery)[index]["currentQty"])
                                                                    {




                                                                      setState(() {
                                                                        (Get.put(HideShowState()).delivery)[index]["hideAddCart"]=1;


                                                                      });


                                                                    }
                                                                    else{

                                                                      setState(() {
                                                                        (Get.put(HideShowState()).delivery)[index]["hideAddCart"]=0;
                                                                      });

                                                                    }

                                                                  }
                                                                  else{

                                                                    setState(() {

                                                                      (Get.put(HideShowState()).delivery)[index]["hideAddCart"]=0;

                                                                    });

                                                                  }


                                                                },
                                                              ), // set minimum width to 100
                                                            ),
                                                          ),

                                                        ]
                                                    )
                                                ),
                                                Text("Deliver:${(((Get.put(HideShowState()).delivery)[index]["totalQty"])!=((Get.put(HideShowState()).delivery)[index]["totalCount"]))?(((Get.put(HideShowState()).delivery)[index]["totalQty"]-(Get.put(HideShowState()).delivery)[index]["totalCount"])):0}"),


                                              ],
                                            ),
                                          )






                                        ],
                                      ),


                                      trailing:Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              if((Get.put(HideShowState()).delivery)[index]["hideAddCart"]==1)
                                                IconButton(
                                                  icon: const Icon(Icons.add_shopping_cart,
                                                      size: 23.0,
                                                      color: Colors.grey),
                                                  onPressed: () async{
                                                    productCode=thisListOrder[index]["productCode"];


                                                    //await stockCount(index);


                                                    num totCount=(((Get.put(HideShowState()).delivery)[index]["totalCount"]-(Get.put(HideShowState()).delivery)[index]["currentQty"])>=0)?(Get.put(HideShowState()).delivery)[index]["totalCount"]:0;
                                                    if(totCount>0)
                                                    {
                                                      var resultData=(await StockQuery().stockCount(Topups(uid:"${orderData[0]}"),QuickBonus(uid:productCode,qty:"${(Get.put(HideShowState()).delivery)[index]["currentQty"]}",subscriber:"StockName",status:"status",description:"Delivered"), User(uid: "UidTransport",name:"refName"))).data;

                                                      if(resultData["status"])
                                                      {
                                                        quickData();
                                                        // thisOrder2();
                                                        setState(() {

                                                          (Get.put(HideShowState()).delivery)[index]["totalCount"]=(Get.put(HideShowState()).delivery)[index]["totalCount"]-(Get.put(HideShowState()).delivery)[index]["currentQty"];

                                                        });
                                                      }

                                                    }









                                                  },
                                                ),


                                              IconButton(
                                                icon: const Icon(
                                                    Icons.delete,
                                                    size: 23.0,
                                                    color: Colors.red
                                                ),
                                                onPressed: () {


                                                },
                                              ),
                                            ],
                                          ),

                                        ],
                                      )

                                    //trailing: Text()
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8,0,8,8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("${thisListOrder[index]["totalAmount"]}"),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );

                        }
                        else{
                          return Container();
                        }

                      },
                    ),
                  ),
                ],
              ),
            );
        },
      ),
    ).whenComplete(() {
      // Get.put(HideShowState()).isDelivery(0);
      //do whatever you want after closing the bottom sheet
    });

  }








//
}


