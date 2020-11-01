import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Current Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
                child: Image(
              image: AssetImage("images/map.png"),
              height: 200,
              width: 200,
            )),
            SizedBox(
              height: 50.0,
            ),
            if (_currentPosition != null)
              new Text(
                'LAT: ${_currentPosition.latitude} ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            SizedBox(height: 10),
            if (_currentPosition != null)
              new Text(
                'LNG: ${_currentPosition.longitude}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            if (_currentPosition == null)
              new Text(
                'Lets find your location',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text("Copy to clipboard"),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(
                        text:
                            "${_currentPosition.latitude} ${_currentPosition.longitude} "));
                  },
                ),
                Icon(Icons.content_copy),
              ],
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.only(left: 20.0,right: 20.0),
              child: FlatButton(
                child: Text(
                  "Get location",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _getCurrentLocation();
                },
                splashColor: Colors.blueAccent[200],
                color: Colors.blueAccent,
              ),
            )
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
