import 'package:dcard/Pages/UserAccountPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilconfig/HideShowState.dart';

class ProfileNavigator extends StatelessWidget {
  @override
  //final myindex = Get.arguments??0;
  Widget build(BuildContext context) {

    return  Obx(
            () =>BottomNavigationBar(
              //backgroundColor: Colors.red,
              //backgroundColor: Color(0xd0ffffff),
              currentIndex:Get.put(HideShowState()).profilenavigator.value,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: "Account",
                    backgroundColor: Colors.blue
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings_suggest),
                    label:"Settings",
                    backgroundColor: Colors.blue
                ),
              ],
              onTap: (index){
                Get.put(HideShowState()).setProfilenavigator(index);
                if(index==0)
                {
                  if(Get.currentRoute=="/UserAccountPage")
                  {
                    Get.toNamed('/ProfilePage');
                    //print(Get.currentRoute);
                  }
                  else if(Get.currentRoute=="/ProfilePage")
                  {
                    Get.toNamed('/home');
                  }
                  else{
                    Get.back();
                  }




                } if(index==1)
                {

                  Get.to(() =>UserAccountPage(),arguments:1);
                }
              },
            )
    );
  }
}