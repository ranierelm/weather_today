class WeatherForecast {
  final String dia;
  final Map<String, dynamic> manha;
  final Map<String, dynamic> tarde;
  final Map<String, dynamic> noite;

  WeatherForecast({
    required this.dia,
    required this.manha,
    required this.tarde,
    required this.noite,
  });
}
