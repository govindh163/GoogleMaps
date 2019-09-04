import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool mapToggle = false;
  var currentLocation;
  GoogleMapController mapController;
  List<Marker> allMarkers=[];

  @override
  void initState() {
    super.initState();
  //adding Markers to view the Bottomsheet
    
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
          title: Text('Map Demo for OptN Technologies'),
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
                        target: LatLng(currentLocation.latitude,currentLocation.longitude),//getting Current Location Of User
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
                        _changeMapType();//Satellite View And normal View Changing
                        print('Changing the Map Type');
                      }),),
                Positioned(
                  top:670,
                  right:150,
                  child: InkWell(
                    onTap: movetoChennai,// Moves User to chennai
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
                    onTap: movetoMadurai,//Moves USer to Madurai
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
  // Function to change Views
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
      CameraPosition(target: LatLng(9.9252, 78.1198), zoom: 12.0),
    ));
  }
  // bottom Sheet Popup Function
  void _showModal() {
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: Text("S.no= 1 "),//Statically Now but will have option to make it dynamic by Firebase
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
