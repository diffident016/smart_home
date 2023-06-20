class Temp {
  final double temperature;
  final int humidity;

  Temp({this.temperature = 0.0, this.humidity = 0});

  static Temp fromJson(Map json) =>
      Temp(temperature: json['temp'], humidity: json['hum']);
}
