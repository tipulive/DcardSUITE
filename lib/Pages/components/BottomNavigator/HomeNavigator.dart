
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Card/AddCardPage.dart';
import '../../Homepage.dart';
import '../../SettingPage.dart';
import '../../../Utilconfig/HideShowState.dart';



class HomeNavigator extends StatelessWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final myindex = Get.arguments??0;


    return  Obx(
            () =>BottomNavigationBar(
          //backgroundColor: Colors.yellow,
          //backgroundColor: Color(0xff010a0e),
          currentIndex:Get.put(HideShowState()).homenavigator.value,

          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_card),
                label: "Card",
                backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",//Account,Recent submitted
                backgroundColor: Colors.blue
            ),

          ],
          onTap: (index){
            Get.put(HideShowState()).setHomenavigator(index);
            if(index==0)
            {


              Get.put(HideShowState()).isCameraVisible(true);
              Get.to(() => const Homepage());


            }
            if(index==1)
            {


              Get.to(() =>const AddCardPage(),arguments:1);
            }
            if(index==2)
            {
              Get.put(HideShowState()).isCameraVisible(false);

              Get.to(() =>const SettingPage(),arguments:1);
            }
          },
        )
    );
  }
}


