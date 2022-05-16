import 'package:flutter/material.dart';

class InfoSnackbar extends StatelessWidget {
  final String textinfo;

  const InfoSnackbar({Key? key, required this.textinfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      action: SnackBarAction(
        onPressed: () {}, label: '',
      ),
      content: Text(textinfo),
      duration: const Duration(milliseconds: 1500),
      width: 280.0, // Width of the SnackBar.
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
