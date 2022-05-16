import 'package:flutter/material.dart';

import '../config/pallete.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final void Function() onPressed;
  const ActionButton(
      {Key? key,
      required this.icon,
      required this.labelText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Pallete.buttonGreen,
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              Icon(icon, size: 20,),
              const SizedBox(width: 5,),
              Expanded(child: Text(labelText, style: const TextStyle(fontSize: 14),)),
            ],
          ),
        ),
      ),
    );
  }
}
