import 'package:flutter/material.dart';
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
    //     '/crop': (context) => CropImage(),
    }
    );
  }
}
