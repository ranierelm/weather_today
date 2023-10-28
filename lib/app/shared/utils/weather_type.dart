class WeatherType {
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
      case 'trovao':
        return 'assets/images/weather_images/trovao.png';
      default:
        return 'assets/images/weather_images/nublado.png';
    }
  }
}
