import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/app/modules/controllers/app_provider.dart';
import 'package:weather_today/app/modules/views/weather_today_screen.dart';
import 'package:weather_today/app/shared/components/background_scaffold.dart';
import 'package:weather_today/app/shared/components/custom_alert_dialog.dart';
import 'package:weather_today/app/shared/components/custom_appbar.dart';
import 'package:weather_today/app/shared/components/loading_component.dart';
import 'package:weather_today/app/shared/components/temperature_days_week_card.dart';
import 'package:weather_today/app/shared/components/today_temperature_card.dart';
import 'package:weather_today/app/shared/utils/formats.dart';
import 'package:weather_today/app/shared/utils/weather_utils.dart';
import 'package:weather_today/app/shared/widgets/page_route_animated.dart';

class WeatherWeekScreen extends StatefulWidget {
  const WeatherWeekScreen({
    super.key,
  });

  @override
  State<WeatherWeekScreen> createState() => _WeatherWeekScreenState();
}

class _WeatherWeekScreenState extends State<WeatherWeekScreen> {
  String? selectedState;

  @override
  void initState() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    selectedState = appProvider.selectedState;

    if (selectedState != null) {
      appProvider.fetchWeekForecast().then((_) {
        appProvider.findTodayForecast();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: '7 Dias',
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
              return RawScrollbar(
                thumbColor: Colors.white60,
                thickness: 3,
                radius: const Radius.circular(8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (appProvider.selectedTodayForecast == null)
                                ? const SizedBox()
                                : Text(
                                    FormatUtils.capitalize(
                                        appProvider.selectedTodayForecast!.dia),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFFDEDDDD),
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            const SizedBox(height: 10),
                            TodayTemperatureCard(
                              weatherName: WeatherUtils.getDayPeriodWeather(
                                  weekForecast:
                                      appProvider.selectedTodayForecast),
                              temperature: appProvider.selectedTodayForecast ==
                                      null
                                  ? '23'
                                  : WeatherUtils.getDayPeriodDegrees(
                                      weekForecast:
                                          appProvider.selectedTodayForecast),
                            ),
                            const SizedBox(height: 32),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: appProvider.weekForecast.length,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) {
                                final dia = appProvider.weekForecast[index].dia;
                                final tempo = WeatherUtils.getDayPeriodWeather(
                                    weekForecasts: appProvider.weekForecast,
                                    index: index);
                                final graus = WeatherUtils.getDayPeriodDegrees(
                                    weekForecasts: appProvider.weekForecast,
                                    index: index);

                                return TemperatureDaysWeekCard(
                                    dayWeek: dia,
                                    weatherName: tempo,
                                    temperature: graus,
                                    onTap: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .setSelectedForecastDay(
                                              appProvider.weekForecast[index]);

                                      Navigator.push(
                                        context,
                                        PageRouteAnimated.slide(
                                          screen: const WeatherTodayScreen(),
                                        ),
                                      );
                                    });
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
