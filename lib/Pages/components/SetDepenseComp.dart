import 'dart:math';


import 'package:dcard/Query/ParticipatedQuery.dart';
import 'package:dcard/Utilconfig/HideShowState.dart';
import 'package:dcard/models/QuickBonus.dart';

import 'package:dcard/models/Topups.dart';
import 'package:dcard/models/User.dart';
import 'package:get/get.dart';

import '../../Query/StockQuery.dart';
import '../../models/BonusModel.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';





class SetDepenseComp extends StatefulWidget {
  const SetDepenseComp({Key? key}) : super(key: key);

  @override
  State<SetDepenseComp> createState() => _SetDepenseCompState();
}

class _SetDepenseCompState extends State<SetDepenseComp> {

  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];
  List<dynamic> thisListOrder = [];
  List<dynamic> orderData = [];


  var bottomResult=[];

  int _page=0;
  int limit=0;
  bool hasMoreData=true;
  bool isLoading=false;
  num qty_product=1;
  String productCode="";

  String clientOrder="";
  String OrderId="";





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

        Text("Orders",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),



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

                var resultData=(await ParticipatedQuery().getSearchAllStockOnline(Topups(startlimit:limit,endlimit:_page),BonusModel(uidUser:'',productName:text))).data;
                if(resultData["status"])
                {
                  setState(() {
                    //print(Resul);
                    isLoading=false;
                    hasMoreData=false;
                    _data.clear();

                    _data.addAll(resultData["result"]);
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

                                Column(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "${_data[index]['name']}:",
                                          style: DefaultTextStyle.of(context).style,
                                          children: <TextSpan>[


                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [

                                    Icon(Icons.segment,color:Colors.orange,size:13,),
                                    Text("UID:${_data[index]['OrderId']}"),

                                  ],
                                ),

                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [

                                    Icon(Icons.segment,color:Colors.orange,size:13,),
                                    Text("Qty:${_data[index]['totalQty']}"),

                                  ],
                                ),

                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [

                                    Icon(Icons.segment,color:Colors.orange,size:13,),
                                    Text("Amount:${_data[index]['totalAmount']}"),

                                  ],
                                ),

                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [

                                    Icon(Icons.segment,color:Colors.orange,size:13,),
                                    Text("Deliver:${_data[index]['totalQty']-_data[index]['totalCount']}"),

                                  ],
                                ),


                              ],
                            ),

                          ],
                        ),
                      ),
                      trailing:Container(child:
                      GestureDetector(
                          onTap: () async{
                            // This function will be called when the icon is tapped.
                            // thisOrder(_data[index],index);



                            orderData=_data[index].values.toList();


                            //print((await thisOrder())["result"]);
                            var resultData=(await thisOrder());
                            //print(resultData);
                            if(resultData["status"]){



                              setState(() {
                                isLoading=false;
                                thisListOrder.clear();
                                thisListOrder.addAll(resultData["result"]);


                              });
                              viewThisOrder();
                            }

                            //


                          },
                          child:Icon(Icons.grid_view,color:Colors.orange)
                      )


                      )

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

  Quickdata()async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;

    var resultData=(await StockQuery().orderViewCount(Topups(startlimit:limit,endlimit:_page))).data;


    if(resultData["status"])
    {
      setState(() {
        isLoading=false;
        hasMoreData=false;


        _data.clear();
        _data.addAll(resultData["result"]);

      });
      return true;
    }
    else{
      return false;
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


    var resultData=(await StockQuery().orderViewByUid(Topups(uid:"${orderData[0]}",startlimit:limit,endlimit:_page))).data;
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
      Container(
        padding:EdgeInsets.all(5.0),
        height: 600,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Center(child: Text("ClientName:${orderData[1]}")),
            Center(child: Text("UID:${orderData[0]}")),

            Expanded(
              child: ListView.builder(


                itemCount:thisListOrder.length+1,
                itemBuilder: (context, index) {

                  if(index<thisListOrder.length)
                  {


                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Card(
                        elevation:0,
                        //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                        //color:Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          // side: BorderSide(color:_data[index]["color_var"]??true?Colors.white:Colors.green, width: 2),
                        ),

                        child: Column(
                          children: [
                            // Text("sum:${orderSum}"),
                            ListTile(
                                leading: CircleAvatar(
                                  child: Icon(_getRandomIcon()),
                                  backgroundColor:getRandomColor(),
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
                                              children: <TextSpan>[


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
                                                        child: TextField(


                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            hintText: '-1-',
                                                            hintStyle: TextStyle(color: Colors.red),
                                                            contentPadding: EdgeInsets.all(0),
                                                            isDense: true,



                                                          ),
                                                          style: TextStyle(
                                                            color: Colors.blue, // Set the text color to red

                                                          ),
                                                          onChanged: (text) {
                                                            if((double.tryParse(text) != null)){
                                                              qty_product=num.parse(text);

                                                            }

                                                            //print(this._data[index]["total_var"]);
                                                            // print("Text changed to: $text");
                                                          },
                                                        ),
                                                        stepWidth: 0.5, // set minimum width to 100
                                                      ),
                                                    ),

                                                  ]
                                              )
                                          ),
                                          Text("Deliver:${(thisListOrder[index]["totalQty"])-(thisListOrder[index]["totalCount"])}")


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


                                        IconButton(
                                          icon: Icon(Icons.add_shopping_cart,
                                              size: 23.0,
                                              color: Colors.grey),
                                          onPressed: () async{
                                            productCode=thisListOrder[index]["productCode"];
                                            await stockCount();

                                          },
                                        ) ,Visibility(
                                            visible:true,
                                            child: Text("")),
                                        IconButton(
                                          icon: Icon(
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
      ),
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });

  }

  stockCount()async
  {


    var resultData=(await StockQuery().stockCount(Topups(uid:"${orderData[0]}"),QuickBonus(uid:"${productCode}",qty:"${qty_product}",subscriber:"StockName",status:"status",description:"Delivered"), User(uid: "UidTransport",name:"refName"))).data;


    if(resultData["status"])
    {
      Quickdata();
      thisOrder2();

    }







  }



//
}

