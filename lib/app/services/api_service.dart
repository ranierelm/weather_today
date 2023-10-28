import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_today/app/modules/models/weather_forecast.dart';

class WeatherAPI {
  Future<Map<String, dynamic>> fetchWeatherInformation() async {
    var url = Uri.parse(
        'https://parseapi.back4app.com/parse/functions/informacoes_do_tempo');

    var response = await http.post(url, headers: {
      'X-Parse-Application-Id': 'nAX5VLA1WnL3qkzuYnlh4tzUqS9NJuKGL13L4vas',
      'X-Parse-REST-API-Key': '3Q8wzFGU6isxalfOyagYkz2bu0lCTcrtgJ7Q4iD7',
      'X-Parse-Revocable-Session': '1',
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<List<WeatherForecast>> getWeekWeatheByState(
      String estadoDesejado) async {
    dynamic json = await fetchWeatherInformation();
    final estados = json['result']['estados'];
    List<WeatherForecast> previsoes = [];

    for (var estado in estados) {
      String nomeEstado = estado['estado'];
      if (nomeEstado == estadoDesejado) {
        var dias = estado['dias'][0];

        for (var dia in dias.keys) {
          var previsao = dias[dia][0];
          previsoes.add(WeatherForecast(
            dia: dia,
            manha: previsao['manha'][0],
            tarde: previsao['tarde'][0],
            noite: previsao['noite'][0],
          ));
        }
      }
    }

    return previsoes;
  }
}
