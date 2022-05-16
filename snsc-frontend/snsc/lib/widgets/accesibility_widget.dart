import 'package:flutter/material.dart';
import 'package:snsc/widgets/all_widgets.dart';

import '../config/pallete.dart';

class AccesibilityWidget extends StatefulWidget {
  const AccesibilityWidget({Key? key}) : super(key: key);

  @override
  State<AccesibilityWidget> createState() => _AccesibilityWidgetState();
}

class _AccesibilityWidgetState extends State<AccesibilityWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("ACCESSIBILITY SETTINGS",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: const Color.fromARGB(255, 239, 241, 245),
      content: SizedBox(
        width: 600,
        height: 300,
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          shrinkWrap: true,
          children: const [
            AccessibilityButon(texts: [
              "Text Size",
              "Text Size",
              "Text Size",
              "Text Size"
            ], iconList: [
              Icon(Icons.text_fields_sharp, size: 50),
              Icon(Icons.text_fields_sharp, size: 20),
              Icon(Icons.text_fields_sharp, size: 50),
              Icon(Icons.text_fields_sharp, size: 70),
            ]),
            AccessibilityButon(texts: [
              "Contrast",
              "Invert Colors",
              "Light Contrast",
              "Dark Contrast"
            ], iconList: [
              Icon(Icons.contrast, size: 70),
              Icon(Icons.invert_colors, size: 70),
              Icon(Icons.light_mode, size: 70),
              Icon(Icons.dark_mode, size: 70),
            ]),
            AccessibilityButon(texts: [
              "Dyslexia Friendly",
              "Dyslexia Friendly",
              "Legible Fonts",
              "Default",
            ], iconList: [
              Icon(Icons.abc, size: 70),
              Icon(Icons.abc, size: 70),
              Icon(Icons.abc, size: 70),
              Icon(Icons.abc, size: 70),
            ]),
            AccessibilityButon(texts: [
              "Saturation",
              "Low Saturation",
              "High saturation",
              "Desaturate"
            ], iconList: [
              Icon(Icons.abc, size: 70),
              Icon(Icons.abc, size: 70),
              Icon(Icons.abc, size: 70),
              Icon(Icons.abc, size: 70),
            ]),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Pallete.buttonGreen,
            ),
            onPressed: () {},
            child: const Text(
              "Update Settings",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
      ],
    );
  }
}
