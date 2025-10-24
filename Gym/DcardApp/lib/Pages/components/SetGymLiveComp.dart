import 'dart:math';


import 'package:dcard/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



import '../../Query/ParticipatedQuery.dart';

import '../../Utilconfig/HideShowState.dart';
import '../../models/Topups.dart';
import '../../Utilconfig/ConstantClassUtil.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  color: Colors.black.withValues(alpha:0.65),
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
                              child: Text(viewTitle, style: GoogleFonts.abel(fontSize: 11,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700)),
                            ),
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


                ],
                offset: const Offset(0, 40),
                child:InkWell(

                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.grey.withValues(alpha:0.2),
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

                      viewUser(_data[index]);
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

                              Text((ConstantClassUtil().formatMinutes(_data[index]['Min_remaining'])).contains('-')?'${(ConstantClassUtil().formatMinutes(_data[index]['Min_remaining'])).replaceAll('-', '')} Ago':'${ConstantClassUtil().formatMinutes(_data[index]['Min_remaining'])} Left' ),
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
    if(isLoading) return;
    isLoading=true;
    int limit=10;


    var resultData=(await ParticipatedQuery().participantIn(Topups(startlimit:limit,endlimit:_page,name:nameVal,optionCase:"$searchVal",advancedSearch:advancedSearch,created_at:thisDate,updated_at:toDate),User(uid: "none",name:"none"))).data;

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
      if(resultData["result"]==1){
        Get.dialog(
          AlertDialog(
            title: const Text('Error'),
            content: Text(resultData["error"]??''),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(

                  //primary: Colors.grey[300],
                  backgroundColor: Color(0xff9a1c55),
                  foregroundColor: Colors.white,
                  elevation:0,
                ),
                onPressed: () async{
                  final Uri urlData = Uri.parse(resultData["downNew"]);
                  if (!await launchUrl(urlData)) {
                    throw Exception('Could not launch $urlData');
                  }
                },
                child: Text('Update'),
              ),
              ElevatedButton(

                onPressed: () async{


                  Get.back();
                },
                child: const Text('Close'),
              ),

            ],
          ),
        );
      }


    }
  }
  scrolldata()async
  {
    await viewData('test',"false");
  }

  //popup

  viewUser(data){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: Text(ConstantClassUtil().capitalize(data["name"]),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: const Text("Name"),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.green),
                  title: Text(ConstantClassUtil().extractAfterUnderscore(data["PhoneNumber"]),
                      style: const TextStyle(fontSize: 16)),
                  subtitle: const Text("Phone"),
                ),
                ((data["packName"] != "") && (data["packName"] != "none"))
                    ? Column(
                  children: [
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.backpack, color: Colors.green),
                      title: Text(
                        "${ConstantClassUtil().capitalize(data["packName"])} (${data["packValid"]} days)",
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: const Text("Pack"),
                    ),
                  ],
                )
                    : const SizedBox.shrink(),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text("Close"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
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


