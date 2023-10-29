import 'package:flutter/material.dart';
import 'package:weather_today/app/shared/utils/weather_utils.dart';

class WeatherByTimeOfDayCard extends StatelessWidget {
  final String time;
  final Map<String, dynamic> weatherForecast;

  const WeatherByTimeOfDayCard({
    Key? key,
    required this.time,
    required this.weatherForecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Defina o tamanho do widget com base nas dimensões da tela
    final widgetWidth = screenWidth >= 600 ? 220.0 : 110.0;
    final widgetHeight = screenWidth >= 600 ? 296.0 : 148.0;

    // Ajuste a fonte com base nas dimensões da tela
    final fontSize = screenWidth >= 600 ? 16.0 : 12.0;

    // Ajuste a altura máxima da imagem com base nas dimensões da tela
    final imageMaxHeight = screenWidth >= 600 ? 80.0 : 60.0;
    final imageMaxWidth = screenWidth >= 600 ? 100.0 : 80.0;

    return Flexible(
      child: Container(
        width: widgetWidth,
        height: widgetHeight,
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [
              const Color(0xFF947CCD).withOpacity(0.5),
              const Color(0xFF523D7F).withOpacity(0.5)
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: TextStyle(
                color: const Color(0xFFDEDDDD),
                fontSize: fontSize,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Center(
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: imageMaxHeight, maxWidth: imageMaxWidth),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(WeatherUtils.getWeatherImageUrl(
                        weatherForecast['tempo'])),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              height: 25,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    weatherForecast['graus'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    margin: const EdgeInsets.only(left: 2),
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
