import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:weather_today/app/modules/models/weather_forecast.dart';
import 'package:weather_today/app/services/api_service.dart';
import 'package:weather_today/app/shared/components/background_scaffold.dart';
import 'package:weather_today/app/shared/components/custom_appbar.dart';
import 'package:weather_today/app/shared/components/temperature_days_week_card.dart';
import 'package:weather_today/app/shared/components/today_temperature_card.dart';
import 'package:weather_today/app/shared/utils/formats.dart';

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

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          content: const Text(
              'Não foi possível buscar atualizações do tempo, tente novamente mais tarde'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  Future<String> getCurrentDayOfWeek() async {
    await initializeDateFormatting('pt_BR');
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

  String getDayPeriodDegrees(int index) {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 6 && hour < 12) {
      return weekForecast[index].manha['graus'].toString();
    } else if (hour >= 12 && hour < 18) {
      return weekForecast[index].tarde['graus'].toString();
    } else {
      return weekForecast[index].noite['graus'].toString();
    }
  }

  String getDayPeriodWeather(int index) {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 6 && hour < 12) {
      return weekForecast[index].manha['tempo'].toString();
    } else if (hour >= 12 && hour < 18) {
      return weekForecast[index].tarde['tempo'].toString();
    } else {
      return weekForecast[index].noite['tempo'].toString();
    }
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
                            itemBuilder: (context, index) {
                              final dia = weekForecast[index].dia;
                              final tempo = getDayPeriodWeather(index);
                              final graus = getDayPeriodDegrees(index);

                              return TemperatureDaysWeekCard(
                                dayWeek: dia,
                                weatherName: tempo,
                                temperature: graus,
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
