
import 'package:dcard/models/Admin.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Query/CardQuery.dart';
import '../../models/CardModel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';





class SetEditCardNoComp extends StatefulWidget {
  const SetEditCardNoComp({Key? key}) : super(key: key);

  @override
  State<SetEditCardNoComp> createState() => _SetEditCardNoCompState();
}

class _SetEditCardNoCompState extends State<SetEditCardNoComp> {
  TextEditingController uidData=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();

  TextEditingController uidInput=TextEditingController();

  TextEditingController uidInput4=TextEditingController(text:"+243");
  TextEditingController initCountry=TextEditingController(text:"CD");
  TextEditingController uidInput5=TextEditingController(text:"Congo,Democratic Republic of the Congo");
  TextEditingController password=TextEditingController();
  TextEditingController status=TextEditingController(text:"card");
  TextEditingController carduid=TextEditingController();

  bool isValid = false;
  bool isSubmit=false;
  bool isQrShow=false;



  int limit=0;
  bool hasMoreData=true;
  bool isLoading=false;

  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode?result;
  QRViewController?controller;
  bool Cameravalue=false;
  bool Flashvalue=false;


  @override
  Widget build(BuildContext context) {



    //return listdata();

    /*WidgetsBinding.instance.addPostFrameCallback((_) {

      QuickBonus();
    });*/
    return Scaffold(body: Stack(
      children: [
        listdata(),
        if(isLoading)
          Positioned.fill(
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white70,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],

    )
    );
    //return Center(child: Text("hello"));




  }
  Widget listdata(){
    return  Column(
      children: [
        //ProfilePic().profile(),

        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text("Edit Your Card",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
        ),
        Text(name.text,style:GoogleFonts.bebasNeue(fontSize:20),),
        Text(carduid.text,style: GoogleFonts.robotoCondensed(fontSize:15),),
        isQrShow?
        Expanded(
            flex: 5,
            child:Stack(
              alignment:Alignment.bottomCenter,
              children: [
                QRView(key: qrkey,onQRViewCreated: _onQRViewCreated,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        CameraSwitch(),
                        //SizedBox(width: 10.0,),

                        // SizedBox(width: 10.0,),
                        FlashSwitch(),
                        Image.asset(
                          Flashvalue ? 'images/on.png' : 'images/off.png',
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            )

        )
            :Visibility(
            visible: false,
            child: Text("")),
        isValid?Container(
            height: 80,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('scan card'),
              onPressed: (){

                setState(() {
                  isQrShow=true;
                });
                //print(uidInput.text);
                //print(await loginOnline());

                // Get.to(() =>Aboutpage());
              },
            )):Visibility(
            visible: false,
            child: Text("")),

//component
      Expanded(
        flex:2,
          child:ListView(
            children: [

              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child:  IntlPhoneField(
                  initialCountryCode: 'CD',
                  controller: uidInput,
                  autofocus: true,

                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    suffixIcon: isValid?Icon(Icons.done,color:Colors.green,):Icon(Icons.dangerous,color:Colors.red,),

                  ),


                  onChanged: (phone) async{

                    if((uidInput.text).isPhoneNumber)
                    {

                      getDataFromNo(phone.number);



                    }
                    else{
                      setState(() {
                        isValid=false;

                      });
                    }


                    //uidInput4.text=phone.countryCode;
                    //uidInput2.text=phone.number;
                    // uidInput2.text=phone.countryISOCode;
                    //print(phone.completeNumber);



                  },

                  onCountryChanged: (country) {

                    uidInput4.text="+"+country.dialCode;
                    uidInput5.text=country.name;
                    initCountry.text=country.code;

                    if((uidInput.text).isPhoneNumber)
                    {

                      getDataFromNo(uidInput.text);

                    }
                    else{
                      setState(() {
                        isValid=false;

                      });
                    }
                    // print('Country changed to: ' + country.name);
                    // print('Country changed to: ' + country.dialCode);
                  },
                ),
              ),
              Visibility(
                visible: false,
                child: TextField(
                  controller: uidData,
                  //obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                    border: OutlineInputBorder(),
                    labelText: 'uid',
                    hintText: 'uid',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),

                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16,0, 16, 0),
                child: TextField(
                  controller: name,
                  //obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                    border: OutlineInputBorder(),

                    labelText: 'name',
                    hintText: 'name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),


                  ),
                ),
              ),
              Visibility(
                visible: false,
                child: TextField(
                  controller: email,
                  //obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                    border: OutlineInputBorder(),
                    labelText: 'email',
                    hintText: 'email',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),

                  ),
                ),
              ),

              Visibility(
                visible:false,
                child: TextField(
                  controller: uidInput4,
                  //obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                    border: OutlineInputBorder(),
                    labelText: 'Ccode',
                    hintText: 'Ccode',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),

                  ),
                ),
              ),
              Visibility(
                visible: false,
                child: TextField(
                  controller: uidInput5,
                  //obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                    border: OutlineInputBorder(),
                    labelText: 'Country',
                    hintText: 'Enter Country',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),

                  ),
                ),
              ),
              Visibility(
                visible: false,
                child: TextField(
                  controller: initCountry,
                  //obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                    border: OutlineInputBorder(),
                    labelText: 'Country',
                    hintText: 'Enter Country',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),

                  ),
                ),
              ),
              Visibility(
                visible:false,
                child: TextField(
                  controller:password,
                  //obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                    border: OutlineInputBorder(),
                    labelText: 'password',
                    hintText: 'password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),

                  ),
                ),
              ),
              Visibility(
                visible:false,
                child: TextField(
                  controller:status,
                  //obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                    border: OutlineInputBorder(),
                    labelText: 'status',
                    hintText: 'status',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),

                  ),
                ),
              ),
              Visibility(
                visible: false,
                child: Container(
                  padding: EdgeInsets.fromLTRB(16,16,16,0),
                  child: TextField(
                    controller:carduid,
                    //obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                      border: OutlineInputBorder(),
                      labelText: 'cardui',
                      hintText: 'cardui',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),

                    ),
                  ),
                ),
              ),
              //Qr Show

              //Qr Show

              isSubmit?isValid?Container(
                  height: 90,
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor:Colors.black

                    ),
                    child: const Text('Edit'),
                    onPressed: () async{
                      setState(() {
                        isLoading=true;
                      });


                      var resultData=(await CardQuery().editAssignCardEventOnline(CardModel(uid:carduid.text),Admin(uid:uidData.text,name:name.text,email:email.text,Ccode:uidInput4.text,phone:uidInput.text,initCountry:initCountry.text,country:uidInput5.text,password:password.text,status:status.text,subscriber:"none"))).data;
                    //print(resultData);

                      if(resultData["status"])
                      {
                        setState(() {
                          isLoading=false;
                        });



                        Get.snackbar("Success", "Profile Edited Successfuly",backgroundColor: Color(0xff9a1c55),
                            colorText: Color(0xffffffff),
                            titleText: const Text("Card User",style:TextStyle(color:Color(
                                0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                            icon: Icon(Icons.access_alarm),
                            duration: Duration(seconds: 4));
                      }
                      else{
                        setState(() {
                          isLoading=false;
                        });


                        Get.snackbar("Error", "${resultData["message"]??"System Error use another Card"} ,Or Please Contact System Admin",backgroundColor: Color(
                            0xffdc2323),
                            colorText: Color(0xffffffff),
                            titleText: const Text("Card User",style:TextStyle(color:Color(
                                0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                            icon: Icon(Icons.access_alarm),
                            duration: Duration(seconds: 4));

                      }
                    },
                  )):
              Visibility(
                  visible: false,
                  child: Text("")):Visibility(
                  visible: false,
                  child: Text("")),
            ],
          )

      ),


      ],
    );
  }


  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) async{
      setState((){
        result=scanData;
        String checkcode=(result!=null)?"${result!.code}":"0";
        scanMethod(checkcode);
      });

    });
  }

  getDataFromNo(phoneNumber) async{
    setState(() {
      isLoading=true;
    });

    var resultData=(await CardQuery().getNumberDetailCardOnline(Admin(uid: "tets", subscriber: "test",phone:phoneNumber,Ccode: uidInput4.text))).data;
    if(resultData["status"])
    {
    uidData.text=resultData["UserDetail"]["uid"];
    name.text=resultData["UserDetail"]["name"];
    email.text=resultData["UserDetail"]["email"];
    initCountry.text=resultData["UserDetail"]["initCountry"];
    password.text=resultData["UserDetail"]["password"]??'none';

    //print(resultData);
    setState(() {
    isValid=true;
    isLoading=false;
    });
    }
    else{

    setState(() {
    isValid=false;
    isLoading=false;
    });



    }
  }
  scanMethod(checkcode){
    controller!.pauseCamera();
    carduid.text=checkcode;
    setState((){
    isQrShow=false;
    isSubmit=true;
    });



  }

  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  Widget CameraSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
        activeColor: Colors.red,
        activeTrackColor: Colors.red.withOpacity(0.4),
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.blueAccent,

        value: Cameravalue,
        onChanged:(value)async{
          setState((){
            this.Cameravalue=value;

            //print(value);
          });
          await controller!.resumeCamera();
        }
    ),
  );
  Widget FlashSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
        activeColor: Colors.red,
        activeTrackColor: Colors.red.withOpacity(0.4),
        inactiveThumbColor: Colors.orange,
        inactiveTrackColor: Colors.blueAccent,

        value:Flashvalue,
        onChanged:(value)async{
          setState((){
            this.Flashvalue=value;

            //print(value);
          });
          await controller!.toggleFlash();
        }
    ),
  );



  //






//
}


