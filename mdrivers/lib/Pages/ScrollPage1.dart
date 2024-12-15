import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../Query/ScrollQuery.dart';

class ScrollPage extends StatefulWidget {
  const ScrollPage({Key? key}) : super(key: key);

  @override
  State<ScrollPage> createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {

  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];
  int _page=1;
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
                    return ListTile(
                      title: Text("${_data[index]['id']}"),
                      subtitle: Text(_data[index]['body']),
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
      _page++;
      //getapi();
      scrolldata();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  scrolldata()async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;
    var Resul=(await ScrollQuery().getapi(limit,_page)).data;
    final List NewItems=Resul;
    //return response;
    //print(response.data[0]["userId"]);
    setState(() {
      isLoading=false;
      if(NewItems.length<limit)
      {
        hasMoreData=false;
      }
      _data.addAll(Resul);
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
