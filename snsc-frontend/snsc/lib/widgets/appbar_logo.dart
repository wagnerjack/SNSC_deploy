import 'package:flutter/material.dart';
import 'package:snsc/config/pallete.dart';
import '../Pages/all_pages.dart';
import 'all_widgets.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 70,
              child: Image.asset('Assets/high_res_SNSC_logo.png'),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: CircleButton(
                icon: Icons.settings_accessibility,
                iconSize: 40,
                color: Pallete.buttondarkBlue,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AccesibilityWidget();
                      });
                }),
          ),
        ],
      ),
    );
  }
}
