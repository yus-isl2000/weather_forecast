import 'package:flutter/material.dart';
import 'package:weather_forecast_app/ui/mid_view.dart';
import 'model/weather_forecast_model.dart';
import 'network/network.dart';

class WeatherForcast extends StatefulWidget {
  @override
  _WeatherForcastState createState() => _WeatherForcastState();
}

class _WeatherForcastState extends State<WeatherForcast> {
  Future<WeatherForecastModel> forecastObject;
  String _cityName = "Toronto";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forecastObject = Network().getWeatherForecast(cityName: _cityName);

    forecastObject.then((value) => {
          print(value.city.name + ', ' + value.city.country),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          textFieldView(),
          mainComponents(),
        ],
      ),
    );
  }

  Container mainComponents() {
    return Container(
      child: FutureBuilder<WeatherForecastModel>(
        future: forecastObject,
        builder: (BuildContext context,
            AsyncSnapshot<WeatherForecastModel> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                midView(snapshot),
              ],
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  textFieldView() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Enter City Name',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onSubmitted: (value) {
            setState(() {
              _cityName = value;
              forecastObject = getWeather(cityName: _cityName);
            });
          },
        ),
      ),
    );
  }

  Future<WeatherForecastModel> getWeather({String cityName}) {
    print(cityName);
    return new Network().getWeatherForecast(cityName: cityName);
  }
}
