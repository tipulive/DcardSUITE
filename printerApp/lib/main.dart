import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  // Initialize Bluetooth without enabling it explicitly
  void _initBluetooth() async {
    try {
      // Get bonded devices directly without checking if Bluetooth is enabled
      List<BluetoothDevice> devices = await printer.getBondedDevices();
      setState(() {
        _devices = devices;
      });
    } catch (e) {
      print('Error initializing Bluetooth: $e');
    }
  }

  // Connect to a Bluetooth printer
  void _connectToPrinter(BluetoothDevice device) async {
    if (_connected) {
      printer.disconnect();
      setState(() {
        _connected = false;
      });
    } else {
      try {
        await printer.connect(device);
        setState(() {
          _connected = true;
        });
      } catch (e) {
        print('Error connecting to printer: $e');
        setState(() {
          _connected = false;
        });
      }
    }
  }

  // Print a sample receipt
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Dropdown for available Bluetooth devices
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<BluetoothDevice>(
              hint: Text('Select Bluetooth Printer'),
              value: _selectedDevice,
              items: _devices.map((device) {
                return DropdownMenuItem<BluetoothDevice>(
                  value: device,
                  child: Text(device.name!),
                );
              }).toList(),
              onChanged: (device) {
                setState(() {
                  _selectedDevice = device;
                });
              },
            ),
          ),
          // Connect button
          ElevatedButton(
            onPressed: _selectedDevice != null
                ? () => _connectToPrinter(_selectedDevice!)
                : null,
            child: Text(_connected ? 'Disconnect' : 'Connect'),
          ),
          // Print button
          ElevatedButton(
            onPressed: _printSample,
            child: Text('Print Sample Receipt'),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
