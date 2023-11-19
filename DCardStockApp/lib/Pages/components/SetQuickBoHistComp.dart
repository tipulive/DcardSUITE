import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:dcard/Query/ParticipatedQuery.dart';

import 'package:dcard/models/Topups.dart';

import '../../models/BonusModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Query/CardQuery.dart';

import '../../Query/TopupQuery.dart';
import 'package:flutter/gestures.dart';
import 'ProfilePic.dart';


class SetQuickBoHistComp extends StatefulWidget {
  const SetQuickBoHistComp({Key? key}) : super(key: key);

  @override
  State<SetQuickBoHistComp> createState() => _SetQuickBoHistCompState();
}

class _SetQuickBoHistCompState extends State<SetQuickBoHistComp> {
  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];

  int _page=0;
  int limit=0;
  bool hasMoreData=true;
  bool isLoading=false;

  bool showOveray=false;

  @override
  Widget build(BuildContext context) {



    //return listdata();

    /*WidgetsBinding.instance.addPostFrameCallback((_) {

      QuickBonus();
    });*/
    return Stack(
      children: [
        listdata(),
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
    );
    //return Center(child: Text("hello"));




  }
  Widget listdata(){
    return  Column(
      children: [
        //ProfilePic().profile(),

        Text("Recent Quick Bonus",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),



        Container(
          height: 55,
          //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                var Resul=(await ParticipatedQuery().SearchSubmitQuickBonusEventOnline(BonusModel(uidUser:'',status:'confirm',productName:text),Topups(startlimit:limit,endlimit:_page))).data;
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
                  _data.clear();
                  Quickdata();
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
            itemBuilder: (context, index) {

              if(index<_data.length)
              {
                FocusNode test=FocusNode() ;

                this._data[index]['focusNode']=test;
                return Card(
                  elevation:0,
                  //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                  //color:Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    side: BorderSide(color:_data[index]["color_var"]??true?Colors.white:Colors.green, width: 2),
                  ),

                  child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(_getRandomIcon()),
                        backgroundColor:getRandomColor(),
                      ),
                      title:Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "${_data[index]['productName']}:",
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "-${_data[index]["textchange_var"]??_data[index]["qty"]} -",
                                          style: TextStyle(color: Colors.blue),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // do something when the user clicks the text
                                              _data[index]['focusNode'].requestFocus();
                                              //print(_data[index]['focusNode'].requestFocus());

                                            },

                                        ),
                                        TextSpan(
                                          text:"X ${_data[index]['price']} =${_data[index]["total_var"]?? _data[index]['total']}",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          )






                        ],
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: Wrap(
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
                            Text(":${_data[index]["bonus_var"]??_data[index]["totBonusValue"]} ${(_data[index]["bonusType"]=='Gift')?'Pcs of ${_data[index]["giftName"]}':'\$'}"),

                          ],
                        ),
                      ),
                      trailing:Text("${_data[index]["updated_at"]}")

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
    var Resul=(await ParticipatedQuery().SearchSubmitQuickBonusEventOnline(BonusModel(uidUser:'',status:'confirm'),Topups(startlimit:limit,endlimit:_page))).data;

    setState(() {
      isLoading=false;
      if(Resul["result"].length<limit)
      {
        isLoading=false;
        hasMoreData=false;
      }
      _data.clear();

      _data.addAll(Resul["result"]);
    });


  }




//
}


