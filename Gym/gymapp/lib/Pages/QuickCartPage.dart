import 'package:flutter/material.dart';
import 'components/QuickBonusComp.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'components/BottomNavigator/ProfileNavigator.dart';
import 'components/QuickCartComp.dart';

class QuickCartPage extends StatelessWidget {
  const QuickCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(27.0), // customize toolbar height
        child: AppBar(
          backgroundColor: Colors.transparent, // set the background color to transparent
          elevation: 0, // remove the shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      backgroundColor: Colors.yellow,
      //backgroundColor: Color(0xffffffff),

      body:QuickCartComp(),
      bottomNavigationBar:ProfileNavigator(),


    );

  }
}
loaddata(){
  //print("hello");
}