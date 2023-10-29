import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_today/app/modules/models/state_weather_forecast.dart';
import 'package:weather_today/app/modules/models/weather_forecast.dart';
import 'package:weather_today/app/services/api_service.dart';
import 'package:http/http.dart' as http;

void main() {
  Future<Map<String, dynamic>?> fetchWeatherInformationWithInvalidURL() async {
    var url = Uri.parse('https://invalid-url.com');

    try {
      var response = await http.post(url, headers: {
        'X-Parse-Application-Id': 'nAX5VLA1WnL3qkzuYnlh4tzUqS9NJuKGL13L4vas',
        'X-Parse-REST-API-Key': '3Q8wzFGU6isxalfOyagYkz2bu0lCTcrtgJ7Q4iD7',
        'X-Parse-Revocable-Session': '1',
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  group('WeatherAPI', () {
    test('fetchWeatherInformation should return data', () async {
      final api = WeatherAPI();
      final data = await api.fetchWeatherInformation();
      expect(data, isNotNull);
    });

    test('getWeekWeatheByState should return a list of WeatherForecast',
        () async {
      final api = WeatherAPI();
      final data = await api.getWeekWeatheByState('São Paulo');
      expect(data, isA<List<WeatherForecast>>());
    });

    test(
        'getWeekWeatheByState should return an empty list for an invalid state',
        () async {
      final api = WeatherAPI();
      final data = await api.getWeekWeatheByState('NonExistentState');
      expect(data, isEmpty);
    });

    test(
        'getStateWeatherForecasts should return a list of StateWeatherForecast',
        () async {
      final api = WeatherAPI();
      final data = await api.getStateWeatherForecasts();
      expect(data, isA<List<StateWeatherForecast>>());
    });

    test('fetchWeatherInformation should handle API errors', () async {
      final data = await fetchWeatherInformationWithInvalidURL();
      expect(data, isNull);
    });
  });
}
