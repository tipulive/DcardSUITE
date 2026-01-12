import 'dart:math';


import 'package:qr_code_scanner/qr_code_scanner.dart';


import '../../../Utilconfig/HideShowState.dart';
import '../../../models/QuickBonus.dart';

import '../../../models/Topups.dart';
import '../../../models/User.dart';
import 'package:get/get.dart';

import '../../Query/StockQuery.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../../Pages/components/checkAppVersion.dart';
import '../../Utilconfig/ConstantClassUtil.dart';
import '../../Query/TextListController.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';





class SetDeptComp extends StatefulWidget {
  const SetDeptComp({Key? key}) : super(key: key);

  @override
  State<SetDeptComp> createState() => _SetDeptCompState();
}

class _SetDeptCompState extends State<SetDeptComp> {
  final StockQuery myStockQuery = Get.find<StockQuery>();
  final ScrollController _scrollController = ScrollController();// detect scroll
  final List<dynamic> _data = [];
  List<dynamic> thisListOrder = [];
  List<dynamic> orderData = [];
  List<dynamic>qrDebt = [];

  var bottomResult=[];
  num countData=0;

  int _page=0;
  int limit=0;
  bool hasMoreData=true;
  bool isLoading=false;
  num qtyProduct=1;
  String productCode="";
  num inputData=0;
  bool cameraValue=false;
  bool flashValue=false;

  String clientOrder="";
  String orderId="";
  String viewOption="false";

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
             color:Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              //side: BorderSide(color:_data[0]["color_var"]??true?Colors.white:Colors.green, width: 2),
            ),

            child: ListTile(
                leading: GestureDetector(
                  onTap: (){
                    getDebtWidget();
                  },
                  child: CircleAvatar(
                    backgroundColor:getRandomColor(),
                    child: Icon(_getRandomIcon()),
                  ),
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
                            Text("${(_data.isNotEmpty)?_data[0]['totDept']:0}",style:GoogleFonts.pacifico(fontSize:15,color: Colors.orange,fontWeight: FontWeight.w700)),



                          ],
                        ),






                      ],
                    ),

                  ],
                ),
                trailing:PopupMenuButton(
                  itemBuilder:(container)=>[
                    PopupMenuItem(
                        child: InkWell(
                          onTap: () async{
                            setState(() {
                              viewOption="false";
                            });
                            await viewData('test',false);
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left:10.0),
                                    child: Text("View"),
                                  ),

                                ],
                              ),
                              const Divider(
                                height: 20, // Adjust the height as needed
                                thickness: 0.2, // Adjust the thickness as needed
                                color: Colors.grey,
                              ),

                            ],
                          ),
                        )
                    ),
                    PopupMenuItem(
                        child:InkWell(
                          onTap: () async{
                            //print("type All");
                            setState(() {
                              viewOption="true";
                            });
                            await viewData('test',false);

                          },
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.apartment,
                                    color: Colors.orange,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left:10.0),
                                    child: Text("Company"),
                                  ),

                                ],
                              ),
                              const Divider(
                                height: 20, // Adjust the height as needed
                                thickness: 0.2, // Adjust the thickness as needed
                                color: Colors.grey,
                              ),

                            ],
                          ),
                        )
                    ),

                  ],
                  offset: const Offset(0, 40),
                  child:InkWell(

                    child: Ink(
                      decoration: ShapeDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        shape: const CircleBorder(),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(

                          Icons.visibility, // Replace with your desired icon
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                ),

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
                return Card(
                  elevation:0,
                  //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                  color:Colors.white,
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
                                    Text("Dept:${_data[index]['debt']}"),

                                  ],
                                ),
                                if(viewOption=='true')
                                   Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [

                                    const Icon(Icons.segment,color:Colors.orange,size:13,),
                                    Text("By:${_data[index]['adminName']}"),

                                    ],
                                  ),

                              ],
                            ),


                          ],
                        ),
                      ),
                      trailing:GestureDetector(
                          onTap: () async{

                            showConfirmBottomSheet(_data[index]['myDeptId'],_data[index]['name']);
                            /*Map<String, dynamic> clientDebt=
                            {
                              "debt":_data[index]['debt'],
                              "uidUser":_data[index]['myDeptId'],
                              "name":_data[index]['name']
                            };
                            (Get.put(StockQuery()).updateClientDebt(clientDebt));
                            (Get.put(StockQuery()).updatehideComp(false));

                            getDebtWidget();*/


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

  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller.resumeCamera();
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
        (Get.put(StockQuery()).updateHideLoader(true));
        (Get.put(StockQuery()).updatePaidDeptScanHide(false));
        (Get.put(StockQuery()).updateClientDebt(resultData["result"][0]));

        /* setState(() {
        (Get.put(StockQuery()).updateClientDebt(resultData["result"][0]));

      });*/





      }
      else{
        (Get.put(StockQuery()).updateHideLoader(true));

      }


    } catch (e) {
    return e;
    }
  }
  void showConfirmBottomSheet(userProf,name) async{
    String userProfile=userProf;
    // Initialize the controller
    final TextListController logic = Get.put(TextListController());
    String userName=name;
    final response = await myStockQuery.checkUserDept(User(uid:userProfile));

    if (response != null) {
      final result=response.data;
      if(result["status"])
      {
        setState(() {

          isLoading=false;
          // dataSearch.clear();


        });
        final users=result["result"];
        final totalD = ConstantClassUtil().calcTotObjJSon(users, 'dettes');

        // Output: 460
        //
        final double heightFactor = (users.length>1) ? 0.7 : 0.5;
        Get.bottomSheet(
          Container(
            height: Get.height * heightFactor,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 5),

                  // Title
                  const Text(
                    "Confirm?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text("Total dettes:${totalD.toString()}"),
                  const SizedBox(height: 5),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // YES action
                        },
                        child: const Text("Yes"),
                      ),
                      OutlinedButton(
                        onPressed: Get.back,
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 0),

                  // User list
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (_, index) {
                        final user = users[index];
                        return UserCard(
                          myIndex:index,
                          client:userProfile,
                          clientName:userName,
                          name: user["Name"]!,
                          uidOwner:user["uid"]!,
                          price: user["dettes"]!,
                          // We pass the controller tied to this specific UID
                          controller: logic.getController(user["uid"]),


                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        );
        //
      }else{
        setState(() {

          isLoading=false;
          // dataSearch.clear();


        });
        if(result["result"]==1){
          checkAppVersion(title: "error", message: result["error"],primaryButtonText:"Download",primaryButtonUrl: result["downNew"]);
        }
      }
    } else {
      setState(() {

        isLoading=false;
        // dataSearch.clear();


      });
    }

  }
  paidDebt() async{
    try {
      (Get.put(StockQuery()).updateHideLoader(false));
      var resultData=(await StockQuery().paidDept(User(uid:"${(Get.put(StockQuery()).clientDebt)["uidUser"]}",inputData:inputData))).data;
      if(resultData["status"])
      {
        viewData('test',false);

        (Get.put(StockQuery()).clientDebt).clear();
        (Get.put(StockQuery()).updateHideLoader(true));

        (Get.put(StockQuery()).updateClientDebt(resultData["result"]));
        if((Get.put(StockQuery()).hideComp))
          {

          }
        else{
          Future.microtask(() {
            Navigator.of(context).pop();
          });
        }
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
            cameraValue=value;

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

  quickData()
  {
    viewData('test',false);

  }
  viewData(nameVal,searchVal) async{
    if(isLoading) return;
    isLoading=true;
    int limit=10;

    var resultData=(await StockQuery().viewDept(Topups(startlimit:limit,endlimit:_page,name:nameVal,searchOption:searchVal,optionCase:viewOption))).data;

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

  void getDebtWidget() async{

    Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            Stack(
              children: [
                Container(
                  padding:const EdgeInsets.all(2.0),
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
                                  color:Colors.white,
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

                                                  Text("Dept",style:GoogleFonts.poppins(fontSize:14,color: Colors.green,fontWeight: FontWeight.w700)),

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


                                const SizedBox(height: 2.0,),

                                FloatingActionButton.extended(
                                    label: const Text('Paid Dept'), // <-- Text
                                    backgroundColor: Colors.black,
                                    icon: const Icon( // <-- Icon
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
                    if((Get.put(StockQuery()).hideComp))
                         const SizedBox(height:2.0,),
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
      (Get.put(StockQuery()).updatehideComp(true));
      qrDebt.clear();
    });

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
                              elevation:0,
                              //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                              color:Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                // side: BorderSide(color:_data[index]["color_var"]??true?Colors.white:Colors.green, width: 2),
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


class UserCard extends StatelessWidget {

  final String client;
  final String clientName;
  final String name;
  final String uidOwner;
  final int price;
  final int myIndex;
  final TextEditingController controller; // Added this


  const UserCard({
    super.key,
    required this.client,
    required this.clientName,
    required this.name,
    required this.uidOwner,
    required this.price,
    required this.myIndex,
    required this.controller,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              // Drag indicator
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Left Side: Icon and Text
                    const Icon(Icons.person, color: Colors.blue),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( ConstantClassUtil().truncateWithEllipsis(ConstantClassUtil().capitalizeFirstLetter(name), 12), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        const Text("Name", style: TextStyle(color: Colors.grey,fontSize: 15)),
                      ],
                    ),

                    // THE MAGIC: This pushes everything after it to the far right
                    const Spacer(),

                    // Right Side: Buttons
                    IconButton(
                      visualDensity: VisualDensity.compact, // Makes button smaller to save space
                      icon: const Icon(Icons.grid_4x4_rounded, color: Colors.grey),
                      onPressed: () {},
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact, // Makes button smaller to save space
                      icon: const Icon(Icons.grid_4x4_rounded, color: Colors.orange),
                      onPressed: () {},
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.share, color: Colors.blueAccent),
                      onPressed: ()async{
                        final int phone=250790954158;
                        String amount = controller.text;
                        String shareMsg = "Muraho, $clientName Afite Ideni rya ${price.toString()} Asabwa kwishyura $name .";

                        // Call the function
                        await shareToWhatsApp("", shareMsg);
                      },
                    ),
                  ],
                ),
              ),

              const Divider(),

              ListTile(
                leading:
                const Icon(Icons.monetization_on, color: Colors.orange),
                title: Text(
                  price.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text("Price"),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 8,left: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextField(
                      controller: controller, // Linked here,
                    textInputAction: TextInputAction.search,

                    decoration: InputDecoration(
                      hintText: 'Ayo Ngiye Kwishyura',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 4),

                        child: TextButton.icon(
                          icon: const Icon(Icons.payment, size: 18),
                          label: const Text('Pay'),
                          onPressed:(){
                            //print(price);
                            var amount=controller.text;
                            Get.dialog(
                              AlertDialog(
                                title: const Text('Confirmation?'),
                                content: Text.rich(
                                  TextSpan(
                                    text: 'urashakako ', // Normal text
                                    style: const TextStyle(color: Colors.black, fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: ConstantClassUtil().capitalizeFirstLetter(clientName),
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const TextSpan(text: ' Yishyura '), // Normal text
                                      TextSpan(
                                        text: ConstantClassUtil().capitalizeFirstLetter(name),
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const TextSpan(text: ' amafaranga '), // Normal text
                                      TextSpan(
                                        text: amount,
                                        style: const TextStyle(
                                          color: Colors.orange, // Yellow is often hard to read, Orange/Amber is safer
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.black12, // Optional: add a tiny background to make yellow pop
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(

                                      //primary: Colors.grey[300],
                                      backgroundColor: Colors.red,
                                      elevation:0,
                                    ),
                                    onPressed: () async{



                                    },
                                    child: const Text('Yes',style:TextStyle(
                                        color: Colors.white
                                    ),),
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
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),

                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> shareToWhatsApp(String phone, String message) async {
    // 1. Prepare the URI
    // If phone is empty, it opens the contact picker in WhatsApp
    final String url = "whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message)}";
    final Uri uri = Uri.parse(url);

    try {
      // 2. Check if the URL can actually be opened
      bool canLaunch = await canLaunchUrl(uri);

      if (canLaunch) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } else {
        // This usually triggers if WhatsApp is not installed
        Get.snackbar(
          "WhatsApp Required",
          "WhatsApp is not installed on this device.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // 3. Catch unexpected errors (malformed URLs, OS permission issues)
      print("WhatsApp Launch Error: $e");
      Get.snackbar(
        "Launch Error",
        "An unexpected error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}