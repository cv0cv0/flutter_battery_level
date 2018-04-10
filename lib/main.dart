import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new MaterialApp(
        title: 'BatteryLevel',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new HomePage(),
      );
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel('gr.me/battery');

  String _batteryLevel = 'Unknown battery level';

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text('BatteryLevel'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(_batteryLevel),
              new Container(
                margin: const EdgeInsets.only(top: 60.0),
                height: 42.0,
                child: new RaisedButton(
                  onPressed: _getBatteryLevel,
                  child: new Text(
                    'Get Battery Level',
                    style: new TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      );

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result%';
    } on PlatformException catch (e) {
      batteryLevel = 'Failed to get battery level: ${e.message}';
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
