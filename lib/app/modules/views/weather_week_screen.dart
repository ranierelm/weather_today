import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_today/app/modules/views/weather_today_screen.dart';
import 'package:weather_today/app/modules/models/weather_forecast.dart';
import 'package:weather_today/app/services/api_service.dart';
import 'package:weather_today/app/shared/components/background_scaffold.dart';
import 'package:weather_today/app/shared/components/custom_alert_dialog.dart';
import 'package:weather_today/app/shared/components/custom_appbar.dart';
import 'package:weather_today/app/shared/components/temperature_days_week_card.dart';
import 'package:weather_today/app/shared/components/today_temperature_card.dart';
import 'package:weather_today/app/shared/utils/formats.dart';
import 'package:weather_today/app/shared/utils/weather_utils.dart';
import 'package:weather_today/app/shared/widgets/page_route_animated.dart';

class WeatherWeekScreen extends StatefulWidget {
  final String state;

  const WeatherWeekScreen({super.key, required this.state});

  @override
  State<WeatherWeekScreen> createState() => _WeatherWeekScreenState();
}

class _WeatherWeekScreenState extends State<WeatherWeekScreen> {
  bool _isLoading = false;

  List<WeatherForecast> weekForecast = [];
  WeatherForecast? todayForecast;

  Future<void> fetchWeekForecast() async {
    try {
      weekForecast = await WeatherAPI().getWeekWeatheByState(widget.state);
    } catch (error) {
      debugPrint(error.toString());
      if (!mounted) return;

      CustomDialog.showAlertDialog(context,
          title: 'Atenção',
          content:
              'Não foi possível buscar atualizações do tempo, tente novamente mais tarde');
    }
  }

  Future<String> getCurrentDayOfWeek() async {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE', 'pt_BR');
    return formatter.format(now);
  }

// previsão de acordo com o dia da semana atual
  findTodayForecast() async {
    String currentDay = await getCurrentDayOfWeek();

    String currentDayFormatted = FormatUtils.removeAccent(currentDay);
    for (final forecast in weekForecast) {
      if (forecast.dia.toLowerCase() == currentDayFormatted.toLowerCase()) {
        todayForecast = forecast;
        return forecast;
      }
    }
  }

  _getData() async {
    setState(() {
      _isLoading = true;
    });
    await fetchWeekForecast();
    await findTodayForecast();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getData();
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
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (todayForecast == null)
                              ? const SizedBox()
                              : Text(
                                  FormatUtils.capitalize(todayForecast!.dia),
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
                            weatherName: todayForecast!.manha['tempo'],
                            temperature: todayForecast == null
                                ? '23'
                                : todayForecast!.manha['graus'].toString(),
                          ),
                          const SizedBox(height: 56),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: weekForecast.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final dia = weekForecast[index].dia;
                              final tempo = WeatherUtils.getDayPeriodWeather(
                                  weekForecasts: weekForecast, index: index);
                              final graus = WeatherUtils.getDayPeriodDegrees(
                                  weekForecasts: weekForecast, index: index);

                              return TemperatureDaysWeekCard(
                                dayWeek: dia,
                                weatherName: tempo,
                                temperature: graus,
                                onTap: () => Navigator.push(
                                  context,
                                  PageRouteAnimated.slide(
                                    screen: WeatherTodayScreen(
                                      state: widget.state,
                                      weatherToday: weekForecast[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
