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
        width: 800,
        height: 200,
        child: Row(
          children: const [
            AccessibilityButon(texts: [
              "Text Spacing",
              "Light Spacing",
              "Moderate Spacing",
              "Heavy Spacing"
            ], iconList: [
              Icon(Icons.format_line_spacing, size: 50),
              Icon(Icons.text_fields_sharp, size: 20),
              Icon(Icons.text_fields_sharp, size: 50),
              Icon(Icons.text_fields_sharp, size: 70),
            ]),
            Spacer(),
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
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Pallete.buttonGreen,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Update Settings",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
      ],
    );
  }
}
