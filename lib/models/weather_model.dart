class Weather{
  final String cityname;
  final double temperature;
  final String condition;

  Weather({
    required this.cityname,
    required this.temperature,
    required this.condition
  });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
        cityname: json['name'],
        temperature: json['main']['temp'],
        condition: json['weather'][0]['main']
    );
  }

}