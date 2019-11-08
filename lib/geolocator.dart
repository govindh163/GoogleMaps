import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class GeoListenPage extends StatefulWidget {
  @override
  _GeoListenPageState createState() => _GeoListenPageState();
}

class _GeoListenPageState extends State<GeoListenPage> {
  Geolocator geolocator = Geolocator();

  Position userLocation;
 Position lastLocation;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _getLocation().then((position) {
      userLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : Text("Location:" +
                userLocation.latitude.toString() +
                " " +
                userLocation.longitude.toString()),
            lastLocation == null
                ? CircularProgressIndicator()
                : Text("Location:" +
                lastLocation.latitude.toString() +
                " " +
                lastLocation.longitude.toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                    });
                  });
                },
                color: Colors.blue,
                child: Text(
                  "Get Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Futrure().then((value) {
                    setState(() {
                      lastLocation = value;
                    });
                  });
                },
                color: Colors.blue,
                child: Text(
                  "Get User Last Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
Futrure()async{
  Position lastLocation = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  return lastLocation;
}
  Future<Position> _getLocation() async {
    var currentLocation;

    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  Future<Position> _getStream() async {
    var stream;  try {
  stream = await geolocator
        .getPositionStream(LocationOptions(
        accuracy: LocationAccuracy.best, timeInterval: 1000))
        .listen((position) {
    });}catch(e)
    {
      stream=null;
    }
    return stream;
  }
}