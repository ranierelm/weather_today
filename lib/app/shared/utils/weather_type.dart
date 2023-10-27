class WeatherType {
  static String getImageUrl(String description) {
    switch (description) {
      case 'rainy':
        return 'assets/images/rainy.png';
      case 'cloudy':
        return 'assets/images/cloudy.png';
      case 'storm':
        return 'assets/images/rain.png';
      default:
        return 'assets/images/cloudy.png';
    }
  }
}
