import 'dart:math';


import 'package:dcard/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



import '../../Query/ParticipatedQuery.dart';

import '../../Utilconfig/HideShowState.dart';
import '../../models/Topups.dart';
import '../../models/Participated.dart';
import '../../models/Promotions.dart';
import '../../Utilconfig/ConstantClassUtil.dart';

class SetGymLiveComp extends StatefulWidget {
  const SetGymLiveComp({super.key});

  @override
  State<SetGymLiveComp> createState() => _SetGymLiveCompState();
}

class _SetGymLiveCompState extends State<SetGymLiveComp> {
  final ScrollController _scrollController = ScrollController();// detect scroll
  TextEditingController inputData=TextEditingController();
  final List<dynamic> _data = [];
  int _page=0;
  bool hasMoreData=true;
  bool isLoading=false;
  final args = Get.arguments;

  var resultDatas;

  String advancedSearch="today";
  String viewTitle="Today";
  final List<String> _dropdownOptions = ['Name','OrderId'];
  String selectOption="Name";
  String thisDate="none";
  String toDate="";

  DateTime selectedDate=DateTime.now();
  DateTimeRange selectedDateRange=DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now()
  );
  //final myInt = args['int'] as int;
  @override
  Widget build(BuildContext context) {



    return Stack(

      children: [
        listdata(),
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



      ],
    );




  }
  Widget listdata(){
    return  Column(
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: Text("Gym Live Users",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
        ),
        Padding(
          padding:const EdgeInsets.fromLTRB(8,10,8,0),
          child: Card(
            elevation:0,
            margin: const EdgeInsets.symmetric(vertical:1,horizontal:5),
            //color:Colors.white,
            color:Colors.white70,
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
                          Text("${(_data.isNotEmpty)?_data[0]['memberIn']:0}",style:GoogleFonts.pacifico(fontSize:15,color: Colors.orange,fontWeight: FontWeight.w700)),


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
                            advancedSearch="today";
                            viewTitle="today";

                          });
                          await viewData('test',"false");

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
                                  padding: EdgeInsets.only(left:10.0),
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
                        onTap: () async{
                          setState(() {
                            advancedSearch="week";
                            viewTitle="This Week";

                          });
                          await viewData('test',"false");
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
                                  padding: EdgeInsets.only(left:10.0),
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
                        onTap: () async{
                          setState(() {
                            advancedSearch="month";
                            viewTitle="This Month";

                          });
                          await viewData('test',"false");
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
                                  padding: EdgeInsets.only(left:10.0),
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
                        onTap: () async{
                          setState(() {

                            advancedSearch="year";
                            viewTitle="This Year";
                          });
                          await viewData('test',"false");
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
                                  padding: EdgeInsets.only(left:10.0),
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
                        onTap: () async{
                          /*setState(() {

                              advancedSearch="year";
                              viewTitle="This Year";
                            });
                            await viewData('test',"false");*/
                          final DateTime? datetime= await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2100));
                          if(datetime!=null  && datetime != selectedDate){
                            setState(() {
                              advancedSearch="choosedate";
                              selectedDate=datetime;

                              thisDate="${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                              viewTitle="Date:$thisDate";
                            });
                            Navigator.pop(context);
                            await viewData('test',"false");
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
                                  padding: EdgeInsets.only(left:10.0),
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
                        onTap: () async{
                          /*setState(() {

                              advancedSearch="year";
                              viewTitle="This Year";
                            });
                            await viewData('test',"false");*/
                          final DateTimeRange? datetimeRange= await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2100));
                          if(datetimeRange!=null){
                            setState(() {
                              advancedSearch="choosedaterange";
                              selectedDateRange=datetimeRange;

                              thisDate="${selectedDateRange.start.year}-${selectedDateRange.start.month}-${selectedDateRange.start.day}";
                              toDate="${selectedDateRange.end.year}-${selectedDateRange.end.month}-${selectedDateRange.end.day}";
                              viewTitle="From:$thisDate To $toDate";
                            });
                            await viewData('test',"false");
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
                                  padding: EdgeInsets.only(left:10.0),
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
                        onTap: () async{
                          setState(() {
                            advancedSearch="mysales";
                            viewTitle="My Sales";

                          });
                          await viewData('test',"false");
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
                                  padding: EdgeInsets.only(left:10.0),
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
                child:InkWell(

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
              onChanged: (text) async{

                try {
                  int limit=10;
                  var resultData=(await ParticipatedQuery().getAllParticipateHistEventOnline(Topups(startlimit:limit,endlimit:_page),User(uid: "none",name:text))).data;
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

                  }


                } catch (e) {
                }

                //print(this._data[index]["total_var"]);
                // print("Text changed to: $text");
              },
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(

            controller: _scrollController,
            itemCount: _data.length+1,
            itemBuilder: (context, index) {
              if(index<_data.length)
              {
                return GestureDetector(
                    onTap: () {
                      // Handle card click event here
                      //Get.put(HideShowState()).isVisible(true);

                      editParticipatePopup(_data[index]);
                    },
                    child:Card(
                      elevation:0,
                      //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                      //color:Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        //side: BorderSide(color:((_data[index]["actionName"])=="reverse")?Colors.white:Colors.red, width: 1),
                      ),

                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:getRandomColor(),
                          child: Icon(_getRandomIcon()),
                        ),
                        title:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [


                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Text("${_data[index]['name']}"),
                                Text("${ConstantClassUtil().truncateWithEllipsis((_data[index]['name']).toUpperCase(), 6)}"),
                              ],
                            ),



                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text("${_data[index]['userStatus']} ",style:TextStyle(color: Colors.pinkAccent),),
                            //Text("${_data[index]["actionName"]}"),
                            (_data[index]["actionName"]=="reverse")?Tooltip(
                                message:"Reverse transaction occurred during editing.",
                                preferBelow: false,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent, // Specify the background color of the tooltip
                                  borderRadius: BorderRadius.circular(8), // Optionally, round the corners of the tooltip
                                ),
                                child: Icon(Icons.turn_left,color:Colors.pinkAccent,)):Text(""),
                          ],
                        ),
                        trailing:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:CrossAxisAlignment.start,
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [

                              Text("${ConstantClassUtil().formatMinutes(_data[index]['Min_remaining'])} left" ),
                              Text("${_data[index]['created_at']}"),



                            ],
                          ),
                        ),




                      ),
                    )
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
  @override
  void initState()
  {
    super.initState();
    //getapi();
    scrolldata();
    _scrollController.addListener(_scrollListener);
  }
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _page=_page+10;
      //getapi();
      scrolldata();
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
  viewData(nameVal,searchVal) async{

  }
  scrolldata()async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;
    //var resul=(await ParticipatedQuery().getAllParticipateHistEventOnline(Topups(startlimit:limit,endlimit:_page),User(uid: "none",name:"none"))).data;
    var resul=(await ParticipatedQuery().participantIn(Topups(startlimit:limit,endlimit:_page),User(uid: "none",name:"none"))).data;

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

  editParticipatePopup(data){

    Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height:200,

                  child: Column(
                    children: [
                      Container(

                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: ListView(
                          padding: EdgeInsets.all(10),
                          children: [
                            Center(child: Text(data["name"])),
                            Center(child: Text("Promotion:${data["promoName"]}")),
                            TextField(
                              controller:inputData,
                              keyboardType: TextInputType.number,

                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                border: OutlineInputBorder(),
                                labelText: 'Enter Value',
                                hintText: 'Enter Value',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),

                              ),
                            ),
                            SizedBox(height: 10.0,),
                            SizedBox(height: 10.0,),
                            Center(
                              child: FloatingActionButton.extended(
                                label: Text('Edit'), // <-- Text
                                backgroundColor: Color(0xff010a0e),
                                icon: Icon( // <-- Icon
                                  Icons.redeem,
                                  size: 24.0,
                                ),
                                onPressed: () async=> {


                                  Get.put(HideShowState()).isVisible(true),
                                  resultDatas=(await ParticipatedQuery().ParticipateEditEventOnline(Participated(uid:data["uid"],uidUser:data["uidUser"],inputData:inputData.text),Promotions(reach:data["reach"],gain:data["gain"]))).data,
                                  if(resultDatas["status"])
                                    {
                                      Get.put(HideShowState()).isVisible(false),
                                      Get.snackbar("Success", "Successfully Edited ",backgroundColor: Color(0xff9a1c55),
                                          colorText: Color(0xffffffff),
                                          titleText: const Text("Events",style:TextStyle(color:Color(
                                              0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                          icon: Icon(Icons.access_alarm),
                                          duration: Duration(seconds: 4)),


                                    }else{
                                    Get.put(HideShowState()).isVisible(false),

                                    Get.snackbar("Error", "something wrong",backgroundColor: Color(
                                        0xffdc2323),
                                        colorText: Color(0xffffffff),
                                        titleText: const Text("Events",style:TextStyle(color:Color(
                                            0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                        icon: Icon(Icons.access_alarm),
                                        duration: Duration(seconds: 4))
                                  }


                                },




                              ),
                            ),



                            //MyTextWidget(uid,name)
                          ],
                        ),
                      ),
                    ],
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
                        child: CircularProgressIndicator(),
                      ),
                    )
                ),
              ],
            );
        },
      ),
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });
  }
//popup
}



Widget divLine(){
  return Container(
    margin: const EdgeInsets.all(8),
    child: Row(

      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(


                constraints: const BoxConstraints(maxWidth: 200,maxHeight: 5),
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


                constraints: const BoxConstraints(maxWidth: 200,maxHeight: 5),
                //color: Color.fromRGBO(13,44,64, 0.4),
                color: Colors.white70
            ),
          ),
        )
      ],
    ),
  );
}

Widget detailsProfile(iconText,icon,iconDescr,listBackground,iconrightText,iconright,iconDescrRight,listBackgroundRight){


  return ClipRRect(
    //borderRadius: BorderRadius.circular(32),
    child: Container(
      padding: EdgeInsets.all(8),
      //margin: const EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(8,0,8,0),
      width: 400,
      height: 50,
      //color:Color(0xffffffff),
      color:Color(listBackground),

      child: Row(

        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(

              shape: BoxShape.circle,
              border: Border.all(color: Colors.yellow,width: 1.5),



            ),
            child: Icon(
              icon,color:
            Colors.amber,size: 22,),

          ),
          SizedBox(width:3,),
          Text("$iconText:",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
          SizedBox(width:5,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 3.9),
              child: Text("$iconDescr",style:GoogleFonts.pacifico(fontSize: 15)),
            ),
          ),

          Expanded(//right
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
                        child: Icon(iconright,color:
                        Colors.teal,size: 22,)
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


