import 'package:flutter/material.dart';

class RoundedRectangleButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Color buttoncolor;
  final void Function() onPressed;

  const RoundedRectangleButton(
      {Key? key,
      required this.width,
      required this.onPressed,
      required this.text,
      required this.buttoncolor,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: ElevatedButton(
              onPressed: onPressed,
              child: FittedBox(
                child: Text( 
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 28.0),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: buttoncolor,
                elevation: 15,
                shadowColor: Colors.black,
              ))),
    );
  }
}
