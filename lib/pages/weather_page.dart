import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_apii/pages/About.dart';
import 'package:weather_apii/services/weather_service.dart';
import 'package:weather_apii/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  final List<String> city_details;
  const WeatherPage(this.city_details, {super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  
  final _weatherService = WeatherService("b4f74d20a242497507c79dc88e035450");
  Weather? _weather;

  // Function which fetches the weather report
  _fetchWeather() async{
    try{
      final Weather weather;
      // We consider zip code, if zip code exists, else we consider city name
      print("details are ${widget.city_details}");
      if(widget.city_details.length==1) {
        weather = await _weatherService.getWeather(widget.city_details[0]);
      } else {
        weather = await _weatherService.getWeather(widget.city_details[1]);
      }
      print("weather is ${weather.temperature}");
      // Update the UI
      setState(() {
        _weather=weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  // function to get path to asset (based on weather condition)
  String getWeatherCondition(String? condition){
    if(condition==null) return 'assets/sunny.json';
    if(condition.toLowerCase()=='clouds') return 'assets/partly_cloudy.json';
    if(condition.toLowerCase()=='mist') return 'assets/mist.json';
    if(condition.toLowerCase()=='snow') return 'assets/snow.json';
    if(condition.toLowerCase()=='thunderstorm') return 'assets/storm.json';
    if(condition.toLowerCase()=='storm') return 'assets/storm.json';
    if(condition.toLowerCase()=='sunny') return 'assets/sunny.json';
    if(condition.toLowerCase()=='windy') return 'assets/windy.json';
    if(condition.toLowerCase()=='haze') return 'assets/haze.json';
    if(condition.toLowerCase()=='rain') return 'assets/rain.json';
    if(condition.toLowerCase()=='smoke') return 'assets/mist.json';
    if(condition.toLowerCase()=='fog') return 'assets/mist.json';
    if(condition.toLowerCase()=='drizzle') return 'assets/drizzle.json';
    return 'assets/sunny.json';
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Condition=="" represents fetch failed
      body: _weather==null?const Center(child: CircularProgressIndicator()):
        _weather?.condition==""?
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Could not fetch weather details for the given city/zip code"),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text("Back to home"))
                ],
              ),
            )
            :Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityname??"Loading city..",
              style: GoogleFonts.quicksand(fontSize: 30,fontWeight: FontWeight.w500),
            ),
            Lottie.asset(getWeatherCondition(_weather?.condition)),
            Text(
              '${_weather?.temperature??0}°C',
              style: GoogleFonts.quicksand(fontSize: 30,fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10,),
            Text(
                'Condition: ${_weather?.condition}',
              style: GoogleFonts.quicksand(fontSize: 30,fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(
                builder: (context) => About(),
              ),);
            }, child: const Text("About")),
            // Pop the page and navigate back to home page
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Back to home"))
          ],
        ),
      ),
    );
  }
}

