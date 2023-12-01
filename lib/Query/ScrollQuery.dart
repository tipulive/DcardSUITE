
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../Utilconfig/ConstantClassUtil.dart';

class ScrollQuery extends GetxController{


  getapi(limit,_page) async{


    try {

      var params =  {

        "uid":"kebineericMuna_1668935593",  //"kebineericMuna_1668935593",
        "LimitStart":_page,
        "LimitEnd":limit
        //"options": [1,2,3],
      };

      //String Authtoken =(adminStateData.obj)["result"][0]["AuthToken"];
      //var url="https://jsonplaceholder.typicode.com/posts?_limit=${limit}&_page=${_page}";
      var url="${ConstantClassUtil.urlLink}/GetBalanceHist";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
         // HttpHeaders.authorizationHeader:"Bearer 244|ygdCii7TkgEHjyyRmp8XZAt0Yt7iC8x8sjE7BQaI"
          HttpHeaders.authorizationHeader:"Bearer 336|7zGgsiF6mvd9cWa36DMqWRI95apznzw8tjd0yL78"
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