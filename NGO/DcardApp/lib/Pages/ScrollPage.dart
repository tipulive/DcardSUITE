import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../Query/ScrollQuery.dart';

class ScrollPage extends StatefulWidget {
  const ScrollPage({Key? key}) : super(key: key);

  @override
  State<ScrollPage> createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {

  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];
  int _page=0;
  bool hasMoreData=true;
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  Column(
        children: [
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
                        title: Text("${_data[index]['id']}"),
                        subtitle: Text(_data[index]['productCode']),

                        trailing: IconButton(
                          icon:Icon(Icons.arrow_forward),
                          onPressed: () {
                            // delete item at index
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
      )
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
    var Resul=(await ScrollQuery().getapi(limit,_page)).data;
    setState(() {
      isLoading=false;
      if(Resul["result"].length<limit)
      {
        hasMoreData=false;
      }
      _data.addAll(Resul["result"]);
    });
  }
  getapi() async{
    if(isLoading) return;
    isLoading=true;
    int limit=10;

    try {

      var params =  {

        "uidUser":"uidUser",   //"kebineericMuna_1668935593",

        //"options": [1,2,3],
      };

      //String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      var url="https://jsonplaceholder.typicode.com/posts?_limit=${limit}&_page=${_page}";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
         // HttpHeaders.authorizationHeader:"Bearer ${Authtoken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {

        final List NewItems=response.data;
        //return response;
        //print(response.data[0]["userId"]);
        setState(() {
          isLoading=false;
          if(NewItems.length<limit)
            {
              hasMoreData=false;
            }
          _data.addAll(response.data);
        });


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }
}
