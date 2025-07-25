
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dcard/Query/CardQuery.dart';
import 'package:dcard/Utilconfig/HideShowState.dart';



import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:get/get.dart';


import 'package:dcard/models/Admin.dart';



import '../../models/CardModel.dart';
import '../../Query/AdminQuery.dart';
import '../../Query/StockQuery.dart';


import '../../Pages/components/BottomNavigator/HomeNavigator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import '../../Utilconfig/ConstantClassUtil.dart';






class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();


}
class _AddCardPageState extends State<AddCardPage> {


// Before Get.bottomSheet(...)
  final cardController = Get.put(CardQuery());


  TextEditingController uidInput=TextEditingController();
  TextEditingController uidInput2=TextEditingController();
  TextEditingController uidInput3=TextEditingController(text:"on1@gmail.com");
  TextEditingController uidInput4=TextEditingController(text:"+243");
  TextEditingController initCountry=TextEditingController(text:"CD");
  TextEditingController uidInput5=TextEditingController(text:"Congo,Democratic Republic of the Congo");
  TextEditingController uidInput6=TextEditingController(text:"1");
  TextEditingController uidInput7=TextEditingController();
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR2');
  Barcode?result;
  QRViewController?controller;
  bool Cameravalues=false;
  bool Flashvalues=false;
  bool showOveray=false;
  bool isValid = false;

  /* picture upload*/
  XFile? _imageFile;


  @override

  @override
  Widget build(BuildContext context)
  {


    void reassemble(){
      super.reassemble();
      if(Platform.isAndroid)
      {
        controller!.resumeCamera();
      }else if (Platform.isIOS)
      {
        controller!.pauseCamera();
      }
    }

    //hidekeyboard();
    //UserQuery userQueryData = Get.put(UserQuery());


    // ParticipatedQuery participatedState=Get.put(ParticipatedQuery());


    //FocusScope.of(context).unfocus();//hide keyboard on screen loading
    return Scaffold(
      body:Stack(
        children: [
          Column(
            children: [

              Visibility(
                visible:true,
                child: Expanded(
                    flex: 6,
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
                                  Flashvalues ? 'images/on.png' : 'images/off.png',
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    )

                ),

              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () async=>{
                              //await controller!.toggleFlash(),
                              // Wakelock.enable()
                              // await controller!.pauseCamera(),
                              //Get.to(() => Homepage()),
                              Get.dialog(


                                AlertDialog(
                                  title: Center(child: Text('Message')),
                                  content: Container(
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Center(child: Icon(Icons.thumb_up_alt_outlined, color: Colors.green)),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text('This is an alert message.'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text('Close'),
                                    ),
                                  ],
                                ),
                              )



                            },

                            child: const Text("alert")
                        ),
                        TextButton(
                            onPressed: () async=>{
                              //await controller!.toggleFlash(),
                              // Wakelock.enable()
                              // await controller!.pauseCamera(),
                              //Get.to(() => Homepage()),
                              ScanPopup("none"),


                            },

                            child: const Text("Enable")
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if(showOveray)
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
      ),
      bottomNavigationBar:HomeNavigator(),

    );

  }
  //image
  Future<XFile?> pickImage({required ImageSource source}) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
    return pickedImage;
    //print("${arguments["title"]}");
    /* setState(() {
      _imageFile = pickedImage;
      (Get.put(StockQuery()).updateImageFile(pickedImage));
    });
    Get.back();*/
    //_compressAndUploadImage();

  }
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await pickImage(source: source);
    if (pickedImage != null) {

      // print("${arguments["title"]}");
      setState(() {
        _imageFile = pickedImage;
        //_imageFile
        (Get.put(CardQuery()).updateImageFile(pickedImage));
        //(Get.put(StockQuery()).updateImageFile(pickedImage));
      });

     // _compressAndUploadImage();
      Get.dialog(
        AlertDialog(
          title: const Text('Confirm?'),
          content:Text('Are you Sure ${uidInput2.text} have this Number ${uidInput4.text+""+uidInput.text}? '),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(

                //primary: Colors.grey[300],
                backgroundColor: const Color(0xff9a1c55),
                foregroundColor: Colors.white,
                elevation:0,
              ),
              onPressed: () async{
                Get.back();
                _compressAndUploadImage();
              },
              child: const Text('Yes'),
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


    }
  }
  Map<String, dynamic>? extractJson(String raw) {
    try {
      // Find the position of the first {
      int startIndex = raw.indexOf('{');
      if (startIndex == -1) return null;

      // Try to decode from that position
      String jsonString = raw.substring(startIndex);
      return json.decode(jsonString);
    } catch (e) {
      print("Failed to parse JSON: $e");
      return null;
    }
  }
  Future<void> _compressAndUploadImage() async {
    //(Get.put(StockQuery()).updateHideLoader(false));
    setState(() {
      showOveray=true;
    });
    if (_imageFile == null) return;

    final compressedImage = await compressImage(_imageFile);
    if (compressedImage == null) return;

    // Upload or store the compressed image here.

    // Create a Dio instance.
    final dioInstance = dio.Dio();
    String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
    dioInstance.options.headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'multipart/form-data',

    };

    // Replace this URL with your server's endpoint for uploading images.
     String uploadUrl = '${ConstantClassUtil.urlLink}/CreateUserAssign';

    try {
      // Use Dio to upload the compressed image.
      final response = await dioInstance.post(
        uploadUrl,
        data: dio.FormData.fromMap({
          'image': dio.MultipartFile.fromBytes(
            compressedImage as List<int>,
            filename: _imageFile!.name,
          ),
          "name":uidInput2.text,
          "email":uidInput3.text??'none',
          "Ccode":uidInput4.text,
          "phone":uidInput.text,
          "initCountry":initCountry.text,
          "country":uidInput5.text,
          "password":uidInput6.text??'none',
          //"carduid":"TEALTD_7hEnj_1672352175",
          "carduid":uidInput7.text



        }),
        options: dio.Options(
          responseType: dio.ResponseType.plain, // 👈 Add this line
        ),
      );

      // Handle the response from the server.
      if (response.statusCode == 200) {


        final result = extractJson(response.data);
        if (result != null) {
          /*print("Status: ${result['status']}");
          print("Phone: ${result['phone']}");
          print("Email: ${result['Email']}");*/
          if(result['status'])
            {
              setState(() {
                showOveray=false;
              });
    uidInput7.text="";
    Get.close(1);
    controller!.resumeCamera();
    Get.snackbar("Success", "Card Addedd",backgroundColor: Color(0xff9a1c55),
    colorText: Color(0xffffffff),
    titleText: const Text("Card User",style:TextStyle(color:Color(
    0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

    icon: Icon(Icons.access_alarm),
    duration: Duration(seconds: 4));

            }
          else{
            setState(() {
              showOveray=false;
            });
    uidInput7.text="";
    Get.close(1);
    controller!.resumeCamera();
    Get.snackbar("Error", "Card ,Card Can't be assigned please Contact System Admin",backgroundColor: Color(
    0xffdc2323),
    colorText: Color(0xffffffff),
    titleText: const Text("Card User",style:TextStyle(color:Color(
    0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

    icon: Icon(Icons.access_alarm),
    duration: Duration(seconds: 4));

    }
        } else {
          Get.close(1);
          setState(() {
            showOveray=false;
          });
        }
        //(Get.put(StockQuery()).updateHideLoader(true));
        //Get.back(result:'$currentTimestamp');
        //print('Image uploaded successfully ${response}');
      } else {
        Get.close(1);
        setState(() {
          showOveray=false;
        });
        //print("something Wrong");
      }
    } catch (e) {
      Get.close(1);
      setState(() {
        showOveray=false;
      });
      if (e is dio.DioException) {
        print('DioException: ${e.response?.statusCode}');
        print('DioException: ${e.message}');
        print('Response: ${e.response?.data}');

      } else {
        print('Unknown error: $e');
      }
    }
  }
  Future<Uint8List?> compressImage(XFile? imageFile) async {
    if (imageFile == null) return null;

    final compressedImage = await FlutterImageCompress.compressWithFile(
      imageFile.path,
      minWidth: 600, // Adjust these to lower values if needed
      minHeight: 600,
      quality: 50, // Lower quality for faster compression
      format: CompressFormat.jpeg, // Use CompressFormat directly.
    );

    return compressedImage;
  }


  //image
  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) {
      setState((){
        result=scanData;

        String CheckCode=(result!=null)?"${result!.code}":"0";
        ScanPopup(CheckCode);
      });
    });
  }
  @override
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

        value: Cameravalues,
        onChanged:(value)async{
          setState((){
            this.Cameravalues=value;

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

        value:Flashvalues,
        onChanged:(value)async{
          setState((){
            this.Flashvalues=value;

            //print(value);
          });
          await controller!.toggleFlash();
        }
    ),
  );

  ScanPopup(checkcode){
controller!.pauseCamera();
uidInput7.text=checkcode;

    Get.bottomSheet(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 400,

              child: ListView(
                children: [
                  Container(

                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ListView(
                      children: [

                        MyTextWidget()
                      ],
                    ),
                  ),
                ],
              ),
            ),


          ],
        )
    ).whenComplete(() {
      controller!.resumeCamera();
      //do whatever you want after closing the bottom sheet
    });
  }
  Widget MyTextWidget(){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(

        children: [
          Center(
              child:Column(
                children: [
                  SizedBox(height: 8,),
                  // (result!=null)?Text("barcode Type ${describeEnum(result!.format)} Data ${result!.code}"): const Text("Scan Code"),
                  (result!=null)?Text("${result!.code}"): const Text("Scan Code"),

                  Column(
                    children: [
                      SizedBox(height: 8,),
                      IntlPhoneField(
                        initialCountryCode: 'CD',
                        controller: uidInput,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          suffixIcon:Obx(() => Get.put(HideShowState()).isNumberValid.value?Icon(Icons.done,color:Colors.green,):Icon(Icons.dangerous,color:Colors.red,)),

                        ),
                        onChanged: (phone) {

                          //uidInput4.text=phone.countryCode;
                          //uidInput2.text=phone.number;
                          // uidInput2.text=phone.countryISOCode;
                          //print(phone.completeNumber);

                          if((uidInput.text).isPhoneNumber)
                          {
                            Get.put(HideShowState()).isValid(true);


                          }
                          else{
                            Get.put(HideShowState()).isValid(false);

                            // print("not empty");
                          }

                        },

                        onCountryChanged: (country) {
                          //print("gegr");

                          uidInput4.text="+"+country.dialCode;
                          //uidInput4.text="+"+country.dialCode;
                          uidInput5.text=country.name;
                          initCountry.text=country.code;
                          // print('Country changed to: ' + country.name);
                          // print('Country changed to: ' + country.dialCode);

                          if((uidInput.text).isPhoneNumber)
                          {
                            Get.put(HideShowState()).isValid(true);
                          }
                          else{
                            Get.put(HideShowState()).isValid(false);
                          }
                        },
                      ),
                      TextField(
                        controller: uidInput2,



                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                          border: OutlineInputBorder(),
                          labelText: 'Name',

                          hintText: 'Enter your name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),

                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Visibility(
                        visible: false,
                        child: TextField(
                          controller: uidInput3,

                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter your Email',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                        ),
                      ),

                      Visibility(
                        visible: false,
                        child: TextField(
                          controller: uidInput4,
                          //obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'country Code',
                            hintText: 'country Code',
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
                          controller: uidInput6,
                          //obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter your Password',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Visibility(
                        visible: false,
                        child: TextField(
                          controller: uidInput7,
                          //obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'CardUData',
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                        ),
                      ),

                    ],
                  ),

                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: GetBuilder<CardQuery>(
                      builder: (controller) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (controller.imageFile != null)
                              Image.file(
                                File(controller.imageFile!.path),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),

                          ],
                        );
                      },
                    ),
                  ),
              Obx(() =>
                  Visibility(
                    visible:Get.put(HideShowState()).isNumberValid.value ,
                    child: IconButton(
                      onPressed: (
                          //_pickImage(ImageSource.camera);

                          ) {
                        _pickImage(ImageSource.camera);
                      },
                      icon: Icon(Icons.camera),
                    ),
                  ),
              ),
                  SizedBox(height: 10.0,),



                ],
              )

          ),

        ],
      ),

    );
  }
  loadData() async{
    //await PromotionQuery().getAllPromotionEventOnline();
    // Perform data loading here
    // Map<String, dynamic> _data=((await PromotionQuery().getAllPromotionEventOnline()));
    //print(_data);

    // return _data;
    //return ((await PromotionQuery().getAllPromotionEventOnline()));
  }
//Method

//method
}


