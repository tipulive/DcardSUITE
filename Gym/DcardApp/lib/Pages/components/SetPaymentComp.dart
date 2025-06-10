import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dcard/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../Query/ParticipatedQuery.dart';

import '../../Utilconfig/HideShowState.dart';
import '../../models/Topups.dart';
import '../../models/Participated.dart';
import '../../models/Promotions.dart';
import '../../Utilconfig/ConstantClassUtil.dart';

class SetPaymentComp extends StatefulWidget {
  const SetPaymentComp({super.key});

  @override
  State<SetPaymentComp> createState() => _SetPaymentCompState();
}

class _SetPaymentCompState extends State<SetPaymentComp> {
  final ScrollController _scrollController = ScrollController(); // detect scroll
  TextEditingController inputData = TextEditingController();
  final List<dynamic> _data = [];
  int _page = 0;
  bool hasMoreData = true;
  bool isLoading = false;
  final args = Get.arguments;

  var resultDatas;

  String advancedSearch = "today";
  String viewTitle = "Today";
  final List<String> _dropdownOptions = ['Name', 'OrderId'];
  String selectOption = "Name";
  String thisDate = "none";
  String toDate = "";

  DateTime selectedDate = DateTime.now();
  DateTimeRange selectedDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now()
  );
  String cardUid="nonenonenonenone";
  String inputAction="none";
  //List<dynamic> packages = [];
  Map<String, dynamic>? selpackages;
  Map<String, dynamic>? selectedPackage;


  int validForm=0;

  String phoneNumber="none";


  TextEditingController uidData=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();

  TextEditingController uidInput=TextEditingController();

  TextEditingController uidInput4=TextEditingController(text:"+243");
  TextEditingController initCountry=TextEditingController(text:"CD");
  TextEditingController uidInput5=TextEditingController(text:"Congo,Democratic Republic of the Congo");
  TextEditingController password=TextEditingController();
  TextEditingController status=TextEditingController(text:"card");
  TextEditingController carduid=TextEditingController();
  final GlobalKey qrkey = GlobalKey(debugLabel: '${UniqueKey()}');
  Barcode?result;
  QRViewController?controller;
  List<dynamic>qrDebt = [];
  bool cameraValue=false;
  bool flashValue=false;
  //final ParticipatedQuery controller = Get.put(ParticipatedQuery());
  //final myInt = args['int'] as int;
  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        listdata(),
        Positioned.fill(
            child: Obx(
                  () =>
                  Visibility(
                    visible: Get
                        .put(HideShowState())
                        .isVisible
                        .value,
                    child:Center(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white70,
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  ),
            )
        ),


      ],
    );
  }


  Widget listdata() {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: Text("Payment History", style: GoogleFonts.pacifico(
              fontSize: 15, color: Colors.teal, fontWeight: FontWeight.w700)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
          child: Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
            //color:Colors.white,
            color: Colors.white70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              //side: BorderSide(color:_data[0]["color_var"]??true?Colors.white:Colors.green, width: 2),
            ),

            child: ListTile(
              leading: InkWell(
                onTap:() async {
             //show package
                  (Get.put(HideShowState()).isHiden(true));
                  await fetchPackages();
              },
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.attach_money_rounded),
                ),
              ),
              title: Row(
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
                                  style: DefaultTextStyle
                                      .of(context)
                                      .style,
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

                          const Icon(
                            Icons.segment, color: Colors.orange, size: 13,),
                          Text("${(_data.isNotEmpty)
                              ? _data[0]['totalSales']
                              : 0}", style: GoogleFonts.pacifico(fontSize: 15,
                              color: Colors.orange,
                              fontWeight: FontWeight.w700)),


                        ],
                      ),


                    ],
                  ),

                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (container) =>
                [
                  PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            advancedSearch = "today";
                            viewTitle = "today";
                          });
                          await viewData('test', "false");
                        },
                        child: const Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.today,
                                  color: Colors.blue,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text("Today"),
                                ),

                              ],
                            ),
                            Divider(
                              height: 20, // Adjust the height as needed
                              thickness: 0.2, // Adjust the thickness as needed
                              color: Colors.grey,
                            ),

                          ],
                        ),
                      )
                  ),
                  PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            advancedSearch = "week";
                            viewTitle = "This Week";
                          });
                          await viewData('test', "false");
                        },
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_view_week,
                                  color: Colors.orange,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text("This Week"),
                                ),

                              ],
                            ),
                            Divider(
                              height: 20, // Adjust the height as needed
                              thickness: 0.2, // Adjust the thickness as needed
                              color: Colors.grey,
                            ),

                          ],
                        ),
                      )
                  ),
                  PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            advancedSearch = "month";
                            viewTitle = "This Month";
                          });
                          await viewData('test', "false");
                        },
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.orange,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text("This Month"),
                                ),

                              ],
                            ),
                            Divider(
                              height: 20, // Adjust the height as needed
                              thickness: 0.2, // Adjust the thickness as needed
                              color: Colors.grey,
                            ),

                          ],
                        ),
                      )
                  ),
                  PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            advancedSearch = "year";
                            viewTitle = "This Year";
                          });
                          await viewData('test', "false");
                        },
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.event_available,
                                  color: Colors.orange,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text("This Year"),
                                ),

                              ],
                            ),
                            Divider(
                              height: 20, // Adjust the height as needed
                              thickness: 0.2, // Adjust the thickness as needed
                              color: Colors.grey,
                            ),

                          ],
                        ),
                      )
                  ),
                  PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          /*setState(() {

                              advancedSearch="year";
                              viewTitle="This Year";
                            });
                            await viewData('test',"false");*/
                          final DateTime? datetime = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2100));
                          if (datetime != null && datetime != selectedDate) {
                            setState(() {
                              advancedSearch = "choosedate";
                              selectedDate = datetime;

                              thisDate = "${selectedDate.year}-${selectedDate
                                  .month}-${selectedDate.day}";
                              viewTitle = "Date:$thisDate";
                            });
                            Navigator.pop(context);
                            await viewData('test', "false");
                            //print("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
                          }
                        },
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.event_note,
                                  color: Colors.pink,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text("Choose Date"),
                                ),

                              ],
                            ),
                            Divider(
                              height: 20, // Adjust the height as needed
                              thickness: 0.2, // Adjust the thickness as needed
                              color: Colors.grey,
                            ),

                          ],
                        ),
                      )
                  ),
                  PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          /*setState(() {

                              advancedSearch="year";
                              viewTitle="This Year";
                            });
                            await viewData('test',"false");*/
                          final DateTimeRange? datetimeRange = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2100));
                          if (datetimeRange != null) {
                            setState(() {
                              advancedSearch = "choosedaterange";
                              selectedDateRange = datetimeRange;

                              thisDate = "${selectedDateRange.start
                                  .year}-${selectedDateRange.start
                                  .month}-${selectedDateRange.start.day}";
                              toDate =
                              "${selectedDateRange.end.year}-${selectedDateRange
                                  .end.month}-${selectedDateRange.end.day}";
                              viewTitle = "From:$thisDate To $toDate";
                            });
                            await viewData('test', "false");
                          }
                        },
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.pink,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text("Date Range"),
                                ),

                              ],
                            ),
                            Divider(
                              height: 20, // Adjust the height as needed
                              thickness: 0.2, // Adjust the thickness as needed
                              color: Colors.grey,
                            ),

                          ],
                        ),
                      )
                  ),
                  PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            advancedSearch = "mysales";
                            viewTitle = "My Sales";
                          });
                          await viewData('test', "false");
                        },
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.apartment,
                                  color: Colors.orange,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text("All My Sales"),
                                ),

                              ],
                            ),
                            Divider(
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
                child: InkWell(

                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: const CircleBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(

                        Icons.grid_view, // Replace with your desired icon
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


        Visibility(
          visible: false,
          child: Container(
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
              onChanged: (text) async {
                try {
                  int limit = 10;
                  var resultData = (await ParticipatedQuery()
                      .getAllParticipateHistEventOnline(
                      Topups(startlimit: limit, endlimit: _page),
                      User(uid: "none", name: text))).data;
                  if (resultData["status"]) {
                    setState(() {
                      //print(Resul);
                      isLoading = false;
                      hasMoreData = false;
                      _data.clear();

                      _data.addAll(resultData["result"]);
                    });
                  }
                  else {
                    _data.clear();
                  }
                } catch (e) {}

                //print(this._data[index]["total_var"]);
                // print("Text changed to: $text");
              },
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(

            controller: _scrollController,
            itemCount: _data.length + 1,
            itemBuilder: (context, index) {
              if (index < _data.length) {
                return GestureDetector(
                    onTap: () {
                      // Handle card click event here
                      //Get.put(HideShowState()).isVisible(true);
                      //fetchPackages(_data[index]);
                      //editParticipatePopup(_data[index]);
                    },
                    child: Card(
                      elevation: 0,
                      //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                      //color:Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        //side: BorderSide(color:((_data[index]["actionName"])=="reverse")?Colors.white:Colors.red, width: 1),
                      ),

                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: getRandomColor(),
                          child: Icon(_getRandomIcon()),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [


                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Text("${_data[index]['name']}"),
                                Text(
                                    "${ConstantClassUtil().truncateWithEllipsis(
                                        (_data[index]['name']).toUpperCase(),
                                        6)}"),
                              ],
                            ),


                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text("${(_data[index]['userStatus']=="notmember")?"Cash":"Member"} ",
                              style: TextStyle(color: Colors.pinkAccent),),
                            //Text("${_data[index]["actionName"]}"),
                            (_data[index]["actionName"] == "reverse")
                                ? Tooltip(
                                message: "Reverse transaction occurred during editing.",
                                preferBelow: false,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  // Specify the background color of the tooltip
                                  borderRadius: BorderRadius.circular(
                                      8), // Optionally, round the corners of the tooltip
                                ),
                                child: Icon(
                                  Icons.turn_left, color: Colors.pinkAccent,))
                                : Text(""),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("${(_data[index]['userStatus']=="notmember")?1:_data[index]['packValid']} days"),
                              Text("${_data[index]['created_at']}"),


                            ],
                          ),
                        ),


                      ),
                    )
                );
              }
              else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                      child: hasMoreData ?
                      CircularProgressIndicator()
                          : Text("no more Data")

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
  void initState() {
    super.initState();
    //getapi();

    scrolldata();

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _page = _page + 10;
      //getapi();
      scrolldata();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller?.dispose();
    super.dispose();
  }
  void _onQRViewCreated(QRViewController controller)
  {
    (Get.put(HideShowState()).isHiden(true));


    this.controller=controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) async{
      setState((){
        result=scanData;

      });
      //await scanMethod();
      if(result!=null)
      {
        setState(() {
          cardUid="${result!.code}";
        });
        (Get.put(HideShowState()).isHiden(false));
        confirmCard();
         controller!.pauseCamera();



        //
      }
    });




  }
  confirmCard(){
    // ${(Get.put(HideShowState()).delivery)[Get.put(HideShowState()).indexCountData]["currentQty"]}
    // (Get.put(StockQuery()).dispatchOrder)[Get.put(HideShowState()).indexCountData]["productCode"];

    String lastFive = "******"+cardUid.substring(cardUid.length - 8);
    String confirmText=(inputAction=="membership")?"Confirm if it is your Card $lastFive ?":"Confirm if your Number is ${phoneNumber} and your name:${name.text} ?";
    Get.dialog(
      AlertDialog(
        title: Text("${confirmText}", style: TextStyle(fontSize: 14),),
        content: Text('Do you Want To Pay ${selpackages!["name"]} Subscription Which is Valid ${selpackages!["packValid"]}'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(

              //primary: Colors.grey[300],
              backgroundColor: Colors.red,
              elevation:0,
            ),
            onPressed: () async{
              Get.back(canPop: false);

              payment();


            },
            child: const Text('Yes',style:TextStyle(
                color: Colors.white
            ),),
          ),
          ElevatedButton(
            onPressed: () {

              Get.back(canPop: false); // close the alert dialog
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  Future<void> payment() async {
    //loader is needed here
    (Get.put(HideShowState()).isHiden(true));
    final response = (await ParticipatedQuery().participantPayment(
        Participated(inputAction:inputAction, uid:selpackages!["uid"],carduid:cardUid),
        User(uid: "none",phone:phoneNumber, name: name.text))).data; // your API here
    print(response);
    if (response!["status"]) {
      (Get.put(HideShowState()).isHiden(false));
      Get.close(1);
      Get.snackbar("Success", "Data Submitted",backgroundColor: Color(0xff9a1c55),
          colorText: Color(0xffffffff),
          titleText: Text("Participate"),

          icon: Icon(Icons.access_alarm),
          duration: Duration(seconds: 5));
      scrolldata();

      setState(() {
        isLoading = false;

        //packages = response["result"];
        (Get.put(ParticipatedQuery()).updatepackage(response["result"]));
      });
      payPackage();
    }else{
      Get.put(HideShowState()).isVisible(false);
      Get.close(1);


      Get.snackbar("Error", "Something Wrong Contact System Admin",backgroundColor: Color(0xff9a1c55),
          colorText: Color(0xffffffff),
          titleText: Text("Error"),

          icon: Icon(Icons.access_alarm),
          duration: Duration(seconds: 5));
    }
  }

  Future<void> fetchPackages() async {
 //loader is needed here

    final response = (await ParticipatedQuery().getAllPackage(
        Topups(startlimit: 1, endlimit: _page),
        User(uid: "none", name: "none"))).data; // your API here
    print(response);
    if (response!["status"]) {
      (Get.put(HideShowState()).isHiden(false));
      setState(() {
        isLoading = false;
        //packages = response["result"];
        (Get.put(ParticipatedQuery()).updatepackage(response["result"]));
      });
      payPackage();
    }
    else{
      (Get.put(HideShowState()).isHiden(false));
      Get.snackbar("Error", "Something Wrong Contact System Admin",backgroundColor: Color(0xff9a1c55),
          colorText: Color(0xffffffff),
          titleText: Text("Error"),

          icon: Icon(Icons.access_alarm),
          duration: Duration(seconds: 5));

    }
  }

  void showPackageDetails(BuildContext context, Map<String, dynamic> package) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(package['name']),
            content: Text(
                'Description: ${package['packDetail']}\nPrice: ${package['price']}'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context),
                  child: Text('Close')),
            ],
          ),
    );
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
    List<IconData> icons = [
      Icons.favorite,
      Icons.star,
      Icons.thumb_up,
      Icons.access_time,
      Icons.access_time,
      Icons.fastfood,
      Icons.directions_bike,
      Icons.directions_walk,
      Icons.directions_car,
      Icons.directions_boat,
      Icons.airplanemode_active,
      Icons.airport_shuttle,
      Icons.beach_access,
      Icons.camera,
      Icons.movie,
      Icons.music_note,
      Icons.spa,
      Icons.palette,
      Icons.account_balance,
      Icons.attach_money,
    ];
    return icons[random.nextInt(icons.length)];
  }

  viewData(nameVal, searchVal) async {

  }

  scrolldata() async // iyi ndaza kuyisimbuza
      {
    _data.clear();
    if (isLoading) return;
    isLoading = true;
    int limit = 10;
    //var resul=(await ParticipatedQuery().getAllParticipateHistEventOnline(Topups(startlimit:limit,endlimit:_page),User(uid: "none",name:"none"))).data;
    var resul = (await ParticipatedQuery().participantGetPayment(
        Topups(startlimit: limit, endlimit: _page),
        User(uid: "none", name: "none"))).data;
    if(resul!["status"]) {
      setState(() {
        isLoading = false;
        if (resul["result"].length < limit) {
          hasMoreData = false;
        }
        _data.addAll(resul["result"]);
      });
    }
    else{
      setState(() {
        isLoading = true;
        hasMoreData = false;

      });
    }
  }

  //popup
  payPackage() {
    Map<String, dynamic>? selectedPackage; // ✅ Local variable to avoid null errors
    final GlobalKey qrkey1 = GlobalKey(debugLabel: 'QR Key 1');
    return Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(5.0),
            height: 600,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView( // ✅ Prevent overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  const SizedBox(height: 10),

                  GetBuilder<ParticipatedQuery>(
                    builder: (controller) {
                      if (controller.package.isEmpty) {
                        return const Text('No package data available.');
                      }

                      return Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Select Package',
                            border: OutlineInputBorder(),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                            ((controller.isVisible!="none"))?
                                IconButton(
                                  icon: Icon(Icons.info_outline), // Info icon
                                  tooltip: 'Package Info',
                                  onPressed: selectedPackage != null
                                      ? () => showPackageDetails(context, selectedPackage!)
                                      : null,
                                ):Visibility(
                                visible: false,
                                child: Text("")
                            ),
                            //return
                                ((controller.isVisible=="0") || (controller.isVisible=="2") || (controller.isVisible=="3") || (controller.isVisible=="4"))?
                                IconButton(
                                  icon: Icon(Icons.payments), // Scan icon
                                  tooltip: 'Pay By Cash',
                                  onPressed: () {
                                    // handle scan action
                                    //package
                                    if(selectedPackage!["packEligible"]=="2")
                                      {
                                        setState(() {
                                          inputAction="cashpayment";
                                          controller.isHidden("3");
                                        });
                                      }else{
                                      setState(() {
                                        inputAction="cashpayment";
                                        controller.isHidden(selectedPackage!["packEligible"]);
                                      });


                                    }
                                   // print(selectedPackage!);
                                  },
                                )
                                    :Visibility(
                                    visible: false,
                                    child: Text("")
                                ),
                                ((controller.isVisible=="1") || (controller.isVisible=="2") || (controller.isVisible=="3") || (controller.isVisible=="4"))?
                                IconButton(
                                  icon: Icon(Icons.qr_code_scanner), // Scan icon
                                  tooltip: 'Scan Package',
                                  onPressed: () {
                                    // handle scan action
                                    //package
                                    if(selectedPackage!["packEligible"]=="2")
                                    {
                                      setState(() {
                                        inputAction="membership";
                                        controller.isHidden("4");
                                      });

                                    }else{
                                      setState(() {
                                        inputAction="membership";
                                        controller.isHidden(selectedPackage!["packEligible"]);
                                      });
                                    }
                                  },
                                )
                                :
                                Visibility(
                                  visible: false,
                                    child: Text("")
                                ),


                              ],
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Map<String, dynamic>>(
                              isExpanded: true,
                              hint: Text("Choose package"),
                              value: selectedPackage,
                              items: controller.package.map<DropdownMenuItem<Map<String, dynamic>>>((pkg) {
                                return DropdownMenuItem(
                                  value: pkg,
                                  child: Text(pkg['name']),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selpackages=value;
                                  selectedPackage = value;
                                });
                                controller.isHidden(value!["packEligible"]);
                                if(value!["packEligible"]=="0")
                                  {
                                    setState(() {
                                     inputAction="cashpayment";
                                    });
                                  }
                                  else if(value!["packEligible"]=="1"){

                                  setState(() {
                                    inputAction="membership";
                                  });
                                   }
                                  else{
                                  setState(() {
                                    inputAction="none";
                                  });
                                }
                               // print(value!["id"]);



                              },
                            ),
                          ),
                        ),
                      );

                    },
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<ParticipatedQuery>(
                    builder: (myLoadercontroller) {
                      //return Text('Data: ${_controller.data}');

                   return Container(
                     padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                     child: Column(
                       children: [
                         ((myLoadercontroller.isVisible=="1") || (myLoadercontroller.isVisible=="4"))?
                          SizedBox(
                           width:400,
                           height: 200,
                           child: Stack(
                             alignment:Alignment.bottomCenter,
                             children: [
                               QRView(key:qrkey1,onQRViewCreated: _onQRViewCreated,
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
                           ),
                         ):Visibility(
                             visible: false,
                             child: Text("")
                         ),
                         ((myLoadercontroller.isVisible=="0") || (myLoadercontroller.isVisible=="3"))?
                         Column(
                           children: [

                             Container(

                               child:  IntlPhoneField(
                                 initialCountryCode: 'CD',
                                 controller: uidInput,
                                 autofocus: true,

                                 decoration: InputDecoration(
                                   labelText: 'Phone Number',
                                   border: const OutlineInputBorder(
                                     borderSide: BorderSide(),
                                   ),
                                   suffixIcon:Obx(() => Get.put(HideShowState()).visibleIcon.value?const Icon(Icons.done,color:Colors.green,):const Icon(Icons.dangerous,color:Colors.red,)),


                                 ),


                                 onChanged: (phone) async{

                                   if((uidInput.text).isPhoneNumber)
                                   {


                                     // getDataFromNo(phone.number);
                                     setState(() {
                                       phoneNumber="${phone.countryCode}${phone.number}";
                                       validForm=(validForm<2)?validForm+1:validForm;
                                     });

                                     Get.put(HideShowState()).isIconVisible(true);
                                     (validForm==2)?Get.put(HideShowState()).isValid(true):Get.put(HideShowState()).isValid(false);

                                   }
                                   else{
                                     setState(() {
                                       validForm=(validForm>0)?validForm-1:validForm;
                                     });
                                     Get.put(HideShowState()).isValid(false);
                                     Get.put(HideShowState()).isIconVisible(false);
                                   }


                                   //uidInput4.text=phone.countryCode;
                                   //uidInput2.text=phone.number;
                                   // uidInput2.text=phone.countryISOCode;
                                   //print(phone.completeNumber);



                                 },

                                 onCountryChanged: (country) {

                                   uidInput4.text="+${country.dialCode}";
                                   uidInput5.text=country.name;
                                   initCountry.text=country.code;

                                   if((uidInput.text).isPhoneNumber)
                                   {
                                     Get.put(HideShowState()).isIconVisible(true);
                                     //phoneNumber="+${country.dialCode}${uidInput.text}";
                                     setState(() {
                                       phoneNumber="+${country.dialCode}${uidInput.text}";
                                       validForm=(validForm<2)?validForm+1:validForm;
                                     });

                                     (validForm==2)?Get.put(HideShowState()).isValid(true):Get.put(HideShowState()).isValid(false);
                                     //getDataFromNo(uidInput.text);

                                   }
                                   else{
                                     Get.put(HideShowState()).isIconVisible(false);
                                     setState(() {
                                       validForm=(validForm>0)?validForm-1:validForm;
                                     });
                                     Get.put(HideShowState()).isValid(false);

                                     // initCountry.text="";
                                     //password.text="";
                                   }
                                   // print('Country changed to: ' + country.name);
                                   // print('Country changed to: ' + country.dialCode);
                                 },
                               ),
                             ),
                             Container(

                               child: TextField(
                                 controller: name,
                                 decoration: const InputDecoration(
                                   contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                                   border: OutlineInputBorder(),
                                   labelText: 'Name',
                                   hintText: 'Enter your name',
                                   hintStyle: TextStyle(color: Colors.grey),
                                 ),
                                 onChanged: (value) {
                                   final nameRegex = RegExp(r"^[a-zA-Z\s]{2,}$"); // letters and spaces, at least 2 characters

                                   if (value.isNotEmpty && nameRegex.hasMatch(value)) {
                                     validForm=(validForm<2)?validForm+1:validForm;
                                     (validForm==2)?Get.put(HideShowState()).isValid(true):Get.put(HideShowState()).isValid(false);
                                   } else {
                                     setState(() {
                                       validForm=(validForm>0)?validForm-1:validForm;
                                     });
                                     Get.put(HideShowState()).isValid(false);
                                   }
                                 },
                               ),

                             ),

                           ],
                         ):Visibility(
                             visible: false,
                             child: Text("")
                         ),
                         const SizedBox(height: 5.0,),
                         Obx(() => Get.put(HideShowState()).isNumberValid.value?
                         Container(
                           child: FloatingActionButton.extended(
                               label: const Text('Pay By Cash'), // <-- Text
                               backgroundColor: Colors.black,
                               foregroundColor: Colors.white,
                               icon: const Icon( // <-- Icon
                                 Icons.attach_money_rounded,
                                 size: 24.0,
                               ),
                               onPressed: () =>{
                                 //paidDebt()
                                 //addUserMethod(),
                                 // formReset(),
                                confirmCard(),

                               }),
                         ):const Text("")),

                       ],
                     ),
                   );

                    },
                  ),


                  // You can add more content below...
                ],
              ),
            ),
          );
        },
      ),
    ).whenComplete(() {
      // ✅ Post-bottom-sheet logic
    });
  }




  Widget divLine() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(

        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(


                  constraints: const BoxConstraints(
                      maxWidth: 200, maxHeight: 5),
                  //color: Color.fromRGBO(13,44,64, 0.4),
                  color: Colors.white70
              ),
            ),
          ),
          const SizedBox(width: 100,),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(


                  constraints: const BoxConstraints(
                      maxWidth: 200, maxHeight: 5),
                  //color: Color.fromRGBO(13,44,64, 0.4),
                  color: Colors.white70
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget detailsProfile(iconText, icon, iconDescr, listBackground,
      iconrightText, iconright, iconDescrRight, listBackgroundRight) {
    return ClipRRect(
      //borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: EdgeInsets.all(8),
        //margin: const EdgeInsets.all(8),
        margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
        width: 400,
        height: 50,
        //color:Color(0xffffffff),
        color: Color(listBackground),

        child: Row(

          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(

                shape: BoxShape.circle,
                border: Border.all(color: Colors.yellow, width: 1.5),


              ),
              child: Icon(
                icon, color:
              Colors.amber, size: 22,),

            ),
            SizedBox(width: 3,),
            Text("$iconText:", style: GoogleFonts.pacifico(
                fontSize: 15, color: Colors.teal, fontWeight: FontWeight.w700)),
            SizedBox(width: 5,),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 3.9),
                child: Text(
                    "$iconDescr", style: GoogleFonts.pacifico(fontSize: 15)),
              ),
            ),

            Expanded( //right
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(

                      width: 30,
                      height: 30,

                      child:
                      GestureDetector(
                          onTap: () {
                            // This function will be called when the icon is tapped.
                            // myfunct();
                            //print(IconText);

                          },
                          child: Icon(iconright, color:
                          Colors.teal, size: 22,)
                      )


                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
