import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? iconLeading;
  final Function()? onTapLeading;
  final String? leadingSemanticsLabel;
  final String title;
  final String? action;
  final String? actionSemanticsLabel;
  final Function()? onTapAction;

  const CustomAppBar(
      {Key? key,
      this.iconLeading,
      this.leadingSemanticsLabel,
      this.onTapLeading,
      required this.title,
      this.action,
      this.actionSemanticsLabel,
      this.onTapAction})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 15);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            (action != null)
                ? InkWell(
                    onTap: onTapLeading,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xFF947CCD), Color(0xFF523D7F)],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          iconLeading ?? '',
                          width: 24,
                          height: 24,
                          semanticsLabel: leadingSemanticsLabel,
                          colorFilter: const ColorFilter.mode(
                              Color(0xffDEDDDD), BlendMode.srcIn),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.square(
                    dimension: 35,
                  ),
            Expanded(
                child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0.03,
              ),
            )),
            (action != null)
                ? InkWell(
                    onTap: onTapAction,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: const Alignment(0.00, -1.00),
                          end: const Alignment(0, 1),
                          colors: [
                            const Color(0xFF947CCD).withOpacity(0.3),
                            const Color(0xFF523D7F).withOpacity(0.3)
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: SvgPicture.asset(
                        action ?? '',
                        width: 24,
                        height: 24,
                        semanticsLabel: actionSemanticsLabel,
                        colorFilter: const ColorFilter.mode(
                            Color(0xffDEDDDD), BlendMode.srcIn),
                      ),
                    ),
                  )
                : const SizedBox.square(
                    dimension: 35,
                  ),
          ],
        ),
      ),
    );
  }
}
