import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Query/CardQuery.dart';

import '../../Query/ParticipatedQuery.dart';
import '../../models/Participated.dart';

import '../ParticipateHistPage.dart';
import '../components/ProfilePic.dart';
import '../../models/Topups.dart';




class AllEventComp extends StatefulWidget {
  const AllEventComp({Key? key}) : super(key: key);

  @override
  State<AllEventComp> createState() => _AllEventCompState();
}

class _AllEventCompState extends State<AllEventComp> {
  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];
  int _page=0;
  bool hasMoreData=true;
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {



    return listdata();



  }
  Widget listdata(){
    return  Column(
      children: [
        ProfilePic().profile(),
        Text("Events"),
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
                            Text("${_data[index]['uid']}"),
                          ],
                        ),


                      ],
                    ),
                    subtitle: Text("${_data[index]['inputData']}"),

                    trailing: IconButton(
                      icon:Icon(Icons.arrow_forward),
                      onPressed: () {
                        // delete item at index

                        Get.to(() =>ParticipateHistPage(),arguments:[_data[index]['inputData'],_data[index]['uid']]);
                      },
                    ),
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
    //var Resul=(await ScrollQuery().getapi(limit,_page)).data;
    ///var Resul=(await TopupQuery().GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}",startlimit:limit,endlimit:_page,optionCase:'balance'))).data;
    var Resul=(await ParticipatedQuery().getAllParticipateEventOnline(Participated(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}"),Topups(startlimit:limit,endlimit:_page,optionCase:'balance'))).data;
    setState(() {
      isLoading=false;
      if(Resul["result"].length<limit)
      {
        isLoading=false;
        hasMoreData=false;
      }

      _data.addAll(Resul["result"]);
    });
  }
}


