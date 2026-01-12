



import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';






class ErrorComp extends StatefulWidget {
  const ErrorComp({Key? key}) : super(key: key);

  @override
  State<ErrorComp> createState() => _ErrorCompState();
}

class _ErrorCompState extends State<ErrorComp> {



  @override
  Widget build(BuildContext context) {



    //return listdata();

    /*WidgetsBinding.instance.addPostFrameCallback((_) {

      QuickBonus();
    });*/
    return Scaffold(body: listdata());
    //return Center(child: Text("hello"));




  }
  Widget listdata(){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //ProfilePic().profile(),

        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text("Error Page",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
        ),

       Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: const [
              Text("Something Wrong "),
           ],

         ),
       ),

      ],
    );
  }








  }





//






//



