import 'package:intl/intl.dart';
import 'package:weather_today/app/modules/models/weather_forecast.dart';

class WeatherUtils {
  static String getWeatherImageUrl(String weatherName) {
    switch (weatherName.toLowerCase()) {
      case 'chuva':
        return 'assets/images/weather_images/chuva.png';
      case 'neve':
        return 'assets/images/weather_images/neve.png';
      case 'nublado':
        return 'assets/images/weather_images/nublado.png';
      case 'sol':
        return 'assets/images/weather_images/sol.png';
      case 'tempestade':
        return 'assets/images/weather_images/tempestade.png';
      case 'trovão':
        return 'assets/images/weather_images/trovao.png';
      default:
        return 'assets/images/weather_images/nublado.png';
    }
  }

  static String getDayPeriodDegrees(
      {List<WeatherForecast>? weekForecasts,
      WeatherForecast? weekForecast,
      int? index}) {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 6 && hour < 12) {
      return weekForecasts == null
          ? weekForecast!.manha['graus'].toString()
          : weekForecasts[index!].manha['graus'].toString();
    } else if (hour >= 12 && hour < 18) {
      return weekForecasts == null
          ? weekForecast!.tarde['graus'].toString()
          : weekForecasts[index!].tarde['graus'].toString();
    } else {
      return weekForecasts == null
          ? weekForecast!.noite['graus'].toString()
          : weekForecasts[index!].noite['graus'].toString();
    }
  }

  static String getDayPeriodWeather(
      {List<WeatherForecast>? weekForecasts,
      WeatherForecast? weekForecast,
      int? index}) {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 6 && hour < 12) {
      return weekForecasts == null
          ? weekForecast!.manha['tempo'].toString()
          : weekForecasts[index!].manha['tempo'].toString();
    } else if (hour >= 12 && hour < 18) {
      return weekForecasts == null
          ? weekForecast!.tarde['tempo'].toString()
          : weekForecasts[index!].tarde['tempo'].toString();
    } else {
      return weekForecasts == null
          ? weekForecast!.noite['tempo'].toString()
          : weekForecasts[index!].noite['tempo'].toString();
    }
  }

  static int getCurrentDayOfWeek() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE', 'pt_BR');
    final dayOfWeekString = formatter.format(now);

    final dayOfWeekMap = {
      'segunda': 0,
      'terça': 1,
      'quarta': 2,
      'quinta': 3,
      'sexta': 4,
      'sábado': 5,
      'domingo': 6,
    };

    return dayOfWeekMap[dayOfWeekString.toLowerCase()] ?? -1;
  }
}
