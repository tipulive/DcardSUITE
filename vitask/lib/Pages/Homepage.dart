import 'dart:convert';
import 'dart:io';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../models/Transport.dart';

import '../Query/AdminQuery.dart';

import '../Query/StockQuery.dart';
import '../Utilconfig/HideShowState.dart';
import '../models/Admin.dart';
import '../Utilconfig/ConstantClassUtil.dart';
import 'package:animate_do/animate_do.dart';

import '../models/Participated.dart';
import '../models/Promotions.dart';
import 'SetSalePage.dart';

class CountryModel {
  final String name;
  final String fName;
  final String flag;

  CountryModel({required this.name, required this.fName, required this.flag});
}
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController = ScrollController();// detect scroll
  TextEditingController  uidInput=TextEditingController();
  TextEditingController uidInput2=TextEditingController(text:"");
  TextEditingController uidInput3=TextEditingController();
  TextEditingController frominput=TextEditingController();

  AdminQuery adminStatedata=Get.put(AdminQuery());
  bool showOveray=false;
  bool isValid=false;
  String tokenNumber="";
  String from="";
  String to="";
  String timeOn="";
  String uidBook="";
  String chooseSeat="";
  String locationDisp="";
  String timeDisp="";
  String DateDisp="";

  final List<CountryModel> countries = [
    CountryModel(name: 'USD',fName:'USA', flag: '🇺🇸'),
    CountryModel(name: 'FC',fName:'DR Congo',flag: '🇨🇩'),
    //CountryModel(name: 'GBP',fName:'United Kingdom', flag: '🇬🇧'),
   // CountryModel(name: 'FRW', fName:'Rwanda',flag: '🇷🇼'), // Rwanda

    // Add more countries as needed
  ];
  bool hasMoreData=true;
  String? selectedCountry;
  List<String> suggestions = [];
  final List<dynamic> _data=[];
  List<String> allData =  [];
  viewSeat() async{

    var resultData = (await StockQuery().viewSeat(Transport(uidTransport:"uid_Hp_1730839465",seat:"60"))).data ;


    if(resultData["status"])
    {

     // print((resultData["result"]).cast<String>());

  allData=(resultData["result"]).cast<String>();


      return allData;


    }
    else{

    }

  }

  Widget formTDate(dateOn)
  {
    List<String> parts = dateOn.split(' ');
    String date = parts[0]; // "2024-07-03"

    return Text(date);
  }
  Widget formTime(dateOn)
  {
    List<String> parts = dateOn.split(' ');
    String date = parts[1]; // "2024-07-03"

    return Text(date);
  }

  searchTransport() async{



    var resultData=(await StockQuery().searchTransport(Transport(origin:from,destination:to,dateOn:_dateController.text,searchOption:timeOn))).data;
    if(resultData["status"])
    {

print(resultData["status"]);

      if(resultData["result"]!=0)
      {

        setState(() {

          _data.clear();
          _data.addAll(resultData["result"]);

        });
      }
      else{
        setState(() {

          _data.clear();


        });
      }




    }
    else{
      setState(() {

        _data.clear();


      });
    }


  }
  bookTicket() async{

    var resultData=(await StockQuery().bookTicket(Transport(uidTransport:uidBook,seat:chooseSeat,name:uidInput.text,phone:uidInput2.text,commentData:"test"))).data;
    if(resultData["status"])
    {

    print(resultData["status"]);

    if(resultData["result"]!=0)
    {

    setState(() {

    _data.clear();
    _data.addAll(resultData["result"]);

    });
    }
    else{
    setState(() {

    _data.clear();


    });
    }




    }
    else{
    setState(() {

    _data.clear();


    });
    }

  }
  Future<List<String>> fetchSuggestions(String inputSearch,String searchOption) async {
    // Replace with your API endpoint


    try {
      var response = (await StockQuery().viewSearchLocation(Transport(searchItem:inputSearch,searchOption:searchOption))).data ;


      if (response["status"]) {
        // Parse the API response


        // Extract `origin` from each object in the response
        final List<String> origins = response["result"].map<String>((item) => item[searchOption].toString()).toList();

        // Filter origins based on the query
        return origins.where((origin) => origin.toLowerCase().contains(inputSearch.toLowerCase())).toList();
      } else {
        throw Exception('Failed to fetch suggestions');
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
      return [];
    }
  }


  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        timeOn="dateON";
        _dateController.text =
        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }
  Future<void> _selectDateTime(BuildContext context) async {
    // Step 1: Show the date picker
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Step 2: Show the time picker
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // Combine date and time into a DateTime object
        DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Step 3: Update the TextField with formatted DateTime
        setState(() {
          timeOn="timeOn";
          _dateController.text = DateFormat('yyyy-MM-dd HH:mm:ss')
              .format(finalDateTime); // Customizable format
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Set the default selected country to "United States"
    //searchTransport();
    _initBluetooth();
    selectedCountry = 'USD';

  }

  //printer//

  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;
  bool _connected = false;

  // Initialize Bluetooth without enabling it explicitly
  void _initBluetooth() async {
    try {
      // Get bonded devices directly without checking if Bluetooth is enabled
      List<BluetoothDevice> devices = await printer.getBondedDevices();
      setState(() {
        _devices = devices;

      });
      print("test keb ${_devices[0].name}");
      _connectToPrinter(_devices[0]);
    } catch (e) {
      print('Error initializing Bluetooth: $e');
    }
  }

  // Connect to a Bluetooth printer
  void _connectToPrinter(BluetoothDevice device) async {
    if (_connected) {
      print("already connected");
    } else {
      try {
        await printer.connect(device);
        print("connected");
        setState(() {
          _connected = true;
        });
      } catch (e) {
        print('Error connecting to printer: $e');
        setState(() {
          _connected = true;
        });
      }
    }
  }
  void _printReceipt(curDate,curTime,name,token2,uid,cashPower,amount,currencyD) async {
    if (_connected) {
      // Store name and header
      // Barcode for receipt validation (EAN13)


      printer.printCustom("Cash P/No:${cashPower}", 3, 1);  // Bold, Centered
      printer.printNewLine();
      printer.printCustom("Thank you for shopping with us!", 1, 1);  // Normal, Centered
      printer.printNewLine();

      // Customer and purchase details
      printer.printLeftRight("Date:", curDate, 0);
      printer.printLeftRight("Time:", curTime, 0);
      printer.printLeftRight("Cashier:", name, 0);

      printer.printNewLine();

      // Purchase items
      printer.printCustom("Token", 1, 1);
      printer.printNewLine();
      printer.printCustom(token2, 1, 1);

      printer.printNewLine();

      // Total cost
      printer.printLeftRight("Total:", "${currencyD} ${amount}", 1);
      printer.printNewLine();

      // Mobile money payment info
      printer.printCustom("Payment via POS", 1, 1);
      printer.printCustom("Transaction ID: ${uid}", 0, 1);
      printer.printNewLine();

      // Barcode for receipt validation (EAN13)
      //printer.printQRcode("123456789012", 300, 300, 1);  // Type: EAN13, Height: 100
      printer.printQRcode("${uid}", 250, 250,1);
      printer.printNewLine();
      printer.printCustom("Powered by Ericsoft!", 1, 1);
      printer.printNewLine();

      // Add powered by line
      printer.printCustom("Powered by Ericsoft", 0, 1);  // Normal, Centered
      printer.printNewLine();
      printer.paperCut();

      // Optionally disconnect after printing
      await printer.disconnect();
      setState(() {
        _connected = false;
      });
    }
  }
  void _printSample() async {
    if (_connected) {
      // Store name and header
      // Barcode for receipt validation (EAN13)


      printer.printCustom("Your Local Store", 3, 1);  // Bold, Centered
      printer.printNewLine();
      printer.printCustom("Thank you for shopping with us!", 1, 1);  // Normal, Centered
      printer.printNewLine();

      // Customer and purchase details
      printer.printLeftRight("Date:", "2024-09-22", 0);
      printer.printLeftRight("Time:", "13:30", 0);
      printer.printLeftRight("Cashier:", "Eric Ford", 0);
      printer.printNewLine();

      // Purchase items
      printer.printCustom("Item Description", 1, 0);
      printer.printLeftRight("Sugar (1kg)", "RWF 1000", 0);
      printer.printLeftRight("Milk (500ml)", "RWF 500", 0);
      printer.printLeftRight("Bread (1 loaf)", "RWF 700", 0);
      printer.printLeftRight("Sugar (1kg)", "RWF 1000", 0);
      printer.printLeftRight("Milk (500ml)", "RWF 500", 0);
      printer.printLeftRight("Bread (1 loaf)", "RWF 700", 0);

      printer.printNewLine();

      // Total cost
      printer.printLeftRight("Total:", "RWF 2200", 1);
      printer.printNewLine();

      // Mobile money payment info
      printer.printCustom("Payment via MTN Mobile Money", 1, 1);
      printer.printCustom("Transaction ID: 1234567890", 0, 1);
      printer.printNewLine();

      // Barcode for receipt validation (EAN13)
      //printer.printQRcode("123456789012", 300, 300, 1);  // Type: EAN13, Height: 100
      printer.printQRcode("123456789012", 250, 250,1);
      printer.printNewLine();
      printer.printCustom("Powered by Ericsoft!", 1, 1);
      printer.printNewLine();

      // Add powered by line
      printer.printCustom("Powered by Ericsoft", 0, 1);  // Normal, Centered
      printer.printNewLine();
      printer.paperCut();

      // Optionally disconnect after printing
      await printer.disconnect();
      setState(() {
        _connected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                // Dismiss the keyboard when tapping outside of text field
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                // Ensure that content is pushed above the keyboard
                  reverse: true,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/background.png'),
                                  fit: BoxFit.fill
                              )
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 30,
                                width: 80,
                                height: 200,
                                child: FadeInUp(duration: const Duration(seconds: 1), child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('images/light-1.png')
                                      )
                                  ),
                                )),
                              ),
                              Positioned(
                                left: 140,
                                width: 80,
                                height: 150,
                                child: FadeInUp(duration: const Duration(milliseconds: 1200), child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('images/light-2.png')
                                      )
                                  ),
                                )),
                              ),
                              Positioned(
                                right: 40,
                                top: 40,
                                width: 80,
                                height: 150,
                                child: FadeInUp(duration: const Duration(milliseconds: 1300), child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('images/clock.png')
                                      )
                                  ),
                                )),
                              ),


                              //Menu top
                              Positioned(
                                right: 0,
                                top: -20,
                                width: 80,
                                height: 150,
                                child: FadeInUp(duration: const Duration(milliseconds: 1300), child: PopupMenuButton(
                                  color: Colors.white,

                                  itemBuilder:(container)=>[
                                    PopupMenuItem(
                                        child: InkWell(
                                          onTap: () async{
                                            Get.to(() =>const SetSalePage());


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
                                                    padding: EdgeInsets.only(left:10.0),
                                                    child: Text("Sales",style: TextStyle( fontWeight: FontWeight.bold),),
                                                  ),


                                                ],
                                              ),
                                              Divider(
                                                height: 20, // Adjust the height as needed
                                                thickness: 0.2, // Adjust the thickness as needed
                                                color: Colors.grey,
                                              ),

                                            ],
                                          ),
                                        )
                                    ),
                                    PopupMenuItem(
                                        child: InkWell(
                                          onTap: () async{



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
                                                    padding: EdgeInsets.only(left:10.0),
                                                    child: Text("Purchase",style: TextStyle( fontWeight: FontWeight.bold),),
                                                  ),

                                                ],
                                              ),
                                              Divider(
                                                height: 20, // Adjust the height as needed
                                                thickness: 0.2, // Adjust the thickness as needed
                                                color: Colors.grey,
                                              ),

                                            ],
                                          ),
                                        )
                                    ),
                                    PopupMenuItem(
                                        child: InkWell(
                                          onTap: () async{



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
                                                    padding: EdgeInsets.only(left:10.0),
                                                    child: Text("Account",style: TextStyle( fontWeight: FontWeight.bold),),
                                                  ),

                                                ],
                                              ),
                                              Divider(
                                                height: 20, // Adjust the height as needed
                                                thickness: 0.2, // Adjust the thickness as needed
                                                color: Colors.grey,
                                              ),

                                            ],
                                          ),
                                        )
                                    ),
                                    PopupMenuItem(
                                        child: InkWell(
                                          onTap: () async{

                                            Get.dialog(
                                              AlertDialog(
                                                title: const Text('Confirmation'),
                                                content: const Text('Do you Want to Logout?'),
                                                actions: [
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(

                                                      //primary: Colors.grey[300],
                                                      backgroundColor: const Color(0xff9a1c55),
                                                      elevation:0,
                                                    ),
                                                    onPressed: () async{
                                                      await Get.put(AdminQuery()).logout();

                                                      Get.toNamed('/Login');
                                                    },
                                                    child: const Text('Yes',style: TextStyle(
                                                        color: Colors.white
                                                    ),),
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
                                                    padding: EdgeInsets.only(left:10.0),
                                                    child: Text("Logout",style: TextStyle( fontWeight: FontWeight.bold),),
                                                  ),

                                                ],
                                              ),
                                              Divider(
                                                height: 20, // Adjust the height as needed
                                                thickness: 0.2, // Adjust the thickness as needed
                                                color: Colors.grey,
                                              ),

                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                  offset: const Offset(-30, 90),
                                  child:InkWell(

                                    child: Ink(

                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Icon(

                                          Icons.menu, // Replace with your desired icon
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ),
                              Positioned(
                                child: FadeInUp(duration: const Duration(milliseconds: 1600), child: Container(
                                  margin: const EdgeInsets.only(top: 50),
                                  child: const Center(
                                    child: Text("Sell", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                                  ),
                                )),
                              ),

                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left:15,right:15),
                          child: Column(
                            children: <Widget>[
                              FadeInUp(duration: Duration(milliseconds: 1800), child: Container(
                                padding: EdgeInsets.all(20),
                                decoration:  BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: const Color.fromRGBO(143, 148, 251, 1)),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10)
                                      )
                                    ]
                                ),
                                child: Column(
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Icons and Stepper
                                          Column(
                                            children: [
                                              SizedBox(height: 15),
                                              Icon(Icons.location_on, color: Colors.red, size: 30), // "From" Icon
                                              SizedBox(height: 10),
                                              ...List.generate(
                                                5, // Number of dots
                                                    (index) => Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                  child: Container(
                                                    width: 4,
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Icon(Icons.location_on, color: Colors.blue, size: 30), // "To" Icon
                                            ],
                                          ),

                                          // Input Fields
                                          Expanded(
                                            child: Column(
                                              children: [
                                                // "From" Field
                                                Padding(
                                                  padding: const EdgeInsets.all(0.0),
                                                  child: SizedBox(
                                                    width: 250, // Set width for the TextField
                                                    child: Autocomplete<String>(
                                                      optionsBuilder: (TextEditingValue textEditingValue) async {
                                                        if (textEditingValue.text.isEmpty) {
                                                          return const Iterable<String>.empty();
                                                        }
                                                        suggestions = await fetchSuggestions(textEditingValue.text,'origin');
                                                        return suggestions;
                                                      },
                                                      onSelected: (String selection) {
                                                        from=selection;
                                                      },
                                                      fieldViewBuilder: (BuildContext context,
                                                          TextEditingController fromTextEditingController,
                                                          FocusNode fieldFocusNode,
                                                          VoidCallback onFieldSubmitted) {



                                                        return Container(
                                                          padding: const EdgeInsets.all(8.0),
                                                          decoration: const BoxDecoration(
                                                            border: Border(
                                                              bottom: BorderSide(color: Color.fromRGBO(143, 148, 251, 1)),
                                                            ),
                                                          ),
                                                          child: TextField(
                                                            controller: fromTextEditingController,
                                                            focusNode: fieldFocusNode,
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              hintText: "From",
                                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      optionsViewBuilder: (BuildContext context,
                                                          AutocompleteOnSelected<String> onSelected,
                                                          Iterable<String> options) {
                                                        return Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Material(
                                                            elevation: 4.0,
                                                            child: Container(
                                                              width: 250,
                                                              constraints: BoxConstraints(
                                                                maxHeight: 250, // Set a max height for the dropdown to enable scrolling
                                                              ),// Set the width for the dropdown here
                                                              color: Colors.white,
                                                              child: ListView.separated(
                                                                padding: EdgeInsets.zero,
                                                                shrinkWrap: true,
                                                                itemCount: options.length,
                                                                itemBuilder: (BuildContext context, int index) {
                                                                  final String option = options.elementAt(index);

                                                                  return InkWell(
                                                                    onTap: () => onSelected(option),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(20.0),
                                                                      child: Text(option),
                                                                    ),
                                                                  );
                                                                },
                                                                separatorBuilder: (BuildContext context, int index) {
                                                                  return const Divider(
                                                                    color: Colors.grey, // Divider color
                                                                    height: 1, // Space between items and divider
                                                                    thickness: 1, // Divider thickness
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),

                                                // "To" Field
                                                Padding(
                                                  padding: const EdgeInsets.all(0.0),
                                                  child: SizedBox(
                                                    width: 250, // Set width for the TextField
                                                    child: Autocomplete<String>(
                                                      optionsBuilder: (TextEditingValue textEditingValue) async {
                                                        if (textEditingValue.text.isEmpty) {
                                                          return const Iterable<String>.empty();
                                                        }
                                                        suggestions = await fetchSuggestions(textEditingValue.text,'destination');
                                                        return suggestions;
                                                      },
                                                      onSelected: (String selection) {

                                                        to=selection;
                                                      },
                                                      fieldViewBuilder: (BuildContext context,
                                                          TextEditingController toTextEditingController,
                                                          FocusNode fieldFocusNode,
                                                          VoidCallback onFieldSubmitted) {
                                                        return Container(
                                                          padding: const EdgeInsets.all(8.0),
                                                          decoration: const BoxDecoration(
                                                            border: Border(
                                                              bottom: BorderSide(color: Color.fromRGBO(143, 148, 251, 1)),
                                                            ),
                                                          ),
                                                          child: TextField(
                                                            controller: toTextEditingController,
                                                            focusNode: fieldFocusNode,
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              hintText: "To",
                                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      optionsViewBuilder: (BuildContext context,
                                                          AutocompleteOnSelected<String> onSelected,
                                                          Iterable<String> options) {
                                                        return Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Material(
                                                            elevation: 4.0,
                                                            child: Container(
                                                              width: 240, // Set the width for the dropdown here
                                                              constraints: BoxConstraints(
                                                                maxHeight: 250, // Set a max height for the dropdown to enable scrolling
                                                              ),
                                                              color: Colors.white,
                                                              child: ListView.separated(
                                                                padding: EdgeInsets.zero,
                                                                shrinkWrap: true,
                                                                itemCount: options.length,
                                                                itemBuilder: (BuildContext context, int index) {
                                                                  final String option = options.elementAt(index);

                                                                  return InkWell(
                                                                    onTap: () => onSelected(option),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(20.0),
                                                                      child: Text(option),
                                                                    ),
                                                                  );
                                                                },
                                                                separatorBuilder: (BuildContext context, int index) {
                                                                  return const Divider(
                                                                    color: Colors.grey, // Divider color
                                                                    height: 1, // Space between items and divider
                                                                    thickness: 1, // Divider thickness
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(

                                      padding: const EdgeInsets.only(left:25.0),
                                      child: Container(
                                        width: 255,

                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(color: Color.fromRGBO(143, 148, 251, 1)),
                                          ),
                                        ),
                                        child: TextField(
                                          controller: _dateController,
                                          readOnly: true,
                                          decoration: InputDecoration(

                                            border: InputBorder.none,
                                            hintText: "select Date",
                                            hintStyle: TextStyle(color: Colors.grey[700]),
                                            prefixIcon: IconButton(
                                              icon: Icon(Icons.calendar_month),
                                              onPressed: () => _selectDate(context),
                                            ),
                                           suffixIcon: IconButton(
                                              icon: Icon(Icons.timer),
                                              onPressed: () => _selectDateTime(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Visibility(
                                      visible: true,
                                      child: FadeInUp(duration: Duration(milliseconds: 1900), child: Container(
                                        height: 50,
                                        padding: EdgeInsets.only(left: 10,right: 10),
                                        child: Container(
                                          width: 200,
                                          child: ElevatedButton(

                                            style: ElevatedButton.styleFrom(

                                                minimumSize: const Size.fromHeight(50),
                                                backgroundColor:Color.fromRGBO(143, 148, 251, 1),
                                                foregroundColor: Colors.white

                                            ),

                                            child: const Text('Search'),
                                            onPressed: () async{
                                              await searchTransport();
                                            },
                                          ),
                                        ),
                                      )),
                                    ),




                                  ],
                                ),
                              )),
                              SizedBox(height: 30,),


                              ListView.builder(
                                shrinkWrap: true, // Take only as much height as needed
                                physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling
                                itemCount: _data.length,
                                itemBuilder: (context, index) {
                                  return  Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Card(
                                            elevation: 4.0,
                                            margin: EdgeInsets.all(2.0),
                                            child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Column(
                                                  children: [

                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child:formTDate(_data[index]["dateOn"])),
                                                        Align(
                                                            alignment: Alignment.topRight,
                                                            child: formTime(_data[index]["dateOn"])),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                    Row(
                                                      children: [

                                                        // Stepper with dotted line
                                                        Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            StepperDot(isActive: true),
                                                            DottedLine(height: 40),
                                                            StepperDot(isActive: false),
                                                          ],
                                                        ),
                                                        SizedBox(width: 12),
                                                        // From-to content
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [

                                                              Row(
                                                                children: [
                                                                  Icon(Icons.location_on, color: Colors.red),
                                                                  SizedBox(width: 8),
                                                                  Text(
                                                                    'From: ${ConstantClassUtil().capitalizeFirstLetter(_data[index]["origin"])}',
                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(thickness: 1, color: Colors.grey),
                                                              Row(
                                                                children: [
                                                                  Icon(Icons.location_on, color: Colors.green),
                                                                  SizedBox(width: 8),
                                                                  Text(
                                                                    'To: ${ConstantClassUtil().capitalizeFirstLetter(_data[index]["destination"])} ${_data[index]["tag"]=="none"?"":"(${_data[index]["tag"]})"} ',
                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // Price
                                                        Align(
                                                          alignment: Alignment.topRight,
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                            decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.circular(8.0),
                                                            ),
                                                            child: Text(
                                                              '\Frw ${_data[index]["price"]}',
                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                          Positioned(
                                            top:-10,
                                            right:50,
                                            left:50,

                                            child: Center(
                                                child:   Align(
                                                  alignment: Alignment.center,
                                                  child: ElevatedButton.icon(
                                                    onPressed: () {
                                                      // Handle button press
                                                      setState(() {
                                                        uidBook=_data[index]["dateOn"];
                                                        locationDisp="${ConstantClassUtil().capitalizeFirstLetter(_data[index]["origin"])}->${ConstantClassUtil().capitalizeFirstLetter(_data[index]["destination"])}${_data[index]["tag"]=="none"?"":"(${_data[index]["tag"]})"}";
                                                      });
                                                      bookTrip();
                                                    },
                                                    icon: Icon(Icons.directions_car, color: Colors.white),
                                                    label: Text('Book'),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.green,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                    ),
                                                  ),
                                                )
                                            ),),

                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                    ],

                                  );
                                },
                              ),







                              Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),

                            ],
                          ),
                        ),
                      ],
                    ),
                  )

              ),
            ),
          ],
        )
    );
  }


  void bookTrip() {

    Get.bottomSheet(

      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(children: [
                  Center(child: Text(locationDisp)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("05h00-6h00")),
                      Align(
                          alignment: Alignment.topRight,
                          child: Text("05h00-6h00")),
                    ],
                  ),
                  FadeInUp(duration: const Duration(milliseconds: 1800), child: Container(
                    padding: const EdgeInsets.all(5),
              
              
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color.fromRGBO(143, 148, 251, 1)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10)
                          )
                        ]
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SizedBox(
                            // Set width for the TextField
                            child: Autocomplete<String>(
                              optionsBuilder: (TextEditingValue textEditingValue) async {
                                if (textEditingValue.text.isEmpty) {
                                  //return const Iterable<String>.empty();
                                  return await viewSeat();


                                }
                                return allData.where((String option) {
                                  return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                });
                              },
                              onSelected: (String selection) {
                                chooseSeat=selection;
                                /*ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('You selected: $selection')),
                                );*/
                              },
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController fieldTextEditingController,
                                  FocusNode fieldFocusNode,
                                  VoidCallback onFieldSubmitted) {
                                return Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Color.fromRGBO(143, 148, 251, 1)),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: fieldTextEditingController,
                                    focusNode: fieldFocusNode,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: IconButton(
                                        icon: Icon(Icons.event_seat,color: Colors.blue,),
                                        onPressed: (){},
                                      ),
                                      hintText: "Choose Seat",
                                      hintStyle: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ),
                                );
                              },
                              optionsViewBuilder: (BuildContext context,
                                  AutocompleteOnSelected<String> onSelected,
                                  Iterable<String> options) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4.0,
                                    child: Container(
                                      width: 310,
                                      //height: 300,
                                      constraints: BoxConstraints(
                                        maxHeight: 150, // Set a max height for the dropdown to enable scrolling
                                      ),

                                      // Set the width for the dropdown here
                                      color: Colors.white,
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,

                                        itemCount: options.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          final String option = options.elementAt(index);

                                          return InkWell(
                                            onTap: () => onSelected(option),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text(option),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (BuildContext context, int index) {
                                          return const Divider(
                                            color: Colors.grey, // Divider color
                                            height: 1, // Space between items and divider
                                            thickness: 1, // Divider thickness
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
                          ),
                          child: TextField(
                            controller: uidInput,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name:",
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.person,color: Colors.blue,),
                                  onPressed: (){},
                                ),
                                hintStyle: TextStyle(color: Colors.grey[700])
                            ),
                          ),
                        ),


                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: uidInput2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(

                              border: InputBorder.none,
                              hintText: "Phone",
                              hintStyle: TextStyle(color: Colors.grey[700]),

                              prefixIcon: IconButton(
                                icon: Icon(Icons.phone,color: Colors.blue,),
                                onPressed: (){},
                              ),

                              labelStyle: const TextStyle(color: Colors.black), // Customize label color
                              //floatingLabelBehavior: FloatingLabelBehavior.always, // Always show the label above the TextField
                            ),
                            onChanged: (text) async{

                              //viewData(text,selectedCountry.toLowerCase());

                              //print(this._data[index]["total_var"]);
                              // print("Text changed to: $text");
                            },
                          ),
                        ),

                      ],
                    ),
                  )),
                  SizedBox(height: 10,),
                  Visibility(
                    visible: true,
                    child: FadeInUp(duration: Duration(milliseconds: 1900), child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Container(
                        width: 200,
                        child: ElevatedButton(
              
                          style: ElevatedButton.styleFrom(
              
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor:Color.fromRGBO(143, 148, 251, 1),
                              foregroundColor: Colors.white
              
                          ),
              
                          child: const Text('Book Ticket'),
                          onPressed: () async{
                            //print(uidInput.text);
                            //print(await loginOnline());
                            await bookTicket();
                            // Get.to(() =>Aboutpage());
                          },
                        ),
                      ),
                    )),
                  ),
                ],),
              ),
            );
        },
      ),
    ).whenComplete(() {
      // Get.put(HideShowState()).isDelivery(0);
      //do whatever you want after closing the bottom sheet
    });

  }



  loginOnline() async{
    // print(await SyncService().SyncDownloadCard());
    //print(await SyncService().SyncUploadCard());
    //print(await CardQuery().SyncOffCardAdd());
    setState(() {
      showOveray=true;
    });
    try {

      var params =  {
        "PhoneNumber":"${uidInput2.text}${uidInput.text}",
        "password":uidInput3.text,
        //"options": [1,2,3],
      };


      var url="${ConstantClassUtil.urlLink}/AdminLoginPhone";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          // HttpHeaders.authorizationHeader:""
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        //print(params);
        // print("done");
        //return response.data;
        //return response.data["User"]["name"];
        if((await AdminQuery().addData(Admin(uid:response.data["User"]["uid"],name:response.data["User"]["name"],subscriber:response.data["User"]["subscriber"],AuthToken: response.data["token"],email: response.data["User"]["email"],phone: response.data["User"]["tel"])))>0)
        {
          //Get.to(Homepage());
          //Get.to(() => Homepage());
          Get.put(HideShowState()).isCameraVisible(true);
          await adminStatedata.auth();


          Get.toNamed('/home');
          //Get.toNamed('/sale');

        }
        else{
          // print((await AdminQuery().addData(Admin(uid:uidInput.text,subscriber: uidInput2.text)))),
        }


      } else {
        //return false;
        setState(() {
          showOveray=false;
        });

        Get.toNamed('/ErrorPage');
      }
    } catch (e) {
      //return false;
      setState(() {
        showOveray=false;
      });

      Get.toNamed('/ErrorPage');
    }


  }

  void topupfunc() {
    Get.bottomSheet(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 200,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView(
                        children: [
                          const SizedBox(height: 10.0,),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget> [

                                  const TextField(

                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Balance',
                                      hintText: 'Enter Balance',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  const SizedBox(height: 10.0,),
                                  const TextField(

                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Description',
                                      hintText: 'Enter Description',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  const SizedBox(height: 10.0,),
                                  Center(
                                    child: FloatingActionButton.extended(
                                      label: const Text('Add Balance'), // <-- Text
                                      backgroundColor: Colors.black,
                                      icon: const Icon( // <-- Icon
                                        Icons.thumb_up,
                                        size: 24.0,
                                      ),
                                      onPressed: ()async =>{


                                      },




                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Positioned(

              child: Container(
                padding: const EdgeInsets.all(16),
                child: const CircularProgressIndicator(),
              ),
            ),
          ],
        )
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });
  }
  void showon(){
    Get.bottomSheet(
      Stack(
        children: [
          // your BottomSheet content goes here
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text('BottomSheet Content'),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );

  }
}



class StepperDot extends StatelessWidget {
  final bool isActive;
  const StepperDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class DottedLine extends StatelessWidget {
  final double height;
  const DottedLine({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: height,
      child: Column(
        children: List.generate(
          (height / 4).round(),
              (index) => Expanded(
            child: Container(
              width: 2,
              color: index % 2 == 0 ? Colors.grey : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}



