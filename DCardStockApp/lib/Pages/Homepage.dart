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
  List<dynamic>qrSearch = [];

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
  bool productSearch=false;
  bool  productSearchPopup=true;
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode?result;
  QRViewController?controller;
  var _groupVal ="male";

  bool optionVal=true;
  List items=["male","female","others","Keb2"];

  bool Cameravalue=false;
  bool Flashvalue=false;
  var ResultDatas;
  GlobalKey userBottomSheetKey = GlobalKey();

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

                    performSearch(text,"none");//note i must figure out how to avoid
                    searchText=text;
                  }else{


                    print("no search");

                  }

                },
                scanProductMethod: (){

                  scanProduct();
                },
                searchController: searchContro,
              ),

               if(productSearch)
                 Expanded(
                 child: ProductSearchList(addCartMethod:(dynamicData){
                  addCartPlus(dynamicData);

                 },searchResult:(Get.put(StockQuery()).dataSearch)),
                ),
              GestureDetector(
                onTap: ()  {
                  // Handle tap event here
                 // print('Icon tapped!');

                  scanUser();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.yellow), // Replace with your desired icon
                    SizedBox(width: 8.0), // Adjust the space between icon and text
                    Text('Favorite', style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ),
             // Center(child: Text("${(Get.put(StockQuery()).userProfile)["name"]}")),

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
                                ,uidUser:"${(Get.put(StockQuery()).userProfile)["uid"]}",subscriber:"${(Get.put(StockQuery()).order["resultData"][0]["uid"])}",inputData:"${inputDataText}"),Promotions(
                              token:"${(Get.put(StockQuery())).orderSum }",reach:"1200",gain:"350",uid:"PointSales1"
                            ))).data;
                          if(resultData["status"])
                          {
                          //print(resultData);

                            List<dynamic> orderVal=[
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
                          (Get.put(StockQuery()).updateOrder(orderVal));
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
                   List<dynamic> orderVal=[
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
                           (Get.put(StockQuery()).updateOrder(orderVal));
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

  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller!.resumeCamera();
    controller.scannedDataStream.listen((scanData) async{
      setState((){
        result=scanData;
      });
      //await scanMethod();
      //print("${result!.code}");
      if(result!=null)
        {
         // controller!.pauseCamera();

          bool containsProductCode = qrSearch.any((item) => item['productCode'] == result!.code);
          if(containsProductCode)
            {
              //data already scaned
              //print("already exist");
             // print("${(Get.put(StockQuery()).dataSearch).toString()}");
            }
          else{
            var listData={
              "productCode":result!.code
            };
            qrSearch.insertAll(0,[listData]);
            //print(qrSearch);
            searchQr(result!.code);


          }
          //
        }
    });
  }
  searchQr(result) async{
   // await performSearch("$result","gh");
    await performSearch("$result","gh");
  }

  void _onUserQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    // Start scanning when the bottom sheet is opened
    controller!.resumeCamera();
    controller.scannedDataStream.listen((scanData) async{
      setState((){
        result=scanData;
      });
      //await scanMethod();

      bool containsProductCode = qrSearch.any((item) => item['productCode'] == result!.code);
      if(containsProductCode)
      {
        //data already scaned
        //print("already exist");
        // print("${(Get.put(StockQuery()).dataSearch).toString()}");
      }
      else{
        var listData={
          "productCode":result!.code
        };
        qrSearch.insertAll(0,[listData]);
        //print(qrSearch);
        getCardDetail(result!.code);


      }

    });
  }
  getCardDetail(resultCode) async{
    (Get.put(StockQuery()).updateHideLoader(false));
    var resultData=(await CardQuery().GetDetailCardOnline(CardModel(uid:"$resultCode"))).data;
    if(resultData["status"])
    {
      if (controller!= null) {
        controller!.pauseCamera();
        //controller!.stopCamera();

        (Get.put(StockQuery()).updateHideLoader(true));
        setState(() {
          (Get.put(StockQuery()).updateUserProfile(resultData["UserDetail"]));
          (Get.put(StockQuery()).order)["resultData"][0]["name"]=resultData["UserDetail"]["name"];
        });
        //Get.close(1);
        Navigator.of(context).pop();
      }

      //print("result ${resultData["UserDetail"]}");


    }
    else{
     // controller!.stopCamera();
      if (controller!= null) {
        controller!.pauseCamera();
        (Get.put(StockQuery()).updateHideLoader(true));
        var userProfile =
        {
          "uid": "kebineericMuna_1674160265",
          "name": "unknown",

          "email": "on@gmail.com",
          "phone": "782389359",
          "Ccode": "+250",
          "country": "Rwanda",
          "initCountry": "none",
          "PhoneNumber": "+250782389359",
          "carduid": "TEALTD_7hEnj_1672352175"
        }
        ;
        setState(() {
          (Get.put(StockQuery()).updateUserProfile(userProfile));
          (Get
              .put(StockQuery())
              .order)["resultData"][0]["name"] = userProfile["name"];
        });
        // print("${(Get.put(StockQuery()).userProfile)}");
        Navigator.of(context).pop();
        //Get.close(1);
      }
    }
    //

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




        num totalVal = resultData["result"].fold(0, (previousValue, element) {
          // Convert 'totalAmount' to a num using double.parse
          num totalAmount = num.parse(element['totalAmount'].toString());

          // Add the converted totalAmount to previousValue
          return previousValue + totalAmount;
        });

        (Get.put(StockQuery()).updateSumOrder(totalVal));



        (Get.put(StockQuery()).updateOrder(resultData["result"]));


        //print(resultData);

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

  performSearch(String text,String statusSearch) async{


    try {
   bool searchHide=(statusSearch=='none')?true:false;//to check if is Qr search or no Qr
      var resultData=(await StockQuery().searchProduct(QuickBonus(uid:text,productName:'none',status:statusSearch))).data;
      if(resultData["status"])
      {

        setState(() {
          productSearch=searchHide;

          //(Get.put(StockQuery()).updateTextMessage("$text Added Successfully"));
          (Get.put(StockQuery()).updateHideProductList(false));
          dataSearch.clear();

          dataSearch.addAll(resultData["result"]);
          (Get.put(StockQuery()).updatedataSearch(dataSearch));
        });
        //print("hello ${Get.put(StockQuery().dataSearch)}");
      }
      else{
        setState(() {


          dataSearch.clear();
          (Get.put(StockQuery()).updatedataSearch(dataSearch));


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
        (Get.put(StockQuery()).updatedataSearch(dataSearch));



      });
    }
    } catch (e) {

    }


  }
  void addCartPlus(dynamic dynamicData) async{
    (Get.put(StockQuery()).updateHideLoader(false));
    bool containsProductCode = cartData.any((item) => item['productCode'] == dynamicData["productCode"]);

    num b=2;
   if(containsProductCode)
     {
       (Get.put(StockQuery()).updateHideLoader(true));
       (Get.put(StockQuery()).updateTextMessage("${dynamicData['ProductName']} Product already Added"));
       (Get.put(StockQuery()).updateHideProductList(true));


     }
   else{
    // print(containsProductCode);


    setState(() {

       showOveray=true;

      // productSearchPopup=false;
      // dataSearch.clear();


     });

     try {
       dynamicData["totalQty"]=((num.parse(dynamicData["req_qty"]))>1)?dynamicData["totalQty"]:1;
       dynamicData['totalAmount']=((num.parse(dynamicData["req_qty"]))>1)?dynamicData['totalAmount']:num.parse(dynamicData['price']);
       dynamicData['totalCount']=((num.parse(dynamicData["req_qty"]))>1)?dynamicData['totalQty']:1;
       num totalVal=((num.parse(dynamicData["req_qty"]))>1)?dynamicData["totalAmount"]+((Get.put(StockQuery()).orderSum)):(num.parse(dynamicData["price"]))+((Get.put(StockQuery()).orderSum));


       //print("${dynamicData["req_qty"]}");
       var resultData=(await StockQuery().placeOrder(QuickBonus(uid:dynamicData["productCode"],qty:dynamicData["req_qty"],subscriber:"${(Get.put(StockQuery()).order)["resultData"][0]["uid"]}"),User(uid: "kebineericMuna_1674160265"))).data;
        if(resultData["status"])
       {

       // print(cartData.length);

//here i must Add no assign Card Then Unknown else Card ClientName
        List<dynamic> orderVal=[
          {
            "name":"${(Get.put(StockQuery()).userProfile)["name"]}",
            "uid":resultData["OrderId"]
          }
        ];


         //print(resultData);
         setState(() {
           showOveray=false;

           (Get.put(StockQuery()).updateOrder(orderVal));
           (Get.put(StockQuery()).updateSumOrder(totalVal));


           cartData.insertAll(0,[dynamicData]);

           dataSearch.clear();
           //(Get.put(StockQuery()).updatedataSearch(dataSearch));

           (Get.put(StockQuery()).updateTextMessage("${dynamicData['ProductName']} Added Successfully"));
           (Get.put(StockQuery()).updateHideProductList(true));
           (Get.put(StockQuery()).updateHideLoader(true));

         });


       }
       else{

         setState(() {

           showOveray=false;
           dataSearch.clear();
           (Get.put(StockQuery()).updatedataSearch(dataSearch));

           (Get.put(StockQuery()).updateHideLoader(true));


         });
       }
     } catch (e) {

     }



   }








  }


  void scanProduct() async{

    Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
          Stack(
            children: [
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

                    // (result!=null)?Text("barcode Type ${describeEnum(result!.format)} Data ${result!.code}"): const Text("Scan Code"),
                    Center(child: Text("Text")),
                    GetBuilder<StockQuery>(
                      builder: (myController) {
                        //return Text('Data: ${(_controller.dataSearch).toString()}');

                        return
                          (myController.hideProductList)?
                          Text(myController.textMessage):
                          Expanded(
                            child:ProductSearchList(addCartMethod:(dynamicData){
                              addCartPlus(dynamicData);

                            },searchResult:(Get.put(StockQuery()).dataSearch)),
                          );


                      },
                    ),
                    //if(productSearchPopup)
                    SizedBox(height: 20,),
                    Expanded(
                        flex: 5,
                        child:Stack(
                          alignment:Alignment.bottomCenter,
                          children: [
                            QRView(key: qrkey,onQRViewCreated: _onQRViewCreated,
                              overlay: QrScannerOverlayShape(
                                borderColor: Colors.yellow,
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

                                    CameraSwitch(),
                                    //SizedBox(width: 10.0,),

                                    // SizedBox(width: 10.0,),
                                    FlashSwitch(),
                                    Image.asset(
                                      Flashvalue ? 'images/on.png' : 'images/off.png',
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
      qrSearch.clear();
    });

  }
  void scanUser() async{//not finished User


    Get.bottomSheet(

      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            Stack(
              key:userBottomSheetKey,
              children: [
                Container(

                  padding:EdgeInsets.all(5.0),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [

                      SizedBox(height: 20,),
                      Expanded(
                          flex: 5,
                          child:Stack(
                            alignment:Alignment.bottomCenter,
                            children: [
                              QRView(key: qrkey,
                                onQRViewCreated:
                                _onUserQRViewCreated,
                                overlay: QrScannerOverlayShape(
                                  borderColor: Colors.white,
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

                                      CameraSwitch(),
                                      //SizedBox(width: 10.0,),

                                      // SizedBox(width: 10.0,),
                                      FlashSwitch(),
                                      Image.asset(
                                        Flashvalue ? 'images/on.png' : 'images/off.png',
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
      qrSearch.clear();
    });

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
    required this.scanProductMethod,
    required this.searchController,
  }) : super(key: key);

  final void Function(String) searchMethod;
  final void Function() scanProductMethod;
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

                /*var resultData=(await StockQuery().viewUserTempOrder(QuickBonus(uid:"nyota"))).data;
                print(resultData);*/
                scanProductMethod();


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










