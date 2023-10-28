import 'package:flutter/material.dart';
import 'package:weather_today/app/shared/components/background_scaffold.dart';
import 'package:weather_today/app/shared/components/custom_appbar.dart';
import 'package:weather_today/app/shared/components/temperature_days_week_card.dart';
import 'package:weather_today/app/shared/components/today_temperature_card.dart';

class WeatherWeekScreen extends StatefulWidget {
  const WeatherWeekScreen({super.key});

  @override
  State<WeatherWeekScreen> createState() => _WeatherWeekScreenState();
}

class _WeatherWeekScreenState extends State<WeatherWeekScreen> {
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
        body: const Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Segunda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFDEDDDD),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  TodayTemperatureCard(
                    weatherUrl: 'assets/images/cloudy.png',
                    temperature: '23',
                  ),
                  SizedBox(height: 72),
                  TemperatureDaysWeekCard(
                    dayWeek: 'Segunda',
                    weatherUrl: 'assets/images/cloudy.png',
                    weatherName: 'Nublado',
                    temperature: '31',
                  ),
                  TemperatureDaysWeekCard(
                    dayWeek: 'Segunda',
                    weatherUrl: 'assets/images/cloudy.png',
                    weatherName: 'Nublado',
                    temperature: '31',
                  ),
                  TemperatureDaysWeekCard(
                    dayWeek: 'Segunda',
                    weatherUrl: 'assets/images/cloudy.png',
                    weatherName: 'Nublado',
                    temperature: '31',
                  ),
                  TemperatureDaysWeekCard(
                    dayWeek: 'Segunda',
                    weatherUrl: 'assets/images/cloudy.png',
                    weatherName: 'Nublado',
                    temperature: '31',
                  ),
                  TemperatureDaysWeekCard(
                    dayWeek: 'Segunda',
                    weatherUrl: 'assets/images/cloudy.png',
                    weatherName: 'Nublado',
                    temperature: '31',
                  ),
                  TemperatureDaysWeekCard(
                    dayWeek: 'Segunda',
                    weatherUrl: 'assets/images/cloudy.png',
                    weatherName: 'Nublado',
                    temperature: '31',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
