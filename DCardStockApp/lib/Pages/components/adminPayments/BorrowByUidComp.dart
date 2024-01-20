import 'dart:math';



import '../../../Utilconfig/HideShowState.dart';
import '../../../models/QuickBonus.dart';

import '../../../models/Topups.dart';
import '../../../models/User.dart';
import 'package:get/get.dart';

import '../../../Query/StockQuery.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../SetPage.dart';





class BorrowByUidComp extends StatefulWidget {
  const BorrowByUidComp({Key? key}) : super(key: key);

  @override
  State<BorrowByUidComp> createState() => _BorrowByUidCompState();
}

class _BorrowByUidCompState extends State<BorrowByUidComp> {

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
  String totalAmount="0";
  String userid="";
  String options="false";
  num inputData=0;
  int maxLength = 15; // Set your desired maximum length








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
                            Text("${(_data.isNotEmpty)?_data[0]['borrowBalance']:0}",style:GoogleFonts.pacifico(fontSize:15,color: Colors.orange,fontWeight: FontWeight.w700)),

                          ],
                        ),






                      ],
                    ),

                  ],
                ),
                trailing:GestureDetector(
                    onTap: () async{

                      addSpending();

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
                                            text: "${_data[index]['amount']}",
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
                                      Text("UserName:${(_data[index]['name']).toLowerCase()}"),

                                    ],
                                  ),

                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [

                                      const Icon(Icons.segment,color:Colors.orange,size:13,),
                                      Text("Amount:${_data[index][' name']}"),

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
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Handle the first icon tap
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text('Confirmation'),
                                        content: Text('Do you want to Edit ${_data[index]['OrderId']} ?'),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(

                                              //primary: Colors.grey[300],
                                              backgroundColor: Colors.red,
                                              elevation:0,
                                            ),
                                            onPressed: () async{
                                              if(isLoading) return;
                                              isLoading=true;
                                              int limit=10;

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
                                ),

                                IconButton(
                                  icon: const Icon(Icons.grid_view,color:Colors.orange),
                                  onPressed: () async{
                                    // This function will be called when the icon is tapped.
                                    // thisOrder(_data[index],index);

                                    Get.to(() =>SetPage(dynamicMethod: () {
                                      return const BorrowByUidComp();
                                    }),arguments:{
                                      "title":"${_data[index]['AmountOwner']}",
                                      "totalAmount":_data[index]['amount'],
                                      "userid":_data[index]['OwnerDept']
                                    });


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
                          style: const TextStyle(color: Colors.deepOrange,fontSize: 10),
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
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    userid=arguments["userid"];
    totalAmount=arguments["totalAmount"];
    viewData('test',false);

  }
  viewData(nameVal,searchVal) async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;

    var resultData=(await StockQuery().viewSafeBorrow(Topups(startlimit:limit,endlimit:_page,name:nameVal,searchOption:searchVal,optionCase:options,uid:userid))).data;

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
  addSpendingMethod() async{

    try {
      (Get.put(StockQuery()).updateHideLoader(false));
      var resultData=(await StockQuery().addSpending(Topups(uid:safariId,name:safariName,amount:"$inputData",purpose:purpose.text,desc:commentData.text,optionCase:options))).data;
      if(resultData["status"])
      {
        viewData('test',false);
        (Get.put(StockQuery()).updateHideLoader(true));

        (Get.put(StockQuery()).updateClientDebt(resultData["result"]));

      }
      else{
        //print(resultData);
        (Get.put(StockQuery()).updateHideLoader(true));

      }


    } catch (e) {
      (Get.put(StockQuery()).updateHideLoader(true));
    }


  }

  void addSpending() async{

    Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            Stack(
              children: [
                Container(
                  padding:const EdgeInsets.all(2.0),
                  height: 320,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        // (result!=null)?Text("barcode Type ${describeEnum(result!.format)} Data ${result!.code}"): const Text("Scan Code"),

                        GetBuilder<StockQuery>(
                          builder: (controller) {
                            //return Text('Data: ${_controller.data}');
                            return Column(
                              children: [
                                Padding(
                                  padding:const EdgeInsets.fromLTRB(8,5,8,0),
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
                                                            text: "${(Get.put(StockQuery()).clientDebt)["name"]}",
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

                                                    Text("DEPT",style:GoogleFonts.odorMeanChey(fontSize:16,color: Colors.green,fontWeight: FontWeight.w700)),


                                                  ],
                                                ),
                                                Wrap(
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  children: [

                                                    const Icon(Icons.segment,color:Colors.orange,size:13,),
                                                    Text("${(Get.put(StockQuery()).clientDebt)["debt"]}",style:GoogleFonts.pacifico(fontSize:15,color: Colors.orange,fontWeight: FontWeight.w700)),


                                                  ],
                                                ),








                                              ],
                                            ),

                                          ],
                                        ),
                                        trailing:GestureDetector(
                                            onTap: () async{

                                              // getDebtWidget();

                                            },
                                            child:const Icon(Icons.grid_view,color:Colors.orange)
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


                            padding:const EdgeInsets.fromLTRB(5,0,10,0),


                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 5.0,),

                                  TextField(
                                    // controller: uidEdit,

                                    keyboardType: TextInputType.number,
                                    //obscureText: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
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
                                  const SizedBox(height: 10.0,),
                                  TextField(
                                    controller: purpose,

                                    maxLength: maxLength,
                                    //obscureText: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter  purpose Maximum 15',
                                      hintText: 'Purpose',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  const SizedBox(height: 10.0,),
                                  TextField(

                                    controller:commentData,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    //obscureText: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Comment',
                                      hintText: 'Comment',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),

                                  const SizedBox(height: 5.0,),

                                  FloatingActionButton.extended(
                                      label: const Text('Paid Dept'), // <-- Text
                                      backgroundColor: Colors.black,
                                      icon: const Icon( // <-- Icon
                                        Icons.thumb_up,
                                        size: 24.0,
                                      ),
                                      onPressed: () =>{
                                        //paidDebt()
                                        addSpendingMethod(),

                                      }),
                                ],
                              ),
                            ),
                          ),

                        const SizedBox(height:2.0,),
                        //if(!(Get.put(StockQuery()).paidDeptScanHide))





                      ],
                    ),
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

    });

  }
  editSpendingMethod() async{

    if(isLoading) return;
    isLoading=true;

    var resultData=(await StockQuery().editSpending(Topups(amount:"$balance",purpose:"$purpose",desc:"$commentData"))).data;


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
  void editSpending(indexData) {
    uidEdit.text=indexData["spendId"];
    balanceEdit.text=indexData["spending"];
    purposeEdit.text=indexData["purpose"];
    commentDataEdit.text=indexData["commentData"];
    Get.bottomSheet(

      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            Container(

              padding:const EdgeInsets.all(5.0),
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0,),
                      const Center(child: Text("Edit Spending")),
                      Center(child: Text("${indexData["spendId"]}")),
                      const SizedBox(height: 10.0,),
                      TextField(
                        controller: uidEdit,

                        keyboardType: TextInputType.number,
                        //obscureText: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Amount',
                          hintText: 'Enter Amount',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),

                        ),


                      ),
                      TextField(
                          controller: balanceEdit,

                          keyboardType: TextInputType.number,
                          //obscureText: true,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Enter Amount',
                            hintText: 'Enter Amount',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                          onChanged: (text) {
                            if((double.tryParse(text) != null)){
                              balanceEdit.text=text.toString();
                              setState(() {
                                btnExpenseEditHide=true;

                              });
                            }
                            else{
                              btnExpenseEditHide=false;
                            }
                          }

                      ),
                      const SizedBox(height: 10.0,),
                      TextField(
                        controller: purposeEdit,


                        //obscureText: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                          border: OutlineInputBorder(),
                          labelText: 'Purpose',
                          hintText: 'Purpose',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),

                        ),
                      ),
                      const SizedBox(height: 10.0,),
                      TextField(

                        controller:commentDataEdit,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        //obscureText: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                          border: OutlineInputBorder(),
                          labelText: 'Comment',
                          hintText: 'Comment',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),

                        ),
                      ),

                      const SizedBox(height: 10.0,),
                      if(btnExpenseEditHide)
                        FloatingActionButton.extended(
                            label: const Text('Submit Expense'), // <-- Text
                            backgroundColor: Colors.black,
                            icon: const Icon( // <-- Icon
                              Icons.thumb_up,
                              size: 24.0,
                            ),
                            onPressed: () =>{
                              editSpendingMethod()

                            }),
                    ],
                  ),
                ),
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


