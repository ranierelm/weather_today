import 'package:weather_today/app/modules/models/weather_forecast.dart';

class StateWeatherForecast {
  final String estado;
  final List<WeatherForecast> previsoes;

  StateWeatherForecast({
    required this.estado,
    required this.previsoes,
  });
}
