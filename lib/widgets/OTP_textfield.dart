import 'package:flutter/material.dart';
import 'package:snsc/config/pallete.dart';

class OTPTextField extends StatefulWidget {
  final bool first, last;
  final TextEditingController pinController;
  const OTPTextField({Key? key, required this.first, required this.last, required this.pinController})
      : super(key: key);

  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 70,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: TextField(
            controller: widget.pinController,
            autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && widget.last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && widget.first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Pallete.buttonGreen),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ),
    );
  }
}
