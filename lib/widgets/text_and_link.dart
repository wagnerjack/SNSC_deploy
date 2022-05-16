import 'package:flutter/material.dart';

class TextAndLink extends StatelessWidget {
  const TextAndLink(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.navigateTo})
      : super(key: key);
  final String text1;
  final String text2;
  final Widget navigateTo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Text(
          text1,
          style: const TextStyle(color: Colors.black),
        ),
        const Text("   "),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => navigateTo),
            );
          },
          child: Text(
            text2,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
