import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_forecast_app/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/util/convert_icon.dart';
import 'package:weather_forecast_app/util/forecast_util.dart';

Widget midView(AsyncSnapshot<WeatherForecastModel> snapshot) {
  var forecastList = snapshot.data.list;
  var cityName = snapshot.data.city.name;
  var countyName = snapshot.data.city.country;
  var formattedDate =
      new DateTime.fromMicrosecondsSinceEpoch(forecastList[0].dt * 1000000);

  var mainInfo = [
    Text(
      '$cityName, $countyName',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black87,
      ),
    ),
    Text(
      '${Util.getFormattedDate(formattedDate)}',
    ),
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: getWeatherIcon(
        weatherDescription: forecastList[0].weather[0].main,
        color: Colors.pinkAccent,
        size: 200.0,
      ),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //text
        //from forecastList[0] print the temperature during the day
        Text(
          '${forecastList[0].temp.day.toStringAsFixed(0)}°C',
          style: TextStyle(fontSize: 34),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${forecastList[0].weather[0].description}'),
        )
        //text
        //from forecastList[0] print description of weather[0]
      ],
    ),
    extraMainInfo(forecastList),
  ];

  return Container(
    child: Column(
      children: mainInfo,
    ),
  );
}

Widget extraMainInfo(List<Lista> forecastList) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      windInfo(forecastList),
      humidityInfo(forecastList),
      maxInfo(forecastList),
    ],
  );
}

Widget windInfo(List<Lista> forecastList) {
  return Column(
    children: [
      Text("${forecastList[0].speed.toStringAsFixed(1)}k/h"),
      Icon(
        FontAwesomeIcons.wind,
        size: 20,
        color: Colors.pinkAccent,
      )
    ],
  );
}

Widget humidityInfo(List<Lista> forecastList) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text("${forecastList[0].humidity.toStringAsFixed(0)}%"),
        Icon(
          FontAwesomeIcons.solidGrinBeamSweat,
          size: 20,
          color: Colors.pinkAccent,
        )
      ],
    ),
  );
}

Widget maxInfo(List<Lista> forecastList) {
  return Column(
    children: [
      Text("${forecastList[0].temp.max.toStringAsFixed(0)}°C"),
      Icon(
        FontAwesomeIcons.temperatureHigh,
        size: 20,
        color: Colors.pinkAccent,
      )
    ],
  );
}
