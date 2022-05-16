import 'package:flutter/material.dart';
import 'package:snsc/config/pallete.dart';

class AccessibilityButon extends StatefulWidget {
  final List<String> texts;
  final List<Icon> iconList;
  const AccessibilityButon(
      {Key? key, required this.texts, required this.iconList})
      : super(key: key);

  @override
  State<AccessibilityButon> createState() => _AccessibilityButonState();
}

class _AccessibilityButonState extends State<AccessibilityButon> {
  late int index;

  changeSetting() {
    if (index == widget.texts.length - 1) {
      setState(() {
        index = 0;
      });
    } else {
      setState(() {
        index = index += 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeSetting();
      },
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: widget.iconList[index],
            ),
            Text(
              widget.texts[index],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            index != 0
                ? Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Wrap(
                      spacing: 3,
                      children: [
                        Container(
                          width: 35,
                          height: 10,
                          decoration: BoxDecoration(
                              color: index == 1? Pallete.buttonGreen: Colors.grey,
                              borderRadius: BorderRadius.circular(24)),
                        ),
                        Container(
                          width: 35,
                          height: 10,
                          decoration: BoxDecoration(
                              color: index == 2? Pallete.buttonGreen: Colors.grey,
                              borderRadius: BorderRadius.circular(24)),
                        ),
                        Container(
                          width: 35,
                          height: 10,
                          decoration: BoxDecoration(
                              color: index == 3? Pallete.buttonGreen: Colors.grey,
                              borderRadius: BorderRadius.circular(24)),
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
