import 'package:flutter/material.dart';
import 'package:snsc/widgets/text_field.dart';

class RoundedInputField extends StatefulWidget {
  const RoundedInputField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.onChanged,
      required this.controller,
      this.validator,
      required this.obscure,
      required this.inputType})
      : super(key: key);
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscure;
  final TextInputType inputType;

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: SizedBox(
        width: 400,
        child: TextFieldContainer(
          child: TextFormField(
            keyboardType: widget.inputType,
            obscureText: widget.obscure ? isObscure : false,
            validator: widget.validator,
            controller: widget.controller,
            onChanged: widget.onChanged,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              icon: Icon(
                widget.icon,
                color: Colors.grey,
              ),
              suffixIcon: widget.obscure
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: isObscure
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off))
                  : null,
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
