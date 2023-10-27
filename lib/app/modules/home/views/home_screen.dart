import 'package:flutter/material.dart';
import 'package:weather_today/app/modules/models/weather_data.dart';
import 'package:weather_today/app/services/api_service.dart';
import 'package:weather_today/app/shared/components/city_listing_card.dart';
import 'package:weather_today/app/shared/components/custom_appbar.dart';
import 'package:weather_today/app/shared/utils/weather_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  List<StateData> stateList = []; // Lista de dados dos estados

  Future<void> fetchInformacoesDoTempo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await WeatherAPI().fetchWeatherInformation();
      // Preencha a lista de stateList com os dados retornados da API.
      stateList = data.states;
    } catch (error) {
      debugPrint(error.toString());
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          title: const Text(
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
                itemCount: stateList.length, // Número de itens na lista
                itemBuilder: (context, index) {
                  final stateData = stateList[index];
                  final cityName = stateData.state;

                  return CityListingCard(
                    cityName: cityName,
                    weatherUrl: WeatherType.getImageUrl('cloudy'),
                  );
                },
              ),
            ),
    );
  }
}
