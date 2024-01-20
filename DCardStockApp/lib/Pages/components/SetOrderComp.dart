import 'dart:math';


import '../../../Query/ParticipatedQuery.dart';
import '../../../Utilconfig/HideShowState.dart';
import '../../../models/QuickBonus.dart';

import '../../../models/Topups.dart';
import '../../../models/User.dart';
import 'package:get/get.dart';

import '../../Query/StockQuery.dart';
import '../../models/BonusModel.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';





class SetOrderComp extends StatefulWidget {
  const SetOrderComp({Key? key}) : super(key: key);

  @override
  State<SetOrderComp> createState() => _SetOrderCompState();
}

class _SetOrderCompState extends State<SetOrderComp> {

  final ScrollController _scrollController = ScrollController();// detect scroll
  final List<dynamic> _data = [];
  List<dynamic> thisListOrder = [];
  List<dynamic> orderData = [];


  var bottomResult=[];
  num countData=0;

  int _page=0;
  int limit=0;
  bool hasMoreData=true;
  bool isLoading=false;
num qtyProduct=1;
  String productCode="";

  String clientOrder="";
String orderId="";





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
                child: const CircularProgressIndicator(),
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
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                  quickdata();
                }


              } catch (e) {
                //print('Error: $e');
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

                _data[index]['focusNode']=test;
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
                        backgroundColor:getRandomColor(),
                        child: Icon(_getRandomIcon()),
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
                                          children: const <TextSpan>[


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

                                    const Icon(Icons.segment,color:Colors.orange,size:13,),
                                    Text("UID:${_data[index]['OrderId']}"),

                                  ],
                                ),

                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [

                                    const Icon(Icons.segment,color:Colors.orange,size:13,),
                                    Text("Qty:${_data[index]['totalQty']}"),

                                  ],
                                ),

                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [

                                    const Icon(Icons.segment,color:Colors.orange,size:13,),
                                    Text("Amount:${_data[index]['totalAmount']}"),

                                  ],
                                ),

                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [

                                    const Icon(Icons.segment,color:Colors.orange,size:13,),
                                    Text("Deliver:${num.parse(_data[index]['totalQty'])-num.parse(_data[index]['totalCount'])}"),



                                  ],
                                ),


                              ],
                            ),

                          ],
                        ),
                      ),
                      trailing:GestureDetector(
                          onTap: () async{
                            // This function will be called when the icon is tapped.
                           // thisOrder(_data[index],index);



                              orderData=_data[index].values.toList();


                           //print((await thisOrder())["result"]);
                          thisOrder(_data[index]['OrderId']);

                             // print((stockQuery.dispatchOrder)[0]);

                              viewThisOrder();


                            // viewThisOrder();




                              //


                          },
                          child:const Icon(Icons.grid_view,color:Colors.orange)
                      )

                    //trailing: Text()
                  ),
                );

              }
              else{
                return  Padding(
                  padding:const EdgeInsets.symmetric(vertical: 32),
                  child:Center(
                      child:hasMoreData?
                      const CircularProgressIndicator()
                          :const Text("no more Data")

                  ),
                );
              }

            },
          ),
        ),
      ],
    );
  }
  @override
  void initState()
  {
    super.initState();
    //getapi();

    quickdata();
    _scrollController.addListener(_scrollListener);

  }
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _page=_page+10;

      quickdata();
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

  quickdata()async
  {


    var resultData=(await StockQuery().orderViewCount(Topups(startlimit:limit,endlimit:_page))).data;

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

  thisOrder(orderId)async
  {

    (Get.put(StockQuery()).updateHideLoader(false));

    //var resultData=(await StockQuery().orderViewByUid(Topups(uid:"${orderData[0]}",startlimit:limit,endlimit:_page))).data;
    var resultData=(await StockQuery().orderViewByUid(Topups(uid:orderId,startlimit:limit,endlimit:_page))).data;

    if(resultData["status"])
    {
      (Get.put(StockQuery()).updateHideLoader(true));

                (Get.put(StockQuery()).updateDispatchOrder(resultData["result"]));
    //  print(resultData["result"]);



//print(orderId);
     /* final stockQuery = Get.put(StockQuery());
      print((stockQuery.dispatchOrder)[0]);*/


    }
    else{
      //return false;
    }




  }
  void viewComment(commentData){
    Get.bottomSheet(
     Container(
    height: 200,
    padding: EdgeInsets.all(16),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('${commentData}'),
    SizedBox(height: 20),

    ],
    ),
    ),
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
    );
  }

  void viewThisOrder() {



    Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            Stack(
              children: [
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

                      GetBuilder<StockQuery>(
                        builder: (_controller) {
                          return  Expanded(
                              child:ListView.separated(
                                itemCount:(_controller.dispatchOrder).length+1,
                                itemBuilder: (context, index) {
                                  if(index<(_controller.dispatchOrder).length) {

                                    (Get.put(HideShowState())).isDelivery(_controller.dispatchOrder);
                                    return Card(
                                      elevation: 0,
                                      child: ListTile(
                                          title: Row(
                                            children: [
                                              Expanded(

                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    RichText(
                                                      text: TextSpan(
                                                        text:"${_controller.dispatchOrder[index]["productName"]} (${_controller.dispatchOrder[index]["pcs"]} pcs):",
                                                        style: DefaultTextStyle.of(context).style,
                                                        children: const <TextSpan>[


                                                        ],
                                                      ),
                                                    ),
                                                    Text("Price:${(_controller.dispatchOrder[index]["price"])}"),


                                                    Text.rich(
                                                        TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: 'Qty ${_controller.dispatchOrder[index]["totalQty"]}:',

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



                                                                        if((num.parse((Get.put(HideShowState()).delivery)[index]["totalQty"]))>=(Get.put(HideShowState()).delivery)[index]["currentQty"])
                                                                        {
                                                                          // print((Get.put(HideShowState()).delivery)[index]["currentQty"]);




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
                                                    Text("Deliver:${(((Get.put(HideShowState()).delivery)[index]["totalQty"])!=((Get.put(HideShowState()).delivery)[index]["totalCount"]))?((num.parse((Get.put(HideShowState()).delivery)[index]["totalQty"])-num.parse((Get.put(HideShowState()).delivery)[index]["totalCount"]))):0}"),


                                                  ],
                                                ),
                                              )






                                            ],
                                          ),
                                          // subtitle: Text('Subtitle for ${_controller.dispatchOrder[index]["price"]}'),
                                          leading: Icon(Icons.star),
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
                                                        productCode=_controller.dispatchOrder[index]["productCode"];


                                                        //await stockCount(index);


                                                        num totCount=((num.parse((Get.put(HideShowState()).delivery)[index]["totalCount"])-(Get.put(HideShowState()).delivery)[index]["currentQty"])>=0)?num.parse((Get.put(HideShowState()).delivery)[index]["totalCount"]):0;
                                                        if(totCount>0)
                                                        {
                                                          var resultData=(await _controller.stockCount(Topups(uid:"${orderData[0]}"),QuickBonus(uid:productCode,qty:"${(Get.put(HideShowState()).delivery)[index]["currentQty"]}",subscriber:"StockName",status:"status",description:"Delivered"), User(uid: "UidTransport",name:"refName"))).data;

                                                          if(resultData["status"])
                                                          {
                                                            //thisOrder(orderData[0]);
                                                            quickdata();
                                                            // thisOrder2();

                                                            setState(() {

                                                              num dats=(num.parse((Get.put(HideShowState()).delivery)[index]["totalCount"]))-(Get.put(HideShowState()).delivery)[index]["currentQty"];
                                                              (Get.put(HideShowState()).delivery)[index]["totalCount"]="$dats";


                                                            });
                                                          }

                                                        }









                                                      },
                                                    ),
                                                  GetBuilder<StockQuery>(
                                                    builder: (myLoadercontroller) {
                                                      //return Text('Data: ${_controller.data}');
                                                      return IconButton(
                                                        icon: const Icon(
                                                            Icons.mark_unread_chat_alt,
                                                            size: 23.0,
                                                            color: Colors.red
                                                        ),
                                                        onPressed: () {
                                                          viewComment("${(myLoadercontroller.dispatchOrder[index])["commentData"]}");

                                                        },
                                                      );
                                                    },
                                                  ),



                                                ],
                                              ),

                                            ],
                                          )
                                      ),
                                    );
                                  }else{
                                    return Text("");
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  );
                                },
                              ));

                        },
                      ),
                    ],
                  ),
                ),
                GetBuilder<StockQuery>(
                  builder: (myLoadercontroller) {
                    //return Text('Data: ${_controller.data}');
                    return
                      (myLoadercontroller.hideLoader)?
                      const Text(""):
                      Positioned.fill(
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.white70,
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                      );
                  },
                ),
              ],
            );
        },
      ),
    ).whenComplete(() {
     // Get.put(HideShowState()).isDelivery(0);
      //do whatever you want after closing the bottom sheet
    });

  }

  stockCount(indexData)async
  {


    (Get.put(HideShowState())).isChangeDelivery(thisListOrder[indexData],indexData,qtyProduct);


   // print((Get.put(HideShowState()).delivery)[indexData]);
    //print(thisListOrder[indexData]);





    /*var resultData=(await StockQuery().stockCount(Topups(uid:"${orderData[0]}"),QuickBonus(uid:"${productCode}",qty:"${qty_product}",subscriber:"StockName",status:"status",description:"Delivered"), User(uid: "UidTransport",name:"refName"))).data;


    if(resultData["status"])
    {
      Quickdata();
      thisOrder2();

    }*/







  }



//
}


