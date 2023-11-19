import 'dart:math';

import 'package:dcard/models/Participated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../Query/CardQuery.dart';
import '../../Query/ParticipatedQuery.dart';
//import '../../Query/ScrollQuery.dart';
import '../../Pages/components/ProfilePic.dart';
import '../../models/Topups.dart';

class ParticipateHistComp extends StatefulWidget {
  const ParticipateHistComp({Key? key}) : super(key: key);

  @override
  State<ParticipateHistComp> createState() => _ParticipateHistCompState();
}

class _ParticipateHistCompState extends State<ParticipateHistComp> {
  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];
  int _page=0;
  bool hasMoreData=true;
  bool isLoading=false;
  final args = Get.arguments;

  //final myInt = args['int'] as int;
  @override
  Widget build(BuildContext context) {



         return listdata();



  }
  Widget listdata(){
    return  Column(
      children: [
        ProfilePic().profile(),
        Text("${args[1]}"),
        Text("Event History"),
        Expanded(
          child: ListView.builder(

            controller: _scrollController,
            itemCount: _data.length+1,
            itemBuilder: (context, index) {
              if(index<_data.length)
              {
                return Card(
                  elevation:0,
                  //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                  //color:Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    //side: BorderSide(color:getRandomColor(), width: 1),
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(_getRandomIcon()),
                      backgroundColor:getRandomColor(),
                    ),
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Submitted"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("${_data[index]['created_at']}"),
                          ],
                        ),


                      ],
                    ),
                    subtitle: Text("${_data[index]['inputData']}"),


                  ),
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
    var Resul=(await ParticipatedQuery().getParticipateHistEventOnline(Participated(uid:"${args[1]}",uidUser:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}"),Topups(startlimit:limit,endlimit:_page))).data;
    setState(() {
      isLoading=false;
      if(Resul["result"].length<limit)
      {
        hasMoreData=false;
      }
      _data.addAll(Resul["result"]);
    });
  }
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


