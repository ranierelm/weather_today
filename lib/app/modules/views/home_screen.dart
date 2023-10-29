import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/app/modules/controllers/app_provider.dart';
import 'package:weather_today/app/modules/views/weather_week_screen.dart';
import 'package:weather_today/app/shared/components/city_listing_card.dart';
import 'package:weather_today/app/shared/components/custom_alert_dialog.dart';
import 'package:weather_today/app/shared/components/custom_appbar.dart';
import 'package:weather_today/app/shared/components/loading_component.dart';
import 'package:weather_today/app/shared/utils/weather_utils.dart';
import 'package:weather_today/app/shared/widgets/page_route_animated.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<AppProvider>(context, listen: false)
        .fetchStateWeatherForecasts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(
        title: 'Search for City',
      ),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          if (appProvider.isLoading) {
            return const Center(child: LoadingComponent());
          } else if (appProvider.error != null) {
            return CustomDialog.showAlertDialog(context,
                title: 'Atenção', content: appProvider.error ?? '');
          } else {
            return Center(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: appProvider.stateWeekForecast.length,
                itemBuilder: (context, index) {
                  final weatherForecastByCity =
                      appProvider.stateWeekForecast[index];

                  return CityListingCard(
                    cityName: weatherForecastByCity.estado,
                    weatherUrl: WeatherUtils.getWeatherImageUrl(
                      WeatherUtils.getDayPeriodWeather(
                        weekForecast: weatherForecastByCity
                            .previsoes[WeatherUtils.getCurrentDayOfWeek()],
                      ),
                    ),
                    onTap: () {
                      Provider.of<AppProvider>(context, listen: false)
                          .setSelectedState(weatherForecastByCity.estado);

                      Navigator.push(
                        context,
                        PageRouteAnimated.slide(
                          screen: const WeatherWeekScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
