import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/pallete.dart';

class DonateButton extends StatelessWidget {
  const DonateButton(
      {Key? key, required this.text, required this.icon, required this.url})
      : super(key: key);

  final String text;
  final Icon icon;
  final String url;

  static Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Pallete.buttonGreen,
          ),
          onPressed: () => _launchInBrowser(url),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 2),
              Expanded(
                  child: Text(
                text,
                style: const TextStyle(fontSize: 11),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
