import 'package:flutter/material.dart';
import 'package:android_device_info/android_device_info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';


class RowItem extends StatelessWidget {
  final text;
  final value;

  RowItem(this.text, this.value);
//  Row for device info
  Widget customRow(){
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Text(text,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black87)),
        ),
        Spacer(flex: 4),
        Expanded(
            flex: 5,
            child: Text(value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                )))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Padding(padding: EdgeInsets.fromLTRB(25.0, 5.0, 15.0, 0.0),
          child: customRow(),
        )
    );
  }
}
const memoryUnit = 'MB';

class MyDeviceInfo extends StatefulWidget {
  @override
  _MyDeviceInfoState createState() => _MyDeviceInfoState();
}

class _MyDeviceInfoState extends State<MyDeviceInfo> {
  var data = {};
  var baterrydata = {};
  var phonedata = {};

  getData() async {
    var data = {};

    final memory = await AndroidDeviceInfo().getMemoryInfo(unit: memoryUnit);
    final display = await AndroidDeviceInfo().getDisplayInfo();
    final fp = await AndroidDeviceInfo().getFingeprintInfo();

    data.addAll(memory);
    data.addAll(display);
    data.addAll(fp);

    if (mounted) {
      setState(() {
        this.data = data;
      });
    }
    var permission =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
    if (permission == PermissionStatus.denied) {
      var permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.phone]);
      if (permissions[PermissionGroup.phone] == PermissionStatus.granted) {
        data = await AndroidDeviceInfo().getSystemInfo();
        data.addAll(data);
        if (mounted) {
          setState(() {
            this.data = data;
          });
        }
      }
    }
  }
getInfo(){
  AndroidDeviceInfo().getSystemInfo().then((data) {
    if (mounted) {
      setState(() {
        this.phonedata = data;
      });
    }
  });
}
  @override
  void initState() {
    super.initState();

    AndroidDeviceInfo().getBatteryInfo().then((data) {
      if (mounted) {
        setState(() {
          this.baterrydata = data;
        });
      }
    });
    getInfo();
    getData();
  }
//  App bar
  Widget appBar(){
    return AppBar(
      title: Text("Device Info",style: TextStyle(fontSize: 16.0),),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(child: SpinKitFadingFour(
        color: Colors.white,
        size: 50.0,
      ),);
    }

    final totalRam = data['totalRAM'].round();
    final totalExternalMemorySize = data['totalExternalMemorySize'].round();
    final totalInternalMemorySize = data['totalInternalMemorySize'].round();
    final availableExternalMemorySize =
    data['availableExternalMemorySize'].round();
    final availableInternalMemorySize =
    data['availableInternalMemorySize'].round();

    return Scaffold(
      appBar: appBar(),
      body: ListView(
        children: <Widget>[
          RowItem('Display Resolution', data['resolution']),
          Divider(),
          RowItem('Density', data['density']),
          Divider(),
          RowItem(
            'RefreshRate',
            data['refreshRate'].toStringAsFixed(2) + ' Hz',
          ),
          Divider(),
          RowItem(
            'Physical Size',
            data['physicalSize'].toStringAsFixed(2) + ' in',
          ),
          Divider(),
          RowItem('Total RAM', '$totalRam $memoryUnit'),
          RowItem(
            'Total Internal Memory',
            '$totalInternalMemorySize $memoryUnit',
          ),
          Divider(),
          RowItem(
            'Available Internal Memory',
            '$availableInternalMemorySize $memoryUnit',
          ),
          Divider(),
          RowItem(
            'Total External Storage',
            '$totalExternalMemorySize $memoryUnit',
          ),
          Divider(),
          RowItem('Available External Storage',
              '$availableExternalMemorySize $memoryUnit'),
          Divider(),
          RowItem(
              'Fingerprint Sensor', '${data['isFingerprintSensorPresent']}'),
          Divider(),
          RowItem('Fingerprints Enrolled', '${data['areFingerprintsEnrolled']}'),
          Divider(),
          Text(" Battery Info",style: TextStyle(fontWeight: FontWeight.bold,fontSize:25,color: Colors.red),),
          SizedBox(height: 7,),
          RowItem('Charge Level', '${baterrydata['batteryPercentage']}%'),
          Divider(),
          RowItem('Health', baterrydata['batteryHealth']),
          Divider(),
          RowItem('is Charging', '${baterrydata['isDeviceCharging']}'),
          Divider(),
          RowItem('Source', '${baterrydata['chargingSource']}'),
          Divider(),
          RowItem('Technology', baterrydata['batteryTechnology']),
          Divider(),
          RowItem('Temperature', '${baterrydata['batteryTemperature']}°c'),
          Divider(),
          RowItem('Voltage', '${baterrydata['batteryVoltage']}'),
          Divider(),
          Text(" Phone Info",style: TextStyle(fontWeight: FontWeight.bold,fontSize:25,color: Colors.red),),
          SizedBox(height: 7,),
          RowItem('Model', phonedata['model']),
          RowItem('Product', phonedata['product']),
          RowItem('Board', phonedata['board']),
          RowItem('Manufacturer', phonedata['manufacturer']),
          RowItem('Device', phonedata['device']),
          RowItem('Hardware', phonedata['hardware']),
          RowItem('Device Type', phonedata['deviceType']),
          RowItem('Phone Type', phonedata['phoneType']),
          RowItem('Phone Number', phonedata['phoneNo']),
          RowItem('Orientation', phonedata['orientation']),
          RowItem('Screen Display ID', phonedata['screenDisplayID']),
          Divider(),
          RowItem('Android Version', phonedata['osVersion']),
          RowItem('Codename', phonedata['osCodename']),
          RowItem('SDK Verson', phonedata['buildVersionSDK'].toString()),
          RowItem('Build Codename', phonedata['buildVersionCodename']),
          Divider(),
          RowItem('Radio Version', phonedata['radioVer']),
          RowItem('Bootloader', phonedata['bootloader']),
          RowItem('Fingerprint', phonedata['fingerprint']),
          RowItem('Is Rooted?', phonedata['isDeviceRooted'].toString()),
          Divider(),
          RowItem('Build Brand', phonedata['buildBrand']),
          RowItem('Build Host', phonedata['buildHost']),
          RowItem('Build Tags', phonedata['buildTags']),
          RowItem('Build Version Incremental', phonedata['buildVersionIncremental']),
          RowItem('Build User', phonedata['buildUser']),
          RowItem('Build Version Release', phonedata['buildVersionRelease']),
        ],
      ),
    );
  }
}