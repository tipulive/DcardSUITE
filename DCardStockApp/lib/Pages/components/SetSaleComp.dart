import 'dart:math';


import '../../../Utilconfig/HideShowState.dart';

import '../../../models/Topups.dart';
import 'package:get/get.dart';

import '../../Query/StockQuery.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';





class SetSaleComp extends StatefulWidget {
  const SetSaleComp({Key? key}) : super(key: key);

  @override
  State<SetSaleComp> createState() => _SetSaleCompState();
}

class _SetSaleCompState extends State<SetSaleComp> {

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

        Padding(
          padding:const EdgeInsets.fromLTRB(8,10,8,0),
          child: Card(
            elevation:0,
            margin: const EdgeInsets.symmetric(vertical:1,horizontal:5),
            //color:Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              //side: BorderSide(color:_data[0]["color_var"]??true?Colors.white:Colors.green, width: 2),
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

                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Total:",
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

                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(

                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [

                            const Icon(Icons.segment,color:Colors.orange,size:13,),
                            Text("${(_data.isNotEmpty)?_data[0]['saleBalance']:0}",style:GoogleFonts.pacifico(fontSize:15,color: Colors.orange,fontWeight: FontWeight.w700)),


                          ],
                        ),






                      ],
                    ),

                  ],
                ),
                trailing:GestureDetector(
                    onTap: () async{



                    },
                    child:const Icon(Icons.grid_view,color:Colors.orange)
                )

              //trailing: Text()
            ),
          ),
        ),



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

              viewData(text,true);

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
                return Stack(
                  children: [
                    Card(
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
                          padding: const EdgeInsets.fromLTRB(0, 5, 0,5),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [

                                      const Icon(Icons.segment,color:Colors.orange,size:13,),
                                      Text("${_data[index]['OrderId']}"),

                                    ],
                                  ),

                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [

                                      const Icon(Icons.segment,color:Colors.orange,size:13,),
                                      Text("Amount:${_data[index]['totalPaid']}"),

                                    ],
                                  ),




                                ],
                              ),

                            ],
                          ),
                        ),
                        trailing: Stack(
                          children: [

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    // Handle the first icon tap
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text('Do you want to Edit ${_data[index]['OrderId']} ?'),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(

                                              //primary: Colors.grey[300],
                                              backgroundColor: Colors.red,
                                              elevation:0,
                                            ),
                                            onPressed: () async{


                                              var resultData=(await StockQuery().editOrder(Topups(uid:_data[index]['OrderId']))).data;

                                              if(resultData["status"])
                                              {



                                                if(resultData["result"]!=0)
                                                {
                                                  Get.toNamed('/home');
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

                                IconButton(
                                  icon: Icon(Icons.grid_view,color:Colors.orange),
                                  onPressed: () async{
                                    // This function will be called when the icon is tapped.
                                    // thisOrder(_data[index],index);



                                    orderData=_data[index].values.toList();
                                    print(orderData);


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
                                  },
                                ),
                              ],
                            ),

                          ],
                        ),

                        //trailing: Text()
                      ),
                    ),
                    Positioned(
                      top:10,
                      right: 28,


                      child: Center(
                        child: Text(
                          '${_data[index]['created_at']}',
                          style: TextStyle(color: Colors.deepOrange,fontSize: 10),
                        ),
                      ),
                    ),
                  ],
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
    viewData('test',false);

  }
  viewData(nameVal,searchVal) async{
    if(isLoading) return;
    isLoading=true;
    int limit=10;

    var resultData=(await StockQuery().viewSales(Topups(startlimit:limit,endlimit:_page,name:nameVal,searchOption:searchVal))).data;

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



                                                        ]
                                                    )
                                                ),
                                                Text("Deliver:${(((Get.put(HideShowState()).delivery)[index]["totalQty"])!=((Get.put(HideShowState()).delivery)[index]["totalCount"]))?(((Get.put(HideShowState()).delivery)[index]["totalQty"]-(Get.put(HideShowState()).delivery)[index]["totalCount"])):0}"),


                                              ],
                                            ),
                                          )






                                        ],
                                      ),


                                      trailing:Text("${thisListOrder[index]["totalAmount"]}"),

                                    //trailing: Text()
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

  stockCount(indexData)async
  {


    (Get.put(HideShowState())).isChangeDelivery(thisListOrder[indexData],indexData,qty_product);


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


