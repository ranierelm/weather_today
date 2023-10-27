import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_today/app/modules/models/weather_data.dart';

class WeatherAPI {
  Future<WeatherData> fetchWeatherInformation() async {
    var url = Uri.parse(
        'https://parseapi.back4app.com/parse/functions/informacoes_do_tempo');

    var response = await http.post(url, headers: {
      'X-Parse-Application-Id': 'nAX5VLA1WnL3qkzuYnlh4tzUqS9NJuKGL13L4vas',
      'X-Parse-REST-API-Key': '3Q8wzFGU6isxalfOyagYkz2bu0lCTcrtgJ7Q4iD7',
      'X-Parse-Revocable-Session': '1',
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final weatherData = WeatherData.fromJson(jsonResponse);
      return weatherData;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
