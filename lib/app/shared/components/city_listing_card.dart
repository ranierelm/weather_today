import 'package:flutter/material.dart';

class CityListingCard extends StatelessWidget {
  final String cityName;
  final String weatherUrl;
  final Function()? onTap;

  const CityListingCard({
    Key? key,
    required this.cityName,
    required this.weatherUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 17, 73, 7),
            margin: const EdgeInsets.only(left: 15, right: 8),
            child: Align(
              child: Container(
                width: MediaQuery.of(context).size.width -
                    96, // Define a largura baseada no tamanho da tela
                height: 90,
                padding: const EdgeInsets.only(left: 34, top: 29),
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0, 1),
                    colors: [
                      const Color(0xFF947CCD).withOpacity(.5),
                      const Color(0xFF523D7F).withOpacity(.5)
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  cityName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0.03,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 117, maxWidth: 145),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(weatherUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
