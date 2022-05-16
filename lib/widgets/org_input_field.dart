import 'package:flutter/material.dart';

class OrgInputField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final int minLines;
  final TextEditingController controller;
  const OrgInputField(
      {Key? key,
      required this.hintText,
      required this.labelText,
      required this.minLines, required this.controller})
      : super(key: key);

  @override
  State<OrgInputField> createState() => _OrgInputFieldState();
}

class _OrgInputFieldState extends State<OrgInputField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 10.0,
        right: 20.0,
        bottom: 0.0,
      ),
      child: Container(
        // width: size.width * 0.9,
        decoration: const BoxDecoration(),
        child: TextField(
          controller: widget.controller,
          maxLines: null,
          minLines: widget.minLines,
          decoration: InputDecoration(
              hintText: widget.hintText,
              border: const OutlineInputBorder(),
              labelText: widget.labelText),
        ),
      ),
    );
  }
}
