import 'package:flutter/material.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/widgets/all_widgets.dart';

class AppBarReturn extends StatelessWidget {
  const AppBarReturn(
      {Key? key, required this.returnPage, required this.popContext})
      : super(key: key);

  final Widget returnPage;
  final bool popContext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CircleButton(
                icon: Icons.arrow_back,
                iconSize: 40,
                color: Pallete.buttondarkBlue,
                onPressed: popContext
                    ? () {
                        Navigator.pop(context);
                      }
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => returnPage),
                        );
                      }),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: CircleButton(
                icon: Icons.settings_accessibility,
                iconSize: 40,
                color: Pallete.buttondarkBlue,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AccesibilityWidget();
                      });
                }),
          ),
        ],
      ),
    );
  }
}
