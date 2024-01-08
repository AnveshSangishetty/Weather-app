import 'dart:convert';
import 'package:weather_apii/models/weather_model.dart';
import 'package:http/http.dart' as http;
class WeatherService{

  static const baseURL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apikey;
  WeatherService(this.apikey);

  Future<Weather> getWeather(String cityname) async{
    final response = await http.get(Uri.parse('$baseURL?q=$cityname&appid=$apikey&units=metric'));
    if(response.statusCode==200){
      return Weather.fromJson(jsonDecode(response.body));
    }
    else{
      return Weather(cityname:cityname,temperature:0,condition:"");
    }
  }
}