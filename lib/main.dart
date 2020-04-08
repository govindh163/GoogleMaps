import 'package:flutter/material.dart';
import 'package:googlemaps/Overlaysheet.dart';
import 'package:googlemaps/Screens/Sheets.dart';
import 'package:googlemaps/Screens/draw.dart';
import 'package:googlemaps/buttons.dart';
import 'Screens/Appsetting.dart';
import 'geolocator.dart';
import 'homepage.dart';
import 'location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    routes:<String, WidgetBuilder>{
      '/home': (context) => MyHomePage(),
      '/info': (context) => MyDeviceInfo(),
      '/sheet': (context) => GoogleSheets(),
      '/draw': (context) => DrawCircle(),
      '/button': (context) => ButtonPage(),
      '/overlay': (context) => TopSnapSheet(),
    //     '/crop': (context) => CropImage(),
    }
    );
  }
}
