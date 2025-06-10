
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ScrollQuery extends GetxController{


  getapi(limit,_page) async{


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


        return response;
        //print(response.data[0]["userId"]);



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