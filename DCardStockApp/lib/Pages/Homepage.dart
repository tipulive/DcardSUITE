import 'dart:math';


import '../../../Query/CardQuery.dart';
import '../../../Query/TopupQuery.dart';
import '../../../Query/StockQuery.dart';
import '../../../models/CardModel.dart';
import '../../../models/QuickBonus.dart';
import '../../../models/Topups.dart';

import '../models/BonusModel.dart';

import '../Pages/ProfilePage.dart';
import '../Pages/QuickBonusPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:wakelock/wakelock.dart';
import 'package:get/get.dart';




import '../../../models/Participated.dart';

import '../../../models/Promotions.dart';
import '../Query/AdminQuery.dart';
import '../Pages/components/BottomNavigator/HomeNavigator.dart';


import 'package:cool_alert/cool_alert.dart';


import '../../../Query/PromotionQuery.dart';
import '../Query/ParticipatedQuery.dart';

import '../Utilconfig/HideShowState.dart';
import '../models/User.dart';



class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);



  @override
  State<Homepage> createState() => _HomepageState();


}
class _HomepageState extends State<Homepage> {

  List<dynamic> dataSearch = [];
  List<dynamic> cartData = [];
  PromotionQuery promotionState=Get.put(PromotionQuery());
  AdminQuery adminStatedata=Get.put(AdminQuery());
  //StockQuery stockQueryData=Get.put(StockQuery());
  String searchText = '';
  TextEditingController inputDataDept=TextEditingController();
  TextEditingController searchContro=TextEditingController();
  TextEditingController PromoName=TextEditingController();
  TextEditingController uidInput=TextEditingController();//uid promo
  TextEditingController uidInput2=TextEditingController(text:'kebineericMuna_1668935593');//userid of user that will be available after qr scan
  TextEditingController uidInput3=TextEditingController();//input data to submit
  TextEditingController uidInput4=TextEditingController();
  TextEditingController uidInput5=TextEditingController();
  TextEditingController ClientName=TextEditingController();
  String PromoMsg="none";
  bool showprofile=false;
  bool showOveray=false;
  bool IsSubmitted=false;
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode?result;
  QRViewController?controller;
  var _groupVal ="male";

  bool optionVal=true;
  List items=["male","female","others","Keb2"];

  bool Cameravalue=false;
  bool Flashvalue=false;
  var ResultDatas;

  @override

  @override
  Widget build(BuildContext context)
  {


    /*void reassemble(){
      super.reassemble();
      //controller!.resumeCamera();
      if(Platform.isAndroid)
      {
        controller!.resumeCamera();

      }else if (Platform.isIOS)
      {
        controller!.pauseCamera();
      }
    }*/

    //hidekeyboard();
    //UserQuery userQueryData = Get.put(UserQuery());



    // ParticipatedQuery participatedState=Get.put(ParticipatedQuery());

    //Map<String,dynamic> Promo_data=promotionState.obj["resultData"]??promotionState.obj;

    //FocusScope.of(context).unfocus();//hide keyboard on screen loadin
    return Scaffold(
      body:Stack(
        children: [
          Column(
            children: [
              //Qr Code
              SizedBox(height: 20,),
              // SearchBarField(search: _data,searchController:searchContro,PerformSearch:,),
              SearchBarField(
                // Correct: explicitly assigning null
                searchMethod:(text) async{
                  if (text!= searchText) {

                    performSearch(text);//note i must figure out how to avoid
                    searchText=text;
                  }else{


                    print("no search");

                  }

                },
                searchController: searchContro,
              ),

              Expanded(
                child: ProductSearchList(addCartMethod:(dynamicData){
                  addCartPlus(dynamicData);

                },searchResult:dataSearch),
              ),
              Text("My Cart"),
              ElevatedButton(
                style: ElevatedButton.styleFrom(

                  //primary: Colors.grey[300],
                  backgroundColor: Colors.green,
                  elevation:0,
                ),
                onPressed: () async{
                 /* setState(() {
                    cartData.removeWhere((item) => item['productCode'] == "webcam_1700726985");
                  });

                  print(cartData);*/
                  print(cartData.length);
                },
                child: Text('Check'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(

                  //primary: Colors.grey[300],
                  backgroundColor: Colors.green,
                  elevation:0,
                ),
                onPressed: () async{
                  //print((Get.put(StockQuery()).dataCartui));
                  List<dynamic> testdata=[
                    {
                      'name': 'bebese',
                      'uid': 'feke',
                      'productCode': 'Velo',
                      'productName': 'webcam',
                      'price': 30,
                      'pcs': 30,
                      'totalQty': 25,
                      'totalAmount': 750,
                      'totalCount': 25,
                    },
                    {
                      'name': 'bebese',
                      'uid': 'feke',
                      'productCode': 'Matabaro',
                      'productName': 'bido',
                      'price': 30,
                      'pcs': 20,
                      'totalQty': 30,
                      'totalAmount': 900,
                      'totalCount': 30,
                    },
                  ];
                  setState(() {
                    cartData.insertAll(0,testdata);
                    //cartData.addAll(testdata);
                  });
                  (Get.put(StockQuery()).updateOrder(testdata));
                },
                child: Text('Confirm Order'),
              ),
              Center(child: Text("${(Get.put(StockQuery()).order)["resultData"][0]["name"]}")),
               if(((Get.put(StockQuery()).order)["resultData"][0]["uid"])!="")
                 Center(child: Text("OrderId:${(Get.put(StockQuery()).order)["resultData"][0]["uid"]}")),
              Text("Total:${(Get.put(StockQuery()).orderSum)}"),
              Padding(
                padding: const EdgeInsets.fromLTRB(40,0,40,0),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5,0,5,0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.grey, // You can customize the border color
                    ),
                  ),
                  child: Row(

                    children: [
                      InkWell(
                        onTap: () {
                          // Perform an action when the "Delete" button is tapped

                          print('Delete Tapped. Entered Text: ');
                        },
                        child: Visibility(
                          visible: true,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                //topLeft: Radius.circular(10.0),
                                //bottomLeft: Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'Dept ${(Get.put(StockQuery()).dept)}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Enter Amount...',
                              border: InputBorder.none,
                            ),
                            controller: inputDataDept,
                            onChanged: (value){
                              if((double.tryParse(value) != null)){
                                num deptVal=(Get.put(StockQuery()).orderSum)-num.parse(value);
                                setState(() {
                                  (Get.put(StockQuery()).updateDeptOrder(deptVal));
                                });

                              }




                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async{
                         // print("${inputDataDept.text} ${(Get.put(StockQuery())).orderSum } ${Get.put(StockQuery().order["resultData"][0]["uid"])}");

                          // Perform an action when the "Confirm" button is tapped
                          setState(() {

                            showOveray=true;
                            // dataSearch.clear();


                          });

                         try {
                           var inputDataText=(inputDataDept.text=="")?"0":inputDataDept.text;

                            var resultData=(await StockQuery().submitOrder(Participated(uid:"Nyota_1672353378"
                                ,uidUser:"kebineericMuna_1674160265",subscriber:"${(Get.put(StockQuery()).order["resultData"][0]["uid"])}",inputData:"${inputDataText}"),Promotions(
                              token:"${(Get.put(StockQuery())).orderSum }",reach:"1200",gain:"350",uid:"PointSales1"
                            ))).data;
                          if(resultData["status"])
                          {
                          //print(resultData);

                            List<dynamic> OrderVal=[
                              {
                                "name":"Unknown",
                                "uid":""
                              }
                            ];
                          num totalVal=0;

                          (Get.put(StockQuery()).updateSumOrder(totalVal));

                          setState(() {
                          showOveray=false;
                          cartData.clear();
                          (Get.put(StockQuery()).updateOrder(OrderVal));
                          (Get.put(StockQuery()).updateDeptOrder(0));
                          inputDataDept.text="";

                            // dataSearch.clear();

                          });
                          }
                          else{

                          setState(() {

                          showOveray=false;



                          });
                          }
                          } catch (e) {
                           setState(() {

                             showOveray=false;



                           });
                          }

                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(child: CheckoutPage(chekoutResult:cartData,changeQtyCheckout:(index,price,valueData,checkHide){
                ChangeQtyMethod(index,price,valueData,checkHide);

              },saveChangeQtyCheckout:(productCode,indexData){
                saveChangeQtyMethod(productCode,indexData);
              },deleteCheckout:(productCode) async{

               print(await (Get.put(StockQuery()).order)["resultData"][0]["uid"]);

               try {


                 var resultData=(await StockQuery().deleteTSingleOrder(QuickBonus(productName:productCode,uid:await (Get.put(StockQuery()).order)["resultData"][0]["uid"] ))).data;
                 if(resultData["status"])
                 {
                   //print(resultData);
                   List<dynamic> OrderVal=[
                     {
                       "name":"Unknown",
                       "uid":""
                     }
                   ];
                   setState(() {
                     showOveray=false;
                     setState(() {
                       cartData.removeWhere((item) => item['productCode'] == productCode);
                       num totalVal = cartData.fold(0, (previousValue, element) => previousValue + element['totalAmount']);
                       (Get.put(StockQuery()).updateSumOrder(totalVal));

                       if(cartData.length<=0)
                         {
                           (Get.put(StockQuery()).updateOrder(OrderVal));
                         }
                     });

                   });


                 }
                 else{

                   setState(() {

                     showOveray=false;
                     dataSearch.clear();


                   });
                 }
               } catch (e) {

               }

               /*setState(() {
                  cartData.removeWhere((item) => item['productCode'] == productCode);
                  num totalVal = cartData.fold(0, (previousValue, element) => previousValue + element['totalAmount']);
                  (Get.put(StockQuery()).updateSumOrder(totalVal));
                });*/
              },)),

              // CheckoutPage(),




              Visibility(
                visible: true,
                child: Expanded(
                  flex: 0,
                  child: SingleChildScrollView(

                    child: Center(
                        child:Column(
                          children: [
                            (result!=null)?Text("barcode Type ${describeEnum(result!.format)} Data ${result!.code}"): const Text("Scan Code"),










                          ],
                        )

                    ),
                  ),
                ),
              ),
            ],
          ),
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
      ) ,
      bottomNavigationBar:HomeNavigator(),

      // This trailing comma makes auto-formatting nicer for build methods.

    );

  }

  ScanPopup(uid,name){

    Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height:400,

                  child: Column(
                    children: [
                      Container(

                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: ListView(
                          children: [

                            MyTextWidget(uid,name)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // height: 60,
                  //color: Colors.white,
                  child: HomeNavigator(),
                ),

                Positioned(
                  right: 15.0,
                  bottom:70,
                  child: FloatingActionButton(
                    onPressed:()async {
                      Get.put(HideShowState()).isVisible(true);
                      ResultDatas=(await Get.put(TopupQuery()).GetBalance(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}"))).data;
                      if(ResultDatas["status"])
                      {
                        await Get.put(TopupQuery()).updateTopupState(ResultDatas);
                        Get.put(HideShowState()).isVisible(false);
                        Get.to(() => ProfilePage());
                      }
                      else{

                        await Get.put(TopupQuery()).updateTopupState(ResultDatas);
                        Get.put(HideShowState()).isVisible(false);
                        Get.to(() => ProfilePage());
                      }


                    },
                    tooltip: 'Increment',
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("images/profile.jpg",
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                    child:  Obx(
                          () =>Visibility(
                        visible: Get.put(HideShowState()).isVisible.value,
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
                        visible: Get.put(HideShowState()).isVisible.value,
                        child: Container(
                          //padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                ),
              ],
            );
        },
      ),
    ).whenComplete(() {
      controller!.resumeCamera();
      //do whatever you want after closing the bottom sheet
    });
  }
  Widget MyTextWidget(uid,name){
    if((promotionState.obj["id"])==1) return Center(child: CircularProgressIndicator());
    PromoName.text="${(promotionState.obj["resultData"]["result"][0]["promoName"])}";
    PromoMsg=(promotionState.obj["resultData"]["result"][0]["promo_msg"]);
    uidInput.text="${(promotionState.obj["resultData"]["result"][0]["uid"])}";
    uidInput4.text="${(promotionState.obj["resultData"]["result"][0]["reach"])}";
    uidInput5.text="${(promotionState.obj["resultData"]["result"][0]["gain"])}";
    uidInput2.text="${uid}";
    ClientName.text="${name}";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(

        children: [
          Visibility(
              visible: true,
              child: Column(

                children: [

                  TextButton(
                      onPressed: ()  async{

                        try {
                          setState(() {
                            showOveray=true;
                          });
                          var resul=(await ParticipatedQuery().GetUidSubmitQuickBonusEventOnline(BonusModel(uidUser:'${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}'))).data;


                          if(resul["status"])
                          {
                            var dataresult=resul["resultData"];
                            for(int i=0;i<resul["count"];i++)
                            {
                              setState(() {
                                showOveray=false;
                                Get.put(ParticipatedQuery()).updateCartUi(resul,true,true);
                                Get.put(ParticipatedQuery()).dataCartui["countData"]["count"]=resul["count"];
                                Get.put(ParticipatedQuery()).dataCartui["products"]["${dataresult[i]["quickUid"]}"]=dataresult[i]["price"];

                                // Update the value of _counter and trigger a rebuild
                              });
                            }


                            Get.to(() => QuickBonusPage());


                          }
                          else{
                            //hide cart
                            setState(() {
                              Get.put(ParticipatedQuery()).updateCartUi(resul,false,false);
                              Get.put(ParticipatedQuery()).dataCartui["countData"]["count"]=0;


                              // Update the value of _counter and trigger a rebuild
                            });

                            Get.to(() => QuickBonusPage());


                          }


                        } catch (e) {
                          setState(() {
                            showOveray=false;
                          });
                          print('Error: $e');
                        }

                        //print(this._data[index]["total_var"]);
                        // print("Text changed to: $text");
                      },
                      child: const Text("QuickBonus Qr")
                  ),                  Center(child: Text(name)),
                  SizedBox(height:10.0,),
                  TextField(
                    controller:PromoName,
                    enabled: false,
                    //obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                      border: OutlineInputBorder(),
                      labelText: 'Promotion Name',
                      hintText: 'Promotion Name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),

                    ),
                  ),
                  Visibility(
                    visible:false,
                    child: TextField(
                      controller: uidInput,
                      //obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                        border: OutlineInputBorder(),
                        labelText: 'Uid of Promotion ',
                        hintText: 'Uid of Promotion',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Visibility(
                    visible:false,
                    child: TextField(
                      controller: uidInput2,
                      //obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                        border: OutlineInputBorder(),
                        labelText: 'UserID',
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),

                      ),
                    ),
                  ),
                  //SizedBox(height: 10.0,),
                  Visibility(
                    visible:false,
                    child: TextField(
                      controller: ClientName,
                      enabled: false,
                      //obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    controller: uidInput3,

                    //obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                      border: OutlineInputBorder(),
                      // labelText: 'Enter ${Promo_data["result"][0]["promo_msg"]}',${promotionState.obj["resultData"]["result"][0]["uid"]}
                      labelText: '${PromoMsg}',
                      hintText: 'InputData',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      suffixIcon:  GestureDetector(
                        child: Icon(Icons.settings),
                        onTap: () {
                          _groupVal=uidInput.text;
                          Get.dialog(
                            AlertDialog(
                              title: Center(child: const Text('Choose Promotion')),
                              content:SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: <Widget> [


                                    if(((Get.put(PromotionQuery()).obj)["id"])==1)...[Center(child: CircularProgressIndicator())],

                                    for(var i=0;i<(Get.put(PromotionQuery()).obj)["resultData"]["result"].length;i++)
                                      RadioListTile(
                                        title: Text("${i==null?"none":(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["promoName"]}"),
                                        value: "${i==null?"none":(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["uid"]}",
                                        //value:"${items[i]}",

                                        groupValue:_groupVal,
                                        onChanged: (value){

                                          this._groupVal=value.toString();
                                          //value="male";

                                          uidInput.text=this._groupVal;
                                          PromoName.text="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["promoName"]}";
                                          PromoMsg="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["promo_msg"]}";
                                          uidInput4.text="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["reach"]}";
                                          uidInput5.text="${(Get.put(PromotionQuery()).obj)["resultData"]["result"][i]["gain"]}";

                                          //print(_groupVal);
                                          //Get.back(result: value);
                                          Get.back();
                                        },
                                      ),

                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Close"),
                                  onPressed: () => Get.back(),
                                ),
                              ],
                            ),
                          );


                          // Perform some action when the icon is pressed
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Visibility(
                    visible:false,
                    child: TextField(
                      controller: uidInput4,
                      //obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                        border: OutlineInputBorder(),
                        labelText: 'reach',
                        hintText: 'reache',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Visibility(
                    visible:false,
                    child: TextField(
                      controller: uidInput5,
                      //obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                        border: OutlineInputBorder(),
                        labelText: 'gain',
                        hintText: 'gain',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),

                      ),
                    ),
                  ),



                  FloatingActionButton.extended(
                    label: Text('Participate'), // <-- Text
                    backgroundColor: Colors.black,
                    icon: Icon( // <-- Icon
                      Icons.thumb_up,
                      size: 24.0,
                    ),
                    onPressed: ()async =>{
                      Get.put(HideShowState()).isVisible(true),

                      /* setState(() {


                        showOveray=true;
                      }),*/


                      await Get.put(ParticipatedQuery()).ParticipateEventOnline(Participated(uid:uidInput.text,uidUser:uidInput2.text,inputData:uidInput3.text),Promotions(reach:uidInput4.text,gain:uidInput5.text)),
                      //print((Get.put(ParticipatedQuery()).obj)),
                      if((Get.put(ParticipatedQuery()).obj)["resultData"]["reach"]!=null)
                        {
                          /* setState(() {


                            showOveray=false;
                          }),*/
                          Get.put(HideShowState()).isVisible(false),
                          uidInput3.text="",
                          Get.close(1),
                          controller!.resumeCamera(),
                          CoolAlert.show(
                            context: context,
                            backgroundColor:Color(0xff940e4b),
                            type: CoolAlertType.success,
                            title:"Congratulation !!!",
                            text: "You Reach ${(Get.put(ParticipatedQuery()).obj)["resultData"]["reach"]}\$ and You win ${(Get.put(ParticipatedQuery()).obj)["resultData"]["gain"]} !",

                          ),



                          //Get.back(),

                        }else{
                        if((Get.put(ParticipatedQuery()).obj)["resultData"]["status"])
                          {
                            /*setState(() {

                              showOveray=false;
                            }),*/
                            Get.put(HideShowState()).isVisible(false),
                            uidInput3.text="",
                            Get.close(1),
                            controller!.resumeCamera(),

                            Get.snackbar("Success", "Data Submitted",backgroundColor: Color(0xff9a1c55),
                                colorText: Color(0xffffffff),
                                titleText: Text("Participate"),

                                icon: Icon(Icons.access_alarm),
                                duration: Duration(seconds: 5)),




                          },


                        //print((Get.put(ParticipatedQuery()).obj)),
                      },
                      //
                      //


                    },
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) async{
      setState((){
        result=scanData;
      });
      await scanMethod();
    });
  }
  scanMethod() async{

    // uidInput2.text="${result!.code}";
    //uidInput2.text="${(await Get.put(CardQuery()).GetDetailCardOnline(CardModel(uid:'${result!.code}')))["UserDetail"]["uid"]}";
    if(result!=null)
    {

      controller!.pauseCamera();
      setState(() {
        showOveray=true;
      });
      try {


        // controller!.pauseCamera();
        //controller!.pauseCamera();
        var ResultData=(await Get.put(CardQuery()).GetDetailCardOnline(CardModel(uid:'${result!.code}'))).data;
        if(ResultData["status"])
        {
          setState(() {
            showOveray=false;
          });

          //print(ResultData["UserDetail"]["uid"]);
          ScanPopup(ResultData["UserDetail"]["uid"],ResultData["UserDetail"]["name"]);
          (await Get.put(CardQuery()).updateCardState(ResultData));
        }
        else{
          controller!.pauseCamera();
          setState(() {
            showOveray=false;
          });
          CoolAlert.show(
            context: context,
            backgroundColor:Color(0xff940e4b),
            type: CoolAlertType.error,
            title:"Error !!!",
            text: "This Card is not exist",

          ).then((value) {
            // Event to trigger when the alert is dismissed
            controller!.resumeCamera();
          });
          //uidInput2.text="${ResultData["status"]}";
        }

      } catch (e) {
        setState(() {
          showOveray=false;
        });
        //return false;
        //print(e);
      }

    }
    else{

      setState(() {
        showOveray=false;
      });
      uidInput2.text="test";
    }



  }
  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  Widget CameraSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
        activeColor: Colors.red,
        activeTrackColor: Colors.red.withOpacity(0.4),
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.blueAccent,

        value: Cameravalue,
        onChanged:(value)async{
          setState((){
            this.Cameravalue=value;

            //print(value);
          });
          await controller!.resumeCamera();
        }
    ),
  );
  Widget FlashSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
        activeColor: Colors.red,
        activeTrackColor: Colors.red.withOpacity(0.4),
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.blueAccent,

        value:Flashvalue,
        onChanged:(value)async{
          setState((){
            this.Flashvalue=value;

            //print(value);
          });
          await controller!.toggleFlash();
        }
    ),
  );

  void initState()
  {
    super.initState();
    //getapi();
    cartDisplay();
    setState(() {
      showOveray=false;
    });
  }

//Method

  cartDisplay()async
  {



    try {

      var resultData=(await StockQuery().viewUserTempOrder(QuickBonus(uid:"nyota"))).data;
      if(resultData["status"])
      {
        num totalVal = resultData["result"].fold(0, (previousValue, element) => previousValue + element['totalAmount']);
       // (Get.put(StockQuery()).updateOrderId("${resultData["result"][0]["uid"]}"));

        (Get.put(StockQuery()).updateSumOrder(totalVal));

        (Get.put(StockQuery()).updateOrder(resultData["result"]));

        setState(() {


          cartData.clear();

          cartData.addAll(resultData["result"]);
        });
      }
      else{
        setState(() {


          cartData.clear();


        });
      }


    } catch (e) {

    }




  }

  void performSearch(String text) async{


    try {

      var resultData=(await StockQuery().searchProduct(QuickBonus(uid:text,productName:'none'))).data;
      if(resultData["status"])
      {

        setState(() {


          dataSearch.clear();

          dataSearch.addAll(resultData["result"]);
        });
      }
      else{
        setState(() {


          dataSearch.clear();


        });
      }


    } catch (e) {

    }



  }
  void ChangeQtyMethod(indexData,price,valueData,checkHide) {

if(checkHide)
  {
    setState(() {
      cartData[indexData]["saveChangeBtn"]=false;

    });
  }
else{

  setState(() {
    cartData[indexData]["saveChangeBtn"]=true;
    cartData[indexData]["totalAmount"]=price*valueData;
    cartData[indexData]["totalQty"]=valueData;

    num totalVal = cartData.fold(0, (previousValue, element) => previousValue + element['totalAmount']);
    //(Get.put(StockQuery()).updateSumOrder(totalVal));
  });

}






  }
  void saveChangeQtyMethod(productCode,indexData) async{


    //cartData[indexData]["totalAmount"]=price*valueData;
   // cartData[indexData]["totalQty"]=valueData;
    //print("${cartData[indexData]["totalQty"]}");
    try {
    var resultData=(await StockQuery().editTOrder(QuickBonus(productName:"${productCode}",qty:"${cartData[indexData]["totalQty"]}",uid:(Get.put(StockQuery()).order)["resultData"][0]["uid"]), User(uid:"kebineericMuna_1674160265"))).data;

    if(resultData["status"])
    {

      setState(() {
        showOveray=false;


        cartData[indexData]["saveChangeBtn"]=true;

        num totalVal = cartData.fold(0, (previousValue, element) => previousValue + element['totalAmount']);
        (Get.put(StockQuery()).updateSumOrder(totalVal));



      });


    }
    else{

      setState(() {

        showOveray=false;
        dataSearch.clear();


      });
    }
    } catch (e) {

    }


  }
  void addCartPlus(dynamic dynamicData) async{

    bool containsProductCode = cartData.any((item) => item['productCode'] == dynamicData["productCode"]);

    num b=2;
   if(containsProductCode)
     {
       print("product exist please");
     }
   else{
    // print(containsProductCode);


    setState(() {

       showOveray=true;
      // dataSearch.clear();


     });

     try {
       dynamicData["totalQty"]=((num.parse(dynamicData["req_qty"]))>1)?dynamicData["totalQty"]:1;
       dynamicData['totalAmount']=((num.parse(dynamicData["req_qty"]))>1)?dynamicData['totalAmount']:num.parse(dynamicData['price']);
       dynamicData['totalCount']=((num.parse(dynamicData["req_qty"]))>1)?dynamicData['totalQty']:1;
       num totalVal=((num.parse(dynamicData["req_qty"]))>1)?dynamicData["totalAmount"]+((Get.put(StockQuery()).orderSum)):(num.parse(dynamicData["price"]))+((Get.put(StockQuery()).orderSum));


       var resultData=(await StockQuery().placeOrder(QuickBonus(uid:dynamicData["productCode"],qty:dynamicData["req_qty"],subscriber:"${(Get.put(StockQuery()).order)["resultData"][0]["uid"]}"),User(uid: "kebineericMuna_1674160265"))).data;
       if(resultData["status"])
       {
         //{status: true, OrderId: UID_tb_1702314752}
     // {status: false, resultData: [{name: none, uid: none}]}
        print(cartData.length);

//here i must Add no assign Card Then Unknown else Card ClientName
        List<dynamic> OrderVal=[
          {
            "name":"Unknown",
            "uid":resultData["OrderId"]
          }
        ];


         //print(resultData);
         setState(() {
           showOveray=false;

           (Get.put(StockQuery()).updateOrder(OrderVal));
           (Get.put(StockQuery()).updateSumOrder(totalVal));


           cartData.insertAll(0,[dynamicData]);

           dataSearch.clear();

         });


       }
       else{

         setState(() {

           showOveray=false;
           dataSearch.clear();


         });
       }
     } catch (e) {

     }



   }




   /* setState(() {
      showOveray=true;


    });


    try {

      var resultData=(await StockQuery().placeOrder(QuickBonus(uid:dynamicData["productCode"],qty:dynamicData["req_qty"],productName:"none"),User(uid: "kebineericMuna_1674160265"))).data;
      if(resultData["status"])
      {
        //print(resultData);
        setState(() {
          showOveray=false;

          dataSearch.clear();

          dataSearch.addAll(resultData["result"]);
        });
      }
      else{
        print(dynamicData);
        setState(() {

          showOveray=false;
          dataSearch.clear();


        });
      }
    } catch (e) {

    }*/



  }

//method
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

class SearchBarField extends StatelessWidget {

  /*const SearchBarField({
    Key? key,
    required this.search,
    required this.searchController,
    required this.PerformSearch,
  }) : super(key: key);

  final dynamic search;
  final TextEditingController searchController;
  final VoidCallback PerformSearch;*/

  const SearchBarField({
    Key? key,
    required this.searchMethod,
    required this.searchController,
  }) : super(key: key);

  final void Function(String) searchMethod;
  final TextEditingController searchController;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          labelText: 'Search',
          suffixIcon: IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () async {
              try {

                var resultData=(await StockQuery().viewUserTempOrder(QuickBonus(uid:"nyota"))).data;
                print(resultData);


              } catch (e) {
                print(e);

              }
              // Handle scan button press
              // You can navigate to a scan screen or perform a scan action here
            },
          ),
        ),
        onChanged: (text) async{

          searchMethod(text);



        },
      ),
    );
  }
}

class ProductSearchList extends StatelessWidget {
  const ProductSearchList({
    Key? key,
    required this.addCartMethod,
    required this.searchResult,
  }) : super(key: key);
  final void Function(dynamic) addCartMethod;
  final dynamic searchResult;
  @override

  Widget build(BuildContext context) {

    return ListView.builder(


      itemCount: searchResult.length+1,
      itemBuilder: (context, index) {

        if(index<searchResult.length)
        {
          searchResult[index]['req_qty']="1";
          searchResult[index]['name']="none";




          return Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                    text:"${searchResult[index]["productCode"]} (${searchResult[index]["pcs"]} pcs):",
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: " 1X${searchResult[index]["price"]}",
                                        style: TextStyle(color: Colors.blue),


                                      ),

                                    ],
                                  ),
                                ),
                                Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Qty :',

                                          ),

                                          WidgetSpan(

                                            child: IntrinsicWidth(
                                              child: TextField(
                                                //controller: TextEditingController(text:"${_data[index]["textchange_var"]??_data[index]["qty"]}"),

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

                                                  if((double.tryParse(text) != null)){
                                                    searchResult[index]['req_qty']=text;
                                                    // print(searchResult[index]);

                                                    searchResult[index]['totalQty']=text;
                                                    searchResult[index]['totalAmount']=num.parse(searchResult[index]['price'])*num.parse(text);
                                                    searchResult[index]['totalCount']=text;


                                                  }




                                                },
                                              ),
                                              stepWidth: 0.5, // set minimum width to 100
                                            ),
                                          ),

                                        ]
                                    )
                                ),
                                SizedBox(height: 5,),
                                Text("Qty left:${num.parse(searchResult[index]["qty"])-num.parse(searchResult[index]["qty_sold"])}"),


                              ],
                            ),
                          )






                        ],
                      ),

                      subtitle: Wrap(
                        //crossAxisAlignment: WrapCrossAlignment.center,
                        children: [

                          Icon(Icons.segment,color:Colors.orange,size:13,),
                          Text("tags:${searchResult[index]["tags"]} "),



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
                                  addCartMethod(searchResult[index]);
                                },
                              ) ,Visibility(
                                  visible:true,
                                  child: Text("")),
                              IconButton(
                                icon: Icon(
                                    Icons.grid_view,
                                    size: 23.0,
                                    color: Colors.orange
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
                    visible: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8,0,8,8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("1088888880808  8766"),
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
    );
  }

}


class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    Key? key,
    required this.chekoutResult,
    required this.changeQtyCheckout,
    required this.saveChangeQtyCheckout,
    required this.deleteCheckout,
  }) : super(key: key);

  final dynamic chekoutResult;
  final void Function(int,num,num,bool) changeQtyCheckout;
  final void Function(String,int) saveChangeQtyCheckout;
  final void Function(String) deleteCheckout;


  @override
  Widget build(BuildContext context) {


    return ListView.builder(


      itemCount: chekoutResult.length+1,
      itemBuilder: (context, index) {

        if(index<chekoutResult.length)
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
                                    text:"${chekoutResult[index]["productCode"]} (${chekoutResult[index]["pcs"]} pcs):",
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "${chekoutResult[index]["totalQty"]}X${chekoutResult[index]["price"]}",
                                        style: TextStyle(color: Colors.blue),


                                      ),

                                    ],
                                  ),
                                ),
                                Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Qty :',

                                          ),

                                          WidgetSpan(

                                            child: IntrinsicWidth(
                                              child: TextField(
                                                //controller: TextEditingController(text:"${_data[index]["textchange_var"]??_data[index]["qty"]}"),

                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: '-${chekoutResult[index]["totalQty"]}-',
                                                  hintStyle: TextStyle(color: Colors.blue),
                                                  contentPadding: EdgeInsets.all(0),
                                                  isDense: true,



                                                ),
                                                style: TextStyle(
                                                  color: Colors.blue, // Set the text color to red

                                                ),
                                                onChanged: (text) {
                                              if((num.tryParse(text) != null) && (num.tryParse(text)!=0)){
                                                if(num.parse(text)>0)
                                                  {
                                                    changeQtyCheckout(index,(num.parse(chekoutResult[index]["price"])),(num.parse(text)),false);

                                                  }



                                              }else{
                                                changeQtyCheckout(index,1,1,true);
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

                               if((chekoutResult[index]["saveChangeBtn"])??false)
                                  IconButton(
                                   icon: Icon(Icons.add_shopping_cart,
                                    size: 23.0,
                                    color: Colors.grey),
                                onPressed: () async{
                                    saveChangeQtyCheckout("${chekoutResult[index]["productCode"]}",index);
                                    },
                                   ) ,
                              IconButton(
                                icon: Icon(
                                    Icons.delete,
                                    size: 23.0,
                                    color: Colors.red
                                ),
                                onPressed: () {
                                deleteCheckout("${chekoutResult[index]["productCode"]}");

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
                          Text("${chekoutResult[index]["totalAmount"]}"),
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
    );
  }

}










