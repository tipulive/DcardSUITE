// custom_popup_menu.dart

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Query/AdminQuery.dart';

class CustomPopupMenu extends StatelessWidget {
  final Color iconColor;

  const CustomPopupMenu({super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1300),
      child: PopupMenuButton(
        color: Colors.white,
        itemBuilder: (context) => [
          PopupMenuItem(
            child: InkWell(
              onTap: () async {
                Get.to(() => const SetSalePage());
              },
              child: const Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Sales",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            child: InkWell(
              onTap: () async {},
              child: const Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Purchase",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            child: InkWell(
              onTap: () async {},
              child: const Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Account",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            child: InkWell(
              onTap: () async {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Confirmation'),
                    content: const Text('Do you Want to Logout?'),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff9a1c55),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          await Get.put(AdminQuery()).logout();
                          Get.toNamed('/Login');
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back(); // close the alert dialog
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: const Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.power,
                        color: Colors.redAccent,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Logout",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
        offset: const Offset(-30, 90),
        child: InkWell(
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.menu,
                color:iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder classes for SetSalePage and AdminQuery
class SetSalePage extends StatelessWidget {
  const SetSalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Sale Page'),
      ),
      body: const Center(
        child: Text('Set Sale Page Content'),
      ),
    );
  }
}


