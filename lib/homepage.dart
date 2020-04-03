import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:geolocator/geolocator.dart';

//import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:permission/permission.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  final Set<Polyline> polyline = {};
  ScrollController _scrollController = new ScrollController();
  List<LatLng> routeCoords;

//  GoogleMapPolyline googleMapPolyline =
//  new GoogleMapPolyline(apiKey: "");
  bool mapToggle = false;
  var currentLocation;
  var changeloca;
  var location = new Location();
  Map<String, double> userLocation;
  GoogleMapController mapController;
  List<Marker> allMarkers = [];

  @override
  void initState() {
    // getsomePoints();
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
    location.onLocationChanged().listen((LocationData currlo) {
      setState(() {
        changeloca = currlo;
      });
      print(changeloca.latitude);
      print(changeloca.longitude);
    });
    allMarkers.add(
      Marker(
          markerId: MarkerId("BookStore"),
          draggable: true,
          infoWindow: InfoWindow(title: 'book store'),
          onTap: () {
            _showModal();
          },
          position: LatLng(12.9171, 80.1923)),
    );
    allMarkers.add(
      Marker(
          markerId: MarkerId("BookStore"),
          draggable: true,
          infoWindow: InfoWindow(title: 'book store2'),
          onTap: () {
            _showModal();
          },
          position: LatLng(12.9010, 80.2279)),
    );
    allMarkers.add(
      Marker(
          markerId: MarkerId("BookStore"),
          draggable: true,
          infoWindow: InfoWindow(title: 'My home'),
          onTap: () {
            _showModal();
          },
          position: LatLng(10.930572, 79.272582)),
    );


  }

//  getsomePoints() async {
//    var permissions =
//    await Permission.getPermissionsStatus([PermissionName.Location]);
//    if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
//      var askpermissions =
//      await Permission.requestPermissions([PermissionName.Location]);
//    } else {
//      routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
//          origin: LatLng(13.0827, 80.2707),
//          destination: LatLng(10.930572, 79.272582),
//          mode: RouteMode.driving);
//    }
//  }
//
//  getaddressPoints() async {
//    routeCoords = await googleMapPolyline.getPolylineCoordinatesWithAddress(
//        origin: '55 Kingston Ave, Brooklyn, NY 11213, USA',
//        destination: '178 Broadway, Brooklyn, NY 11211, USA',
//        mode: RouteMode.driving);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: BoomMenu(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          //child: Icon(Icons.add),
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
        //  scrollVisible: sc,
          overlayColor: Colors.black,
          overlayOpacity: 0.7,
          children: [
            MenuItem(
              child: Icon(Icons.accessibility, color: Colors.black),
              title: "Profiles",
              titleColor: Colors.white,
              subtitle: "You Can View the Noel Profile",
              subTitleColor: Colors.white,
              backgroundColor: Colors.deepOrange,
              onTap: () => print('FIRST CHILD'),
            ),
            MenuItem(
              child: Icon(Icons.brush, color: Colors.black),
              title: "Profiles",
              titleColor: Colors.white,
              subtitle: "You Can View the Noel Profile",
              subTitleColor: Colors.white,
              backgroundColor: Colors.green,
              onTap: () => print('SECOND CHILD'),
            ),
            MenuItem(
              child: Icon(Icons.keyboard_voice, color: Colors.black),
              title: "Profile",
              titleColor: Colors.white,
              subtitle: "You Can View the Noel Profile",
              subTitleColor: Colors.white,
              backgroundColor: Colors.blue,
              onTap: () => print('THIRD CHILD'),
            ),
            MenuItem(
              child: Icon(Icons.ac_unit, color: Colors.black),
              title: "Profiles",
              titleColor: Colors.white,
              subtitle: "You Can View the Noel Profile",
              subTitleColor: Colors.white,
              backgroundColor: Colors.blue,
              onTap: () => print('FOURTH CHILD'),
            )
          ],
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  child: Row(
                    children: <Widget>[
                      Image.network(
                          'https://images.pexels.com/photos/2150/sky-space-dark-galaxy.jpg?cs=srgb&dl=astronomy-black-wallpaper-constellation-2150.jpg&fm=jpg'),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          leading: Icon(
                            Icons.info,
                            size: 20,
                            color: Colors.green,
                          ),
                          title: Text('Device info'),
                          onTap: () => Navigator.pushNamed(context, "/info")),
                      ListTile(
                          leading: Icon(
                            Icons.info,
                            size: 20,
                            color: Colors.green,
                          ),
                          title: Text('Google Sheet'),
                          onTap: () => Navigator.pushNamed(context, "/sheet")),
                      ListTile(
                          leading: Icon(
                            Icons.fingerprint,
                            size: 20,
                            color: Colors.green,
                          ),
                          title: Text('Device info'),
                          onTap: () => Navigator.pushNamed(context, "/info")),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
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
                      //    polylines: polyline,
                          compassEnabled: true,
                          onMapCreated: onMapCreated,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(currentLocation.latitude,
                                  currentLocation.longitude),
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
                  child: FloatingActionButton(
                      child: Icon(Icons.layers),
                      elevation: 5,
                      backgroundColor: Colors.teal[200],
                      onPressed: () {
                        _changeMapType();
                        print('Changing the Map Type');
                      }),
                ),
                Positioned(
                  top: 670,
                  right: 150,
                  child: InkWell(
                    onTap: movetoChennai,
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.green),
                      child: Icon(Icons.forward, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 670,
                  right: 50,
                  child: InkWell(
                    onTap: movetoMadurai,
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red),
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
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  MapType _defaultMapType = MapType.normal;

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
//      polyline.add(Polyline(
//          polylineId: PolylineId('route1'),
//          visible: true,
//          points: routeCoords,
//          width: 4,
//          color: Colors.blue,
//          startCap: Cap.roundCap,
//          endCap: Cap.buttCap));
    });
  }

  movetoChennai() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(13.0827, 80.2707),
          zoom: 14.0,
          bearing: 45.0,
          tilt: 45.0),
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

  void _closeModal(void value) {}
}
