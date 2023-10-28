import 'package:flutter/material.dart';
import 'package:weather_today/app/modules/models/state_weather_forecast.dart';
import 'package:weather_today/app/services/api_service.dart';

class AppProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<StateWeatherForecast> _weekForecast = [];

  bool get isLoading => _isLoading;
  List<StateWeatherForecast> get weekForecast => _weekForecast;

  String? get error => _error;

  Future<void> fetchStateWeatherForecasts() async {
    _isLoading = true;
    try {
      _weekForecast = await WeatherAPI().getStateWeatherForecasts();
    } catch (error) {
      debugPrint(error.toString());
      _error =
          'Não foi possível buscar atualizações do tempo, tente novamente mais tarde';
    }

    _isLoading = false;

    notifyListeners();
  }
}
