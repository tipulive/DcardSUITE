import 'package:flutter/material.dart';
import 'components/BottomNavigator/HomeNavigator.dart';
import 'components/deptComp.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class deptPage extends StatelessWidget {
  const deptPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(27.0), // customize toolbar height
        child: AppBar(
          backgroundColor: Colors.transparent, // set the background color to transparent
          elevation: 0, // remove the shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
              Get.back();
              //Get.toNamed('settings');
            },
          ),
        ),
      ),


      body:deptComp(),
      bottomNavigationBar:HomeNavigator(),



    );

  }
}