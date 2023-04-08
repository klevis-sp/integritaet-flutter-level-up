import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text.rich(
        const TextSpan(
          text: 'Misioni Kombëtar për',
          style: TextStyle(
            color: kFontLight,
            fontSize: 12.5,
          ),
          children: [
            TextSpan(
              text: ' Integritet Zgjedhor',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        overflow: TextOverflow.fade,
        maxLines: 1,
        textAlign: TextAlign.center,
        textScaleFactor: // based on the device size
            MediaQuery.of(context).size.width < 395 ? 1.0 : 1.2,
      ),
      actions: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0, right: 20),
              padding: const EdgeInsets.only(right: 3),
              decoration: BoxDecoration(
                color: kBackground,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: kFontLight.withOpacity(0.2),
                    offset: const Offset(0, 12),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 10, right: 6, top: 3, bottom: 3),
                child: Image(
                  image: AssetImage('assets/app_icon/icon.png'),
                  height: 30,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
