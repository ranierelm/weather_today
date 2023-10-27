import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FooterMenuIcon {
  final String icon;
  final String semanticsLabel;

  FooterMenuIcon({
    required this.icon,
    required this.semanticsLabel,
  });
}

class FooterMenu extends StatelessWidget {
  final List<FooterMenuIcon> buttons;
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  const FooterMenu({
    super.key,
    required this.buttons,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 46.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          buttons.length,
          (index) {
            final button = buttons[index];
            final selected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                onIndexChanged(index);
              },
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: selected
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          begin: const Alignment(0.00, -1.00),
                          end: const Alignment(0, 1),
                          colors: [
                            const Color(0xFF947CCD).withOpacity(.5),
                            const Color(0xFF523D7F).withOpacity(.5),
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(21),
                        ),
                      )
                    : null,
                child: SvgPicture.asset(
                  button.icon,
                  width: 24,
                  height: 24,
                  semanticsLabel: button.semanticsLabel,
                  colorFilter: const ColorFilter.mode(
                      Color(0xffDEDDDD), BlendMode.srcIn),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
