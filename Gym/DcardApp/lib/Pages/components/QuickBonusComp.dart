import 'dart:math';

import 'package:dcard/Query/ParticipatedQuery.dart';

import 'package:dcard/models/Topups.dart';

import '../../models/BonusModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Query/CardQuery.dart';

import '../../Query/TopupQuery.dart';



class QuickBonusComp extends StatefulWidget {
  const QuickBonusComp({Key? key}) : super(key: key);

  @override
  State<QuickBonusComp> createState() => _QuickBonusCompState();
}

class _QuickBonusCompState extends State<QuickBonusComp> {
  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];

  int _page=0;
  int limit=0;
  bool hasMoreData=true;
  bool isLoading=false;


  @override
  Widget build(BuildContext context) {



    //return listdata();

    /*WidgetsBinding.instance.addPostFrameCallback((_) {

      QuickBonus();
    });*/
    return listdata();
    //return Center(child: Text("hello"));




  }
  Widget listdata(){
    return  Column(
      children: [
        //ProfilePic().profile(),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Bonus History",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
        ),
        Get.put(ParticipatedQuery()).dataCartui["cartshow"]?
    Container(
    child: FittedBox(
    child: Stack(
    alignment: Alignment(2, -1.6),
    children: [
    FloatingActionButton(  // Your actual Fab
    onPressed: () {
      Get.toNamed('/QuickCart');

    },
    child: Icon(Icons.shopping_cart),
    backgroundColor:Colors.deepOrange,
    ),
      Container(

        child: CircleAvatar(
          radius: 16, // set the radius of the circle
          backgroundColor: Colors.white, // set the background color of the circle
          foregroundColor: Colors.red,
          // set the border color of the circle
          child: Text("${Get.put(ParticipatedQuery()).dataCartui["countData"]["count"]}",style:GoogleFonts.roboto(fontSize:18,fontWeight: FontWeight.w700)), // add a child widget if needed
        ),
      )
    ],
    ),
    ),
    )
            :Visibility(
            visible:false,
            child: Text("")),

        Container(
          height:50,
          padding: const EdgeInsets.all(0),
          margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: TextField(

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              labelText: 'Search',
            ),
            onChanged: (text) async{

              try {
                if(text=="")
                  {
                    //print("empty text");
                   setState(() {
                     _data.clear();
                     _page=0;
                    hasMoreData=true;
                  isLoading=false;

                   });
                   await Quickdata();

                  }else{
                  var Resul=(await ParticipatedQuery().SearchQuickBonusEventOnline(BonusModel(productName:text))).data;
                  if(Resul["status"])
                  {
                    setState(() {
                      //print(Resul);
                      isLoading=false;
                      hasMoreData=false;
                      _data.clear();

                      _data.addAll(Resul["result"]);
                    });
                  }
                  else{
                    //print("no data find");

                    _data.clear();
                    Quickdata();




                  }
                }


              } catch (e) {
                print('Error: $e');
              }

              //print(this._data[index]["total_var"]);
              // print("Text changed to: $text");
            },
          ),
        ),
        Expanded(

          child: ListView.builder(

            controller: _scrollController,
            itemCount: _data.length+1,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, index) {

              if(index<_data.length)
              {




                return Card(
                  elevation:0,
                  //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                  color:Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                    //side: BorderSide(color:Colors.white54, width: 2),
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(_getRandomIcon()),
                      backgroundColor:getRandomColor(),
                    ),
                    title: Row(
                      children: [
                        Text("${_data[index]["productName"]}:"),
                        IntrinsicWidth(
                          child: TextField(

                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '-1-',
                              hintStyle: TextStyle(color: Colors.blue),
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,



                            ),
                            style: TextStyle(
                              color: Colors.blue, // Set the text color to red

                            ),
                            onChanged: (text) {
                              try {
                                //numVal = num.parse(str);
                                var myValue = double.tryParse(text);

                                if (myValue != null && !myValue.isNaN) {
                                  //print('myValue is a number');
                                  setState(() {
                                    _data[index]['textchange']=false;
                                    this._data[index]["total_var"]=num.parse(this._data[index]["price"])*num.parse(text);

                                    var checkBonus=(_data[index]["bonusType"]=='Gift')?((num.parse(_data[index]["giftMin"])>((num.parse(text)*num.parse(_data[index]["bonusValue"])).toInt()))?"0 Pcs (Min:${_data[index]["giftMin"]})":"${(num.parse(text)*num.parse(_data[index]["bonusValue"])).toInt()}Pcs of ${_data[index]["giftName"]}"):
                                    ((num.parse(_data[index]["moneyMin"])>num.parse(text)*num.parse(_data[index]["bonusValue"]))?"0 \$ Min ${_data[index]["moneyMin"]} \$":
                                    "${(num.parse(text)*num.parse(_data[index]["bonusValue"]))}\$");
                                    _data[index]["textchange_var"]=text;
                                    _data[index]["bonus_var"]=checkBonus;
                                    _data[index]["qty_var"]=text;
                                    _data[index]["giftPcs_var"]=(_data[index]["bonusType"]=='Gift')?"${(num.parse(text)*num.parse(_data[index]["bonusValue"])).toInt()}":"${(_data[index]["giftPerPcs"])}";
                                    _data[index]["totBonus_var"]=(_data[index]["bonusType"]=='Gift')?
                                    ((num.parse(_data[index]["giftMin"])>((num.parse(text)*num.parse(_data[index]["bonusValue"])).toInt()))?"0":"${(num.parse(text)*num.parse(_data[index]["bonusValue"])).toInt()}"):
                                    ((num.parse(_data[index]["moneyMin"])>num.parse(text)*num.parse(_data[index]["bonusValue"]))?"0":
                                    "${(num.parse(text)*num.parse(_data[index]["bonusValue"]))}");

                                    (num.parse(text)>1)?_data[index]["showBtn"]=true:_data[index]["showBtn"]=false;



                                    // Update the value of _counter and trigger a rebuild
                                  });
                                } else {
                                  setState(() {
                                    _data[index]['textchange']=true;//return to 1
                                    this._data[index]["total_var"]=num.parse(this._data[index]["price"])*num.parse("1");

                                    //var checkBonus=(_data[index]["bonusType"]=='Gift')?"${(num.parse("1")*num.parse(_data[index]["bonusValue"])).toInt()}Pcs of ${_data[index]["giftName"]}":"${(num.parse("1")*num.parse(_data[index]["bonusValue"]))}\$";
                                    var checkBonus=(_data[index]["bonusType"]=='Gift')?((num.parse(_data[index]["giftMin"])>((num.parse(text)*num.parse(_data[index]["bonusValue"])).toInt()))?"0 Pcs (Min:${_data[index]["giftMin"]})":"${(num.parse("1")*num.parse(_data[index]["bonusValue"])).toInt()}Pcs of ${_data[index]["giftName"]}"):
                                    ((num.parse(_data[index]["moneyMin"])>num.parse("1")*num.parse(_data[index]["bonusValue"]))?"0 \$ Min ${_data[index]["moneyMin"]} \$":
                                    "${(num.parse("1")*num.parse(_data[index]["bonusValue"]))}\$");

                                    _data[index]["textchange_var"]="1";
                                    _data[index]["bonus_var"]=checkBonus;
                                    _data[index]["qty_var"]="1";
                                    _data[index]["giftPcs_var"]=(_data[index]["bonusType"]=='Gift')?"${(num.parse("1")*num.parse(_data[index]["bonusValue"])).toInt()}":"${(_data[index]["giftPerPcs"])}";
                                    //_data[index]["totBonus_var"]=(_data[index]["bonusType"]=='Gift')?"${(num.parse("1")*num.parse(_data[index]["bonusValue"])).toInt()}":"${(num.parse("1")*num.parse(_data[index]["bonusValue"]))}";
                                    //(num.parse(text)>1)?_data[index]["showBtn"]=true:_data[index]["showBtn"]=false;

                                    _data[index]["totBonus_var"]=(_data[index]["bonusType"]=='Gift')?
                                    ((num.parse(_data[index]["giftMin"])>((num.parse("1")*num.parse(_data[index]["bonusValue"])).toInt()))?"0":"${(num.parse("1")*num.parse(_data[index]["bonusValue"])).toInt()}"):
                                    ((num.parse(_data[index]["moneyMin"])>num.parse("1")*num.parse(_data[index]["bonusValue"]))?"0":
                                    "${(num.parse("1")*num.parse(_data[index]["bonusValue"]))}");

                                    // Update the value of _counter and trigger a rebuild
                                  });
                                }

                              } catch (e) {

                                _data[index]["showBtn"]=false;
                                print('Error: $e');
                              }


                              //print(this._data[index]["total_var"]);
                              // print("Text changed to: $text");
                            },
                          ),
                          stepWidth: 0.5, // set minimum width to 100
                        ),



                        Expanded(child: Text("X${_data[index]['price']}=${_data[index]["total_var"]?? _data[index]['price']}"))
                      ],
                    ),
                   //subtitle: Text("Bonus:${_data[index]["bonus_var"]??0}"),
                    subtitle: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        (_data[index]["bonusType"]=='Gift')?CircleAvatar(
                          backgroundColor:Colors.deepOrange,
                          radius: 10,
                          child: Icon(Icons.redeem,color:Colors.white,size:12,),
                        ):
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 10,
                          child: Icon(Icons.attach_money_rounded,color:Colors.white,size:13,),
                        ),
                        Text(" Bonus"),

                     //   (_data[index]["bonusType"]=='Gift')?Icon(Icons.card_giftcard_rounded,color: Colors.red,size: 20,):Icon(Icons.paid,color: Colors.green,size:20,),
                        Text(":${_data[index]["bonus_var"]??0}"),

                      ],
                    ),
                    trailing:_data[index]["showBtn"]??false? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () async{


                            try {

                              if((Get.put(ParticipatedQuery()).dataCartui["products"].containsKey('${_data[index]["quickUid"]}')))
                              {
                                //product Existed
                                Get.dialog(
                                  AlertDialog(
                                    title: Text('${_data[index]["productName"]} exist in Cart with ${_data[index]["bonusType"]} Promotion'),
                                    content: Text('Do you want to go in Cart and change Qty or Delete ?'),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(

                                          //primary: Colors.grey[300],
                                          backgroundColor: Color(0xff9a1c55),
                                          elevation:0,
                                        ),
                                        onPressed: () {
                                          Get.toNamed('QuickCart');
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
                              else{
                                var countAdd=Get.put(ParticipatedQuery()).dataCartui["countData"]["count"]+1;


                                var uidForm=Get.put(ParticipatedQuery()).dataCartui['cartshow']?Get.put(ParticipatedQuery()).dataCartui['resultData']["uid"]:'none';
                                bool updateTrueFalse=Get.put(ParticipatedQuery()).dataCartui['cartshow']?false:true;

                                var Resul=(await ParticipatedQuery().SubmitQuickBonusEventOnline(BonusModel(uid:uidForm,uidUser:'${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}',quickUid:_data[index]['quickUid'],productName:_data[index]["productName"],qty:_data[index]["qty_var"]??1,price:_data[index]["price"],bonusType:_data[index]["bonusType"],giftName:_data[index]["giftName"],giftPcs:_data[index]["giftPcs_var"]??_data[index]["giftPcs"],bonusValue:_data[index]["bonusValue"],totBonusValue:_data[index]["totBonus_var"]))).data;
                                if(Resul["status"])
                                {


                                  setState(() {

                                    Get.put(ParticipatedQuery()).updateCartUi(Resul,true,updateTrueFalse);
                                    Get.put(ParticipatedQuery()).dataCartui["products"]["${_data[index]["quickUid"]}"]=_data[index]["price"];
                                    Get.put(ParticipatedQuery()).dataCartui["countData"]["count"]=countAdd;
                                  });

                                  //print(Get.put(ParticipatedQuery()).dataCartui);

                                }
                                else{
                                  Quickdata();
                                }

                              }



                            } catch (e) {
                            print('Error: $e');
                            }

                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.done,
                              size: 23.0,
                              color: Colors.green),
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Do you want to Confirm ${_data[index]["productName"]}?'),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(

                                      //primary: Colors.grey[300],
                                      backgroundColor: Color(0xff9a1c55),
                                      elevation:0,
                                    ),
                                    onPressed: () async{
                                      try {
                                        var Resul=(await ParticipatedQuery().SubmitQuickBonusEventOnline(BonusModel(uid:'none',uidUser:'${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}',quickUid:_data[index]['quickUid'],productName:_data[index]["productName"],qty:_data[index]["qty_var"]??1,price:_data[index]["price"],bonusType:_data[index]["bonusType"],giftName:_data[index]["giftName"],giftPcs:_data[index]["giftPcs_var"]??_data[index]["giftPcs"],bonusValue:_data[index]["bonusValue"],totBonusValue:_data[index]["totBonus_var"],status:"confirm"))).data;
                                        if(Resul["status"])
                                        {
                                          Get.back();

                                        }
                                        else{
                                          Quickdata();
                                        }


                                      } catch (e) {
                                        print('Error: $e');
                                      }
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
                          },
                        ),
                      ],
                    )
                        :Visibility(
                        visible:false,
                        child: Text("")),
                    //trailing: Text()
                  ),
                );

              }
              else{
                return  Padding(
                  padding:EdgeInsets.symmetric(vertical: 32),
                  child:Center(
                      child:hasMoreData?
                      CircularProgressIndicator()
                          :Text("no more Data")

                  ),
                );
              }

            },
          ),
        ),
      ],
    );
  }
  void initState()
  {
    super.initState();
    //getapi();
    Quickdata();
    _scrollController.addListener(_scrollListener);
  }
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _page=_page+10;

      Quickdata();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override

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
  scrolldata()async
  {
    if(isLoading) return;
    isLoading=true;
    //int limit=10;
    //var Resul=(await ScrollQuery().getapi(limit,_page)).data;
    var Resul=(await TopupQuery().GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}",startlimit:limit,endlimit:_page,optionCase:'bonus'))).data;
    setState(() {
      isLoading=false;
      if(Resul["result"].length<limit)
      {
        isLoading=false;
        hasMoreData=false;
      }

      _data.addAll(Resul["result"]);
    });
  }

  //

  Quickdata()async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;
    //var Resul=(await ScrollQuery().getapi(limit,_page)).data;
    var Resul=(await ParticipatedQuery().getAllQuickBonusEventOnline(Topups(startlimit:limit,endlimit:_page,optionCase:'bonus'))).data;

    setState(() {
      isLoading=false;
      if(Resul["result"].length<limit)
      {
        isLoading=false;
        hasMoreData=false;
      }

      _data.addAll(Resul["result"]);
    });


  }




//
}


