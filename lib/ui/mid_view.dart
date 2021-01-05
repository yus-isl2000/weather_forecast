import 'package:flutter/material.dart';
import 'package:weather_forecast_app/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/util/forecast_util.dart';

Widget midView(AsyncSnapshot<WeatherForecastModel> snapshot) {
  var forecastList = snapshot.data.list;
  var cityName = snapshot.data.city.name;
  var countyName = snapshot.data.city.country;
  var formattedDate =
      new DateTime.fromMicrosecondsSinceEpoch(forecastList[0].dt * 1000000);
  return Container(
    child: Column(
      children: [
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
        SizedBox(
          height: 30,
        ),
        Icon(
          Icons.wb_sunny,
          size: 200,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //text
            //from forecastList[0] print the temperature during the day
            Text(
              '${forecastList[0].temp.day}°C',
              style: TextStyle(fontSize: 34),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${forecastList[0].weather[0].description}'),
            )
            //text
            //from forecastList[0] print description of weather[0]
          ],
        )
      ],
    ),
  );
}
