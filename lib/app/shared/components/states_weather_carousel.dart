import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_today/app/modules/models/state_weather_forecast.dart';
import 'package:weather_today/app/shared/utils/weather_utils.dart';

class StatesWeatherCarousel extends StatelessWidget {
  final List<StateWeatherForecast> weatherByStates;
  const StatesWeatherCarousel({super.key, required this.weatherByStates});

  int getCurrentDayOfWeek() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE', 'pt_BR');
    final dayOfWeekString = formatter.format(now);

    final dayOfWeekMap = {
      'segunda': 0,
      'terça': 1,
      'quarta': 2,
      'quinta': 3,
      'sexta': 4,
      'sábado': 5,
      'domingo': 6,
    };

    return dayOfWeekMap[dayOfWeekString.toLowerCase()] ?? -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'Estados',
            style: TextStyle(
              color: Color(0xFFDEDDDD),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: weatherByStates.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return Container(
                width: 156,
                height: 50,
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.only(right: 5),
                child: Row(
                  children: [
                    Container(
                      constraints:
                          const BoxConstraints(maxHeight: 40, maxWidth: 45),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(WeatherUtils.getWeatherImageUrl(
                              WeatherUtils.getDayPeriodWeather(
                                  weekForecast: weatherByStates[index]
                                      .previsoes[getCurrentDayOfWeek()]))),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          weatherByStates[index].estado,
                          overflow: TextOverflow.ellipsis,
                          // textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          WeatherUtils.getDayPeriodDegrees(
                              weekForecast: weatherByStates[index]
                                  .previsoes[getCurrentDayOfWeek()]),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.white),
                          ),
                          margin: const EdgeInsets.only(left: 2),
                          alignment: Alignment.topCenter,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
