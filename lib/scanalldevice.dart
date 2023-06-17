

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class scanalldevice extends StatefulWidget {
  const scanalldevice({super.key});

  @override
  State<scanalldevice> createState() => _scanalldeviceState();
}

class _scanalldeviceState extends State<scanalldevice> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<ScanResult> scanResults = [];
  @override
  void initState() {
    super.initState();

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


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("Bluetooth List")
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async{
                      setState(() async {
                        bool bluetoothenable = await isBluetoothEnabled();
                        if(bluetoothenable) {
                          requestBluetoothPermissions();
                          ListView.builder(itemCount: scanResults.length,itemBuilder: (context,index)
                          {
                            ScanResult result = scanResults[index];
                            return ListTile(
                              title: Text(result.device.name ?? 'Unknown Device'),
                              subtitle: Text(result.device.id.toString()),
                              trailing: Text('${result.rssi} dBm'),
                              onTap: (){
                                print(result.device.name);
                              },
                            );

                          });



                        }
                        else {
                          print("Blue is off");

                        }
                      });
                    },child: Text("Bluetooth On",style: TextStyle(color: Colors.white,fontSize: 15,),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
Future<bool> isBluetoothEnabled() async{
  FlutterBluePlus flutterBluePlus= FlutterBluePlus.instance;
  return await flutterBluePlus.isOn;
}

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text('This is an example alert dialog.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}