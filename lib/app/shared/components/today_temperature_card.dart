import 'package:flutter/material.dart';
import 'package:weather_today/app/shared/utils/weather_type.dart';

class TodayTemperatureCard extends StatelessWidget {
  final String weatherName;
  final String temperature;

  const TodayTemperatureCard({
    Key? key,
    required this.weatherName,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      alignment: AlignmentDirectional.center,
      width: 387,
      height: 170,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.00, -1.00),
          end: const Alignment(0, 1),
          colors: [
            const Color(0xFF947CCD).withOpacity(0.5),
            const Color(0xFF523D7F).withOpacity(0.5)
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 21, top: 6, bottom: 6),
            constraints: const BoxConstraints(maxHeight: 125, maxWidth: 160),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(WeatherType.getWeatherImageUrl(weatherName)),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  temperature,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 55,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: 10,
                  height: 80,

                  decoration: BoxDecoration(
                    shape:
                        BoxShape.circle, // Usamos um círculo em vez de um oval
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  margin: const EdgeInsets.only(
                      right: 46, bottom: 50), // Espaçamento à esquerda
                  alignment: Alignment.topCenter,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
