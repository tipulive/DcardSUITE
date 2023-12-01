import 'dart:math';


import 'package:dcard/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../Query/CardQuery.dart';
import '../../Query/TopupQuery.dart';
import '../../Utilconfig/HideShowState.dart';
import '../../models/Topups.dart';


class WBonusHistComp extends StatefulWidget {
  const WBonusHistComp({Key? key}) : super(key: key);

  @override
  State<WBonusHistComp> createState() => _WBonusHistCompState();
}

class _WBonusHistCompState extends State<WBonusHistComp> {
  ScrollController _scrollController = ScrollController();// detect scroll
  TextEditingController inputData=TextEditingController();
  List<dynamic> _data = [];
  int _page=0;
  bool hasMoreData=true;
  bool isLoading=false;
  final args = Get.arguments;

  var resultDatas;

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
          child: Text("Widraw Bonus History",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
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
                      //print(_data[index]);
                      EditParticipatePopup(_data[index]);
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
                          child: Icon(_getRandomIcon()),
                          backgroundColor:getRandomColor(),
                        ),
                        title:Text("${_data[index]['name']}",overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text("${_data[index]['bonus']}"),
                        trailing:Text("${_data[index]['created_at']}"),




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
    scrolldata();
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
  scrolldata()async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;
    var resul=(await TopupQuery().getWBalanceHistUser(Topups(startlimit:limit,endlimit:_page,optionCase:'bonus'),User(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}",name:"none"))).data;
    setState(() {
      isLoading=false;
      if(resul["result"].length<limit)
      {
        hasMoreData=false;
      }
      _data.addAll(resul["result"]);
    });
  }
  //popup

  EditParticipatePopup(data){

    Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height:250,

                  child: Column(
                    children: [
                      Container(

                        height: 250,
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
                            Center(child: Text(data["created_at"])),

                            SizedBox(height: 10,),
                            Card(
                              elevation: 0.2,  // Adds a shadow effect
                              shape: RoundedRectangleBorder(
                                //borderRadius: BorderRadius.circular(8),  // Adds rounded corners
                              ),
                              color: Colors.white,  // Sets the background color
                              child: Column(
                                children: [

                                  ListTile(

                                    title: Text('Withdraw'),
                                    subtitle: Text(data["name"]),

                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 0.2,  // Adds a shadow effect
                              shape: RoundedRectangleBorder(
                                //borderRadius: BorderRadius.circular(8),  // Adds rounded corners
                              ),
                              color: Colors.white,  // Sets the background color
                              child: Column(
                                children: [

                                  ListTile(

                                    title: Text('Description'),
                                    subtitle: Text(data["description"]),

                                  ),
                                ],
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

Widget detailsProfile(IconText,icon,IconDescr,listBackground,IconrightText,iconright,IconDescrRight,listBackgroundRight){


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
          Text("${IconText}:",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
          SizedBox(width:5,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 3.9),
              child: Text("${IconDescr}",style:GoogleFonts.pacifico(fontSize: 15)),
            ),
          ),

          Expanded(//right
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(

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


