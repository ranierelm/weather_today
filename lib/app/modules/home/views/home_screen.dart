import 'package:flutter/material.dart';
import 'package:weather_today/app/modules/details/weather_week_screen.dart';
import 'package:weather_today/app/modules/models/state_weather_forecast.dart';
import 'package:weather_today/app/services/api_service.dart';
import 'package:weather_today/app/shared/components/city_listing_card.dart';
import 'package:weather_today/app/shared/components/custom_alert_dialog.dart';
import 'package:weather_today/app/shared/components/custom_appbar.dart';
import 'package:weather_today/app/shared/utils/weather_utils.dart';
import 'package:weather_today/app/shared/widgets/page_route_animated.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> stateList = [];

  List<StateWeatherForecast> weekForecast = [];

  Future<void> fetchStateWeatherForecasts() async {
    setState(() => _isLoading = true);
    try {
      weekForecast = await WeatherAPI().getStateWeatherForecasts();

      setState(() {});
    } catch (error) {
      debugPrint(error.toString());
      if (!mounted) return;

      CustomDialog.showAlertDialog(context,
          title: 'Atenção',
          content:
              'Não foi possível buscar atualizações do tempo, tente novamente mais tarde');
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    fetchStateWeatherForecasts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(
        title: 'Search for City',
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: weekForecast.length,
                itemBuilder: (context, index) {
                  final weatherForecastByCity = weekForecast[index];

                  return CityListingCard(
                    cityName: weatherForecastByCity.estado,
                    weatherUrl: WeatherUtils.getWeatherImageUrl(
                        WeatherUtils.getDayPeriodWeather(
                            weekForecast: weatherForecastByCity.previsoes[
                                WeatherUtils.getCurrentDayOfWeek()])),
                    onTap: () => Navigator.push(
                      context,
                      PageRouteAnimated.slide(
                        screen: WeatherWeekScreen(
                          state: weatherForecastByCity.estado,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
