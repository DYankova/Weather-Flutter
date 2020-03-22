import 'package:flutter/material.dart';
import 'Weather.dart';
import 'package:my_weather_app/model/WeatherData.dart';
import 'package:my_weather_app/api/MapApi.dart';
import 'package:my_weather_app/api/LocationApi.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  WeatherData weatherData;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {

    return  new Scaffold(
      backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: weatherData != null ? Weather(weatherData: weatherData) :
            Center(
              child: CircularProgressIndicator(
                strokeWidth:  4.0,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
    );
  }

  getCurrentLocation() async {
    LocationApi locationApi = LocationApi.getInstance();
    final location = await locationApi.getLocation();
    loadWeather(lat: location.lat, lon: location.lon);
  }

//to be realtime
  loadWeather({double lat, double lon}) async {
    MapApi mapApi = MapApi.getInstance();
    final data = await mapApi.getWeather(lat: lat,lon: lon);
    setState(() {
      this.weatherData = data;
    });
  }
}
