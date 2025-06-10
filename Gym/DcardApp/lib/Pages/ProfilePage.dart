import 'package:flutter/material.dart';
import 'components/ProfileComp.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'components/BottomNavigator/ProfileNavigator.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
            },
          ),
        ),
      ),
      backgroundColor: Colors.yellow,
      //backgroundColor: Color(0xff010a0e),

      body: ProfileComp(),
      bottomNavigationBar:ProfileNavigator(),


    );

  }
}
loaddata(){
  //print("hello");
}