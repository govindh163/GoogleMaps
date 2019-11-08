import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool mapToggle = false;
  var currentLocation;
  var changeloca;
  var location = new Location();
  Map<String, double> userLocation;
  GoogleMapController mapController;
  List<Marker> allMarkers=[];

  @override
  void initState() {

    super.initState();
    location.onLocationChanged().listen((LocationData currlo) {
      setState(() {
        changeloca=currlo;
      });
      print(changeloca.latitude);
      print(changeloca.longitude);
    });
    allMarkers.add(Marker(markerId: MarkerId("BookStore"),
        draggable:true,
        infoWindow: InfoWindow(title: 'book store'),
        onTap: () {
          _showModal();
        },
        position: LatLng(12.9171, 80.1923)
    ),);
    allMarkers.add(Marker(markerId: MarkerId("BookStore"),
        draggable:true,
        infoWindow: InfoWindow(title: 'book store2'),
        onTap: () {
          _showModal();
        },
        position: LatLng(12.9010, 80.2279)
    ),);
    allMarkers.add(Marker(markerId: MarkerId("BookStore"),
        draggable:true,
        infoWindow: InfoWindow(title: 'My home'),
        onTap: () {
          _showModal();
        },
        position: LatLng(10.930572, 79.272582)
    ),);

    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('Map Demo '),
        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                 Container(
                  height: MediaQuery.of(context).size.height - 120,
                  width: double.infinity,
                  child: mapToggle
                      ? GoogleMap(
                    mapType: _defaultMapType,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    onMapCreated: onMapCreated,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation.latitude,currentLocation.longitude),
                        zoom: 30.0),
                    markers: Set.from(allMarkers),
                  )
                      : Center(
                      child: Text(
                        'Loading.. Please wait..',
                        style: TextStyle(fontSize: 20.0),
                      )),
                ),

                Positioned(
                  top: 90,
                  right: 5,
                  child:  FloatingActionButton(
                      child: Icon(Icons.layers),
                      elevation: 5,
                      backgroundColor: Colors.teal[200],
                      onPressed: () {
                        _changeMapType();
                        print('Changing the Map Type');
                      }),),
                Positioned(
                  top:670,
                  right:150,
                  child: InkWell(
                    onTap: movetoChennai,
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.green
                      ),
                      child: Icon(Icons.forward, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top:670,
                  right:50,
                  child: InkWell(
                    onTap: movetoMadurai,
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red
                      ),
                      child: Icon(Icons.backspace, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }
  MapType _defaultMapType = MapType.normal;

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
  movetoChennai() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(13.0827, 80.2707), zoom: 14.0, bearing: 45.0, tilt: 45.0),
    ));
  }

  movetoMadurai() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(10.930572, 79.272582), zoom: 12.0),
    ));
  }
  void _showModal() {
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: Text("S.no= 1 "),
              ),
              ListTile(
                title: Text("Name of book= \"The Theory of Karma\" "),
              ),
              ListTile(
                title: Text("Cost: ₹ 250 "),
              ),
            ],
          ),
        );
      },
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {

  }
}