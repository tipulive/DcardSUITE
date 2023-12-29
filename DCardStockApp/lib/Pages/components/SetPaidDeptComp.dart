import 'dart:math';


import 'package:dStock/models/Participated.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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





class SetPaidDeptComp extends StatefulWidget {
  const SetPaidDeptComp({Key? key}) : super(key: key);

  @override
  State<SetPaidDeptComp> createState() => _SetPaidDeptCompState();
}

class _SetPaidDeptCompState extends State<SetPaidDeptComp> {

  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];
  List<dynamic> thisListOrder = [];
  List<dynamic> orderData = [];
  List<dynamic>qrDebt = [];


  var bottomResult=[];
  num countData=0;
  var resultData="";

  int _page=0;
  int limit=0;
  bool hasMoreData=true;
  bool isLoading=false;
  num qty_product=1;
  String productCode="";
  num inputData=0;

  bool cameraValue=false;
  bool flashValue=false;
  String clientOrder="";

  bool btnExpenseHide=false;
  bool btnExpenseEditHide=false;
  TextEditingController balance=TextEditingController();
  TextEditingController purpose=TextEditingController();
  TextEditingController commentData=TextEditingController();
  TextEditingController uidEdit=TextEditingController();

  TextEditingController balanceEdit=TextEditingController();
  TextEditingController purposeEdit=TextEditingController();
  TextEditingController commentDataEdit=TextEditingController();


  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode?result;
  QRViewController?controller;


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

        Padding(
          padding:EdgeInsets.fromLTRB(8,10,8,0),
          child: Card(
            elevation:0,
            margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
            //color:Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              //side: BorderSide(color:_data[0]["color_var"]??true?Colors.white:Colors.green, width: 2),
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

                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Total Dept:",
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

                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(

                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [

                            Icon(Icons.segment,color:Colors.orange,size:13,),
                            Text("${(_data.length>0)?_data[0]['totalDebt']:0}",style:GoogleFonts.pacifico(fontSize:15,color: Colors.orange,fontWeight: FontWeight.w700)),


                          ],
                        ),






                      ],
                    ),

                  ],
                ),
                trailing:Container(child:
                GestureDetector(
                    onTap: () async{

                      getDebtWidget();

                    },
                    child:Icon(Icons.grid_view,color:Colors.orange)
                )


                )

              //trailing: Text()
            ),
          ),
        ),



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
                                          text: "${_data[index]['Recipient']}",
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
                                    Text("Amount:${_data[index]['amount']}"),

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
    controller?.dispose();
    super.dispose();
  }
  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller!.resumeCamera();
    controller.scannedDataStream.listen((scanData) async{
      setState((){
        result=scanData;
      });
      //await scanMethod();
     // print("${result!.code}");
      if(result!=null)
      {
        // controller!.pauseCamera();

        bool containsProductCode = qrDebt.any((item) => item['cardUid'] == result!.code);
        if(containsProductCode)
        {
          //data already scaned
          print("already exist");

        }
        else{
          var listData={
            "cardUid":result!.code
          };
          qrDebt.insertAll(0,[listData]);

           getDebt(result!.code);


        }
        //
      }
    });
  }

  getDebt(qrScanData) async{
    try {
      (Get.put(StockQuery()).updatePaidDeptScanHide(true));
      (Get.put(StockQuery()).updateHideLoader(false));
      var resultData=(await StockQuery().getDebt(User(uid:'none',carduid:qrScanData))).data;
    //print(resultData);
      if(resultData["status"])
    {
      print(resultData["result"][0]);
      (Get.put(StockQuery()).updateHideLoader(true));
      (Get.put(StockQuery()).updatePaidDeptScanHide(false));
      (Get.put(StockQuery()).updateClientDebt(resultData["result"][0]));

     /* setState(() {
        (Get.put(StockQuery()).updateClientDebt(resultData["result"][0]));

      });*/

      print("${(Get.put(StockQuery()).clientDebt)}");




    }
    else{
      (Get.put(StockQuery()).updateHideLoader(true));

    }


    } catch (e) {

    }
  }
  paidDebt() async{
    try {
      (Get.put(StockQuery()).updateHideLoader(false));
      var resultData=(await StockQuery().paidDept(User(uid:"${(Get.put(StockQuery()).clientDebt)["uidUser"]}",inputData:inputData))).data;
      if(resultData["status"])
      {
        (Get.put(StockQuery()).clientDebt).clear();
        (Get.put(StockQuery()).updateHideLoader(true));

        (Get.put(StockQuery()).updateClientDebt(resultData["result"]));

      }
      else{
        (Get.put(StockQuery()).updateHideLoader(true));

      }


    } catch (e) {
      (Get.put(StockQuery()).updateHideLoader(true));
    }
  }
  Widget cameraSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
        activeColor: Colors.red,
        activeTrackColor: Colors.red.withOpacity(0.4),
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.blueAccent,

        value: cameraValue,
        onChanged:(value)async{
          setState((){
            this.cameraValue=value;

            //print(value);
          });
          await controller!.resumeCamera();
        }
    ),
  );
  Widget flashSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
        activeColor: Colors.red,
        activeTrackColor: Colors.red.withOpacity(0.4),
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.blueAccent,

        value:flashValue,
        onChanged:(value)async{
          setState((){
            flashValue=value;

            //print(value);
          });
          await controller!.toggleFlash();
        }
    ),
  );



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

    var resultData=(await StockQuery().viewPaidDept(Topups(startlimit:limit,endlimit:_page))).data;


    if(resultData["status"])
    {

      setState(() {
        isLoading=false;
        hasMoreData=false;

        if(resultData["result"]!=0)
        {
          _data.clear();
          _data.addAll(resultData["result"]);

        }


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
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                                                  // hintText: '   -${(((Get.put(HideShowState()).delivery)[index]["totalQty"])!=((Get.put(HideShowState()).delivery)[index]["totalCount"]))?(((Get.put(HideShowState()).delivery)[index]["totalQty"]-(Get.put(HideShowState()).delivery)[index]["totalCount"])):1}-',
                                                                  hintStyle: TextStyle(color: Colors.red),
                                                                  contentPadding: EdgeInsets.all(0),
                                                                  isDense: true,



                                                                ),
                                                                style: TextStyle(
                                                                  color: Colors.blue, // Set the text color to red

                                                                ),
                                                                onChanged: (text) {
                                                                  if((double.tryParse(text) != null)){
                                                                    (Get.put(HideShowState()).delivery)[index]["currentQty"]=num.parse(text);



                                                                    if(((Get.put(HideShowState()).delivery)[index]["totalQty"])>=(Get.put(HideShowState()).delivery)[index]["currentQty"])
                                                                    {
                                                                      print((Get.put(HideShowState()).delivery)[index]["currentQty"]);




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
                                                              ),
                                                              stepWidth: 0.5, // set minimum width to 100
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
                                                  icon: Icon(Icons.add_shopping_cart,
                                                      size: 23.0,
                                                      color: Colors.grey),
                                                  onPressed: () async{
                                                    productCode=thisListOrder[index]["productCode"];


                                                    //await stockCount(index);


                                                    num totCount=(((Get.put(HideShowState()).delivery)[index]["totalCount"]-(Get.put(HideShowState()).delivery)[index]["currentQty"])>=0)?(Get.put(HideShowState()).delivery)[index]["totalCount"]:0;
                                                    if(totCount>0)
                                                    {
                                                      var resultData=(await StockQuery().stockCount(Topups(uid:"${orderData[0]}"),QuickBonus(uid:"${productCode}",qty:"${(Get.put(HideShowState()).delivery)[index]["currentQty"]}",subscriber:"StockName",status:"status",description:"Delivered"), User(uid: "UidTransport",name:"refName"))).data;

                                                      if(resultData["status"])
                                                      {
                                                        Quickdata();
                                                        // thisOrder2();
                                                        setState(() {

                                                          (Get.put(HideShowState()).delivery)[index]["totalCount"]=(Get.put(HideShowState()).delivery)[index]["totalCount"]-(Get.put(HideShowState()).delivery)[index]["currentQty"];

                                                        });
                                                      }

                                                    }









                                                  },
                                                ),


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
            );
        },
      ),
    ).whenComplete(() {
      // Get.put(HideShowState()).isDelivery(0);
      //do whatever you want after closing the bottom sheet
    });

  }

  void getDebtWidget() async{

    Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            Stack(
              children: [
                Container(
                  padding:EdgeInsets.all(2.0),
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

                      // (result!=null)?Text("barcode Type ${describeEnum(result!.format)} Data ${result!.code}"): const Text("Scan Code"),

                      GetBuilder<StockQuery>(
                        builder: (_controller) {
                          //return Text('Data: ${_controller.data}');
                          return Column(
                            children: [
                              Padding(
                                padding:EdgeInsets.fromLTRB(8,5,8,0),
                                child: Card(
                                  elevation:0,
                                  margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                                  //color:Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    //side: BorderSide(color:_data[0]["color_var"]??true?Colors.white:Colors.green, width: 2),
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

                                                    Center(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: "${(Get.put(StockQuery()).clientDebt)["name"]}",
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

                                      subtitle: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(

                                            children: [
                                              Wrap(
                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                children: [

                                                  Text("DEPT",style:GoogleFonts.odorMeanChey(fontSize:16,color: Colors.green,fontWeight: FontWeight.w700)),


                                                ],
                                              ),
                                              Wrap(
                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                children: [

                                                  Icon(Icons.segment,color:Colors.orange,size:13,),
                                                  Text("${(Get.put(StockQuery()).clientDebt)["debt"]}",style:GoogleFonts.pacifico(fontSize:15,color: Colors.orange,fontWeight: FontWeight.w700)),


                                                ],
                                              ),








                                            ],
                                          ),

                                        ],
                                      ),
                                      trailing:Container(child:
                                      GestureDetector(
                                          onTap: () async{

                                            getDebtWidget();

                                          },
                                          child:Icon(Icons.grid_view,color:Colors.orange)
                                      )


                                      )

                                    //trailing: Text()
                                  ),
                                ),
                              ),

                            ],
                          );
                        },
                      ),
                      if((Get.put(StockQuery()).paidDeptScanHide))
                        Container(


          padding:EdgeInsets.fromLTRB(5,0,10,0),


          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          ),
          ),
          child: SingleChildScrollView(
          child: Column(
          children: [
          SizedBox(height: 5.0,),

          TextField(
          // controller: uidEdit,

          keyboardType: TextInputType.number,
          //obscureText: true,
          decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
          border: OutlineInputBorder(),
          labelText: 'Enter Amount',
          hintText: 'Enter Amount',
          hintStyle: TextStyle(
          color: Colors.grey,
          ),

          ),
            onChanged: (value){
              if((num.tryParse(value) != null)){
                setState((){
                  inputData=num.parse(value);

                  //print(value);
                });



              }




            },


          ),


            SizedBox(height: 2.0,),

          FloatingActionButton.extended(
          label: Text('Paid Dept'), // <-- Text
          backgroundColor: Colors.black,
          icon: Icon( // <-- Icon
          Icons.thumb_up,
          size: 24.0,
          ),
          onPressed: () =>{
            paidDebt()

          }),
          ],
          ),
          ),
          ),

                      SizedBox(height:2.0,),
                      //if(!(Get.put(StockQuery()).paidDeptScanHide))
                       Expanded(
                          flex: 5,
                          child:Stack(
                            alignment:Alignment.bottomCenter,
                            children: [
                              QRView(key: qrkey,onQRViewCreated: _onQRViewCreated,
                                overlay: QrScannerOverlayShape(
                                  borderColor: Colors.pink,
                                  borderRadius: 10,
                                  borderLength: 30,
                                  borderWidth: 10,
                                  cutOutSize: 300,
                                  // Add the laser effect

                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      cameraSwitch(),
                                      //SizedBox(width: 10.0,),

                                      // SizedBox(width: 10.0,),
                                      flashSwitch(),
                                      Image.asset(
                                        flashValue ? 'images/on.png' : 'images/off.png',
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          )

                      )




                    ],
                  ),
                ),
                GetBuilder<StockQuery>(
                  builder: (myLoadercontroller) {
                    //return Text('Data: ${_controller.data}');
                    return
                      (myLoadercontroller.hideLoader)?
                      Text(""):
                      Positioned.fill(
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.white70,
                            child: CircularProgressIndicator(),
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
      qrDebt.clear();
    });

  }
  editSpendingMethod() async{

    if(isLoading) return;
    isLoading=true;
    int limit=10;

    var resultData=(await StockQuery().editSpending(Topups(amount:"${balance}",purpose:"${purpose}",desc:"${commentData}"))).data;


    if(resultData["status"])
    {

      setState(() {
        isLoading=false;
        hasMoreData=false;

        if(resultData["result"]!=0)
        {
          _data.clear();
          _data.addAll(resultData["result"]);

        }


      });
      return true;
    }
    else{
      return false;
    }
  }






//
}


