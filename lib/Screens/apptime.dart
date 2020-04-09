import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_usage/app_usage.dart';

class AppTime extends StatefulWidget {
  @override
  _AppTimeState createState() => _AppTimeState();
}

class _AppTimeState extends State<AppTime> {
  AppUsage appUsage = new AppUsage();
  String apps = 'Unknown';


  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
  }

  void getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);
      Map<String, double> usage = await appUsage.fetchUsage(startDate, endDate);
      usage.removeWhere((key,val) => val == 0);
      setState(() => apps = makeString(usage));
    }
    on AppUsageException catch (exception) {
      print(exception);
    }
  }

  String makeString(Map<String, double> usage) {
    String result = '';
    usage.forEach((k,v) {
      String appName = k.split('.').last;
      String timeInMins = (v / 60).toStringAsFixed(2);
      result += '$appName : $timeInMins minutes\n';
    });
    return result;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Example'),
        ),
        body: SingleChildScrollView(
          child: Text(
            apps,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20.0, // insert your font size here
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: getUsageStats,
            child: Icon(Icons.cached)
        ),
      ),
    );
  }
}