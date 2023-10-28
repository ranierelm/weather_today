import 'package:flutter/material.dart';
import 'package:weather_today/app/shared/utils/formats.dart';

class TemperatureDaysWeekCard extends StatelessWidget {
  final String dayWeek;
  final String weatherUrl;
  final String weatherName;
  final String temperature;

  const TemperatureDaysWeekCard({
    Key? key,
    required this.dayWeek,
    required this.weatherUrl,
    required this.weatherName,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              FormatUtils.capitalize(dayWeek),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(maxHeight: 50, maxWidth: 60),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(weatherUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    weatherName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    temperature,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    margin: const EdgeInsets.only(bottom: 20, left: 2),
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
