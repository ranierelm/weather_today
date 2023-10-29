import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/app/modules/controllers/app_provider.dart';
import 'package:weather_today/app/shared/components/background_scaffold.dart';
import 'package:weather_today/app/shared/components/custom_alert_dialog.dart';
import 'package:weather_today/app/shared/components/custom_appbar.dart';
import 'package:weather_today/app/shared/components/loading_component.dart';
import 'package:weather_today/app/shared/components/states_weather_carousel.dart';
import 'package:weather_today/app/shared/components/weather_by_time_of_day_card.dart';
import 'package:weather_today/app/shared/utils/formats.dart';
import 'package:weather_today/app/shared/utils/weather_utils.dart';

class WeatherTodayScreen extends StatefulWidget {
  const WeatherTodayScreen({Key? key}) : super(key: key);

  @override
  State<WeatherTodayScreen> createState() => _WeatherTodayScreenState();
}

class _WeatherTodayScreenState extends State<WeatherTodayScreen> {
  String dateToday = '';

  String? selectedState;

  @override
  void initState() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    selectedState = appProvider.selectedState;

    dateToday = appProvider.getDateToday();

    appProvider.fetchStateWeatherForecasts().then((_) {
      appProvider.removeStateWeatherForecastByName();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: selectedState ?? '',
          onTapLeading: () => Navigator.pop(context),
          leadingSemanticsLabel: 'Button to return to the previous page',
          iconLeading: 'assets/icons/arrow-left-thin.svg',
        ),
        body: Consumer<AppProvider>(
          builder: (context, appProvider, child) {
            if (appProvider.isLoading) {
              return const Center(child: LoadingComponent());
            } else if (appProvider.error != null) {
              return CustomDialog.showAlertDialog(context,
                  title: 'Atenção', content: appProvider.error ?? '');
            } else {
              return SizedBox(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        FormatUtils.capitalize(
                            appProvider.selectedForecastDay!.dia),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFDEDDDD),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        constraints:
                            const BoxConstraints(maxHeight: 125, maxWidth: 160),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(WeatherUtils.getWeatherImageUrl(
                                WeatherUtils.getDayPeriodWeather(
                                    weekForecast:
                                        appProvider.selectedForecastDay))),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Column(
                        children: [
                          SizedBox(
                            height: 95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  WeatherUtils.getDayPeriodDegrees(
                                      weekForecast:
                                          appProvider.selectedForecastDay),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 81,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  width: 16,
                                  height: 16,
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 3, color: Colors.white),
                                  ),
                                  // margin: const EdgeInsets.only(bottom: 50),
                                  alignment: Alignment.topCenter,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            dateToday,
                            style: const TextStyle(
                              color: Color(0xFFDEDDDD),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 44),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hoje',
                              style: TextStyle(
                                color: Color(0xFFDEDDDD),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeatherByTimeOfDayCard(
                                  time: 'Manhã',
                                  weatherForecast:
                                      appProvider.selectedForecastDay!.manha,
                                ),
                                WeatherByTimeOfDayCard(
                                  time: 'Tarde',
                                  weatherForecast:
                                      appProvider.selectedForecastDay!.tarde,
                                ),
                                WeatherByTimeOfDayCard(
                                  time: 'Noite',
                                  weatherForecast:
                                      appProvider.selectedForecastDay!.noite,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 44),
                      StatesWeatherCarousel(
                        weatherByStates: appProvider.stateWeekForecast,
                      ),
                    ]),
              );
            }
          },
        ),
      ),
    );
  }
}
