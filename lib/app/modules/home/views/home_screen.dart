import 'package:flutter/material.dart';
import 'package:weather_today/app/modules/details/weather_week_screen.dart';
import 'package:weather_today/app/services/api_service.dart';
import 'package:weather_today/app/shared/components/city_listing_card.dart';
import 'package:weather_today/app/shared/components/custom_appbar.dart';
import 'package:weather_today/app/shared/utils/weather_type.dart';
import 'package:weather_today/app/shared/widgets/page_route_animated.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> stateList = [];

  Future<void> fetchInformacoesDoTempo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await WeatherAPI().fetchWeatherInformation();

      // Check if the response contains 'result' and 'estados'
      if (data.containsKey('result') && data['result'].containsKey('estados')) {
        stateList = List<Map<String, dynamic>>.from(data['result']['estados']);
      } else {
        // Handle the case where the JSON structure is different from expected.
        throw Exception('Invalid JSON structure');
      }
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
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    fetchInformacoesDoTempo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(
        title: 'Search for City',
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: stateList.length,
                itemBuilder: (context, index) {
                  final stateData = stateList[index];
                  final cityName = stateData['estado'];

                  return CityListingCard(
                    cityName: cityName,
                    weatherUrl: WeatherType.getWeatherImageUrl('Nublado'),
                    onTap: () => Navigator.push(
                      context,
                      PageRouteAnimated.slide(
                        screen: WeatherWeekScreen(
                          state: cityName,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
