import 'package:flutter/material.dart';
import 'package:summer_iti_http/data/remote/api_services.dart';
import 'package:summer_iti_http/model/weather_eror.dart';

import 'model/weather.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Weather? _weather;
  String? _message;

  @override
  Widget build(BuildContext context) {
    getWeather('New%20Yorkkk');
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
      ),
      body: Center(
        child: _weather != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${_weather!.location!.name}'),
                  Text('${_weather!.current!.temperature}'),
                  Image.network('${_weather!.current!.weather_icons![0]}'),
                  Text('${_weather!.current!.weather_descriptions![0]}'),
                ],
              )
            : Text('$_message'),
      ),
    );
  }

  void getWeather(String cityName) {
    try {
      ApiServices().getWeather(cityName).then((value) {
        setState(() {
          if (value is Weather) _weather = value;
          if (value is WeatherError)
            _message = value.error!.info;
        });
      });
    } catch (e) {
      setState(() {
        _message = e.toString();
      });
    }
  }
}
