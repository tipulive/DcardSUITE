import 'package:flutter/material.dart';
import 'components/BottomNavigator/HomeNavigator.dart';
import 'components/SetRepayComp.dart';
import 'package:get/get.dart';


class SetRepayPage extends StatelessWidget {
  const SetRepayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(27.0), // customize toolbar height
        child: AppBar(
          backgroundColor: Colors.transparent, // set the background color to transparent
          elevation: 0, // remove the shadow
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
              Get.back();
              //Get.toNamed('settings');
            },
          ),
        ),
      ),


      body:const SetRepayComp(),
      bottomNavigationBar:const HomeNavigator(),



    );

  }
}
