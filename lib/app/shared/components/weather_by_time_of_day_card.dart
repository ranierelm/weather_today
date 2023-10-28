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
    return Container(
      width: 110,
      height: 148,
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
            style: const TextStyle(
              color: Color(0xFFDEDDDD),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 60, maxWidth: 80),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    WeatherUtils.getWeatherImageUrl(weatherForecast['tempo'])),
                fit: BoxFit.contain,
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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
    );
  }
}
