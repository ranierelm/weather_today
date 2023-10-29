import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_today/app/modules/models/state_weather_forecast.dart';
import 'package:weather_today/app/modules/models/weather_forecast.dart';
import 'package:weather_today/app/services/api_service.dart';
import 'package:weather_today/app/shared/utils/formats.dart';

class AppProvider extends ChangeNotifier {
  String? _error;
  bool _isLoading = false;
  List<StateWeatherForecast> _stateWeekForecast = [];
  List<WeatherForecast> _weekForecast = [];
  WeatherForecast? _selectedForecastDay;

  String? get error => _error;
  bool get isLoading => _isLoading;
  List<StateWeatherForecast> get stateWeekForecast => _stateWeekForecast;
  List<WeatherForecast> get weekForecast => _weekForecast;
  WeatherForecast? get selectedForecastDay => _selectedForecastDay;

  Future<void> fetchStateWeatherForecasts() async {
    _isLoading = true;
    try {
      _stateWeekForecast = await WeatherAPI().getStateWeatherForecasts();
    } catch (error) {
      debugPrint(error.toString());
      _error =
          'Não foi possível buscar atualizações do tempo, tente novamente mais tarde';
    }

    _isLoading = false;

    notifyListeners();
  }

  //Estado selecionado na homeScreen
  String? selectedState;

  void setSelectedState(String state) {
    selectedState = state;
    notifyListeners();
  }

  Future<void> fetchWeekForecast() async {
    _isLoading = true;
    try {
      _weekForecast =
          await WeatherAPI().getWeekWeatheByState(selectedState ?? '');
    } catch (error) {
      debugPrint(error.toString());
      _error =
          'Não foi possível buscar a previsão do tempo, tente novamente mais tarde';
    }

    _isLoading = false;
    notifyListeners();
  }

  //Previsão da semana mostrada na weather_week screen, de acordo com o estado selecionado
  WeatherForecast? selectedTodayForecast;

  String getCurrentDayOfWeek() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE', 'pt_BR');
    return formatter.format(now);
  }

// previsão de acordo com o dia da semana atual
  findTodayForecast() {
    String currentDay = getCurrentDayOfWeek();

    String currentDayFormatted = FormatUtils.removeAccent(currentDay);
    for (final forecast in weekForecast) {
      if (forecast.dia.toLowerCase() == currentDayFormatted.toLowerCase()) {
        selectedTodayForecast = forecast;
        return forecast;
      }
    }
    _isLoading = false;

    notifyListeners();
  }

  getDateToday() {
    final now = DateTime.now();
    final formatter = DateFormat("d 'de' MMMM 'de' y", 'pt_BR');

    return formatter.format(now);
  }

  void removeStateWeatherForecastByName() {
    stateWeekForecast
        .removeWhere((forecast) => forecast.estado == selectedState);
  }

  void setSelectedForecastDay(WeatherForecast day) {
    _selectedForecastDay = day;
    notifyListeners();
  }
}
