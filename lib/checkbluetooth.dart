


import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:customsnackbar/customsnackbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class checkbluetooth extends StatefulWidget {
  const checkbluetooth({super.key});

  @override
  State<checkbluetooth> createState() => _checkbluetoothState();
}

class _checkbluetoothState extends State<checkbluetooth> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bluetooth Check"),

        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                  transformAlignment: Alignment.center,
                  margin: EdgeInsets.only(top: 200),

                  child: SizedBox(
                    width: 250,
                      height: 50,
                      child: ElevatedButton(onPressed: () async{
                        FlutterBluePlus flue= FlutterBluePlus.instance;
                        bool isonornot =await flue.isOn as bool;
                        if(isonornot) {
                          Fluttertoast.showToast(
                            msg: "Bluetooth is on . This is bluetooth list",
                            toastLength: Toast.LENGTH_SHORT, // Duration for wha st should be visible
                            gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
                            backgroundColor: Colors.black54, // Background color of the toast
                            textColor: Colors.white, // Text color of the toast
                            fontSize: 16.0, // Font size of the toast message
                          );
                          print("On");

                        }
                        else
                          {
                            Fluttertoast.showToast(
                              msg: "Bluetooth is currently off. Please turn on bluetooth for see the list.",
                              toastLength: Toast.LENGTH_SHORT, // Duration for wha st should be visible
                              gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
                              backgroundColor: Colors.black54, // Background color of the toast
                              textColor: Colors.white, // Text color of the toast
                              fontSize: 16.0, // Font size of the toast message
                            );
                            print("Off");

                          }






                      }, child: Text("Bluetooth on",style: TextStyle(color: Colors.white),)))),
              Container(
                  alignment: Alignment.center,
                  transformAlignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20),

                  child: SizedBox(
                      height: 50,
                      width: 250,
                      child: ElevatedButton(onPressed: () async{
                        FlutterBluePlus flue= FlutterBluePlus.instance;
                        bool isonornot =await flue.isOn as bool;
                        if(isonornot) {
                          Fluttertoast.showToast(
                            msg: "Bluetooth is on . This is bluetooth list",
                            toastLength: Toast.LENGTH_SHORT, // Duration for wha st should be visible
                            gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
                            backgroundColor: Colors.black54, // Background color of the toast
                            textColor: Colors.white, // Text color of the toast
                            fontSize: 16.0, // Font size of the toast message
                          );
                          print("On");

                        }
                        else
                        {
                           await
                          Fluttertoast.showToast(
                            msg: "Bluetooth is currently off. Please turn on bluetooth for see the list.",
                            toastLength: Toast.LENGTH_SHORT, // Duration for wha st should be visible
                            gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
                            backgroundColor: Colors.black54, // Background color of the toast
                            textColor: Colors.white, // Text color of the toast
                            fontSize: 16.0, // Font size of the toast message
                          );
                          print("Off");

                        }





                      }, child: Text("Bluetooth OFF"))))

            ],
          ),
        ),
      ),
    );
  }
}
FlutterBluePlus flutterBluePlus=FlutterBluePlus.instance;
void chec_bluison() async{
  bool isavailable = await flutterBluePlus.isOn;
  if(isavailable) {
    print("Bluetooth is On");
  }
  else
    {

      print("Bluetooth is off");


    }
}

void showAlertDialouge(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Bluetooth is off."),
          content:
              Text("Bluetooth is off. Please on bluetooth for scan devices."),
          actions: [InkWell(onTap: () {}, child: Text("Cancel"))],
        );
      });
}
showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = ElevatedButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Simple Alert"),
    content: Text("This is an alert message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}