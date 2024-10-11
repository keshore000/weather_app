import 'dart:convert';
import 'package:http/http.dart' as http;

class weatherservice{
Future<Map<String,dynamic>> fetchWeather(double latitude,double longitude) async {
  final url = Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m&hourly=relative_humidity_2m&hourly=wind_speed_10m');
  print('API request URL: $url');
  final response = await http.get(url);
    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      return weatherData;
    } else {
      throw Exception('Failed to fetch weather data');
    }
}
}
