import 'package:flutter/material.dart';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';

FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
// The desired Bluetooth device

class textprint extends StatefulWidget {
  const textprint({super.key});

  @override
  State<textprint> createState() => _textprintState();
}

class _textprintState extends State<textprint> {
  //

  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<ScanResult> scanResults = [];


  @override
  void initState() {
    super.initState();
    requestBluetoothPermissions();
  }

  // Check and request Bluetooth permissions
  void requestBluetoothPermissions() async {
    PermissionStatus status = await Permission.bluetooth.status;
    if (!status.isGranted) {
      status = await Permission.bluetooth.request();
    }

    if (status.isGranted) {
      // Bluetooth permissions granted, proceed with scanning
      startScan();
    } else {
      // Bluetooth permissions denied, handle accordingly
      // Display an error message or request permissions again
    }
  }
  void startScan() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen for scan results
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      setState(() {
        scanResults = results;
      });
    });

    // Stop scanning after a certain duration
    Future.delayed(Duration(seconds: 4), () {
      flutterBlue.stopScan();
    });
  }

//test




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bluetooth with list"),
        ),
        body: ListView.builder(itemCount: scanResults.length,itemBuilder: (context,index)
        {
          ScanResult result = scanResults[index];
          return ListTile(
            title: Text(result.device.name ?? 'Unknown Device'),
            subtitle: Text(result.device.id.toString()),
            trailing: Text('${result.rssi} dBm'),

            onTap: () async {
              // Connect to the device

              await result.device.connect(timeout: Duration(seconds: 10000));
              await result.device.pair();
              bool isconnected = await flutterBlue.isOn;
              if(isconnected)
              {
                print("Connected"+result.device.id.toString());








              }
              else {
                print("NOT");
              }

// Disconnect from device
              //device.disconnect();
              print(result.device.name);
            },
          );

        }),

      ),
    );
  }
}



void testReceipt(NetworkPrinter printer) {
  printer.text(
      'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
      styles: PosStyles(codeTable: 'CP1252'));
  printer.text('Special 2: blåbærgrød',
      styles: PosStyles(codeTable: 'CP1252'));

  printer.text('Bold text', styles: PosStyles(bold: true));
  printer.text('Reverse text', styles: PosStyles(reverse: true));
  printer.text('Underlined text',
      styles: PosStyles(underline: true), linesAfter: 1);
  printer.text('Align left', styles: PosStyles(align: PosAlign.left));
  printer.text('Align center', styles: PosStyles(align: PosAlign.center));
  printer.text('Align right',
      styles: PosStyles(align: PosAlign.right), linesAfter: 1);

  printer.text('Text size 200%',
      styles: PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ));

  printer.feed(2);
  printer.cut();
}
//AB:0B:50:47:F4:FB