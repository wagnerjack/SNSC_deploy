import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:snsc/config/pallete.dart';

class FilterButtonNumber extends StatefulWidget {
  final String querryText;
  final Function(String)? setFilter;
  final String? prevSelected;
  const FilterButtonNumber(
      {Key? key,
      required this.querryText,
      this.setFilter,
      required this.prevSelected})
      : super(key: key);

  @override
  State<FilterButtonNumber> createState() => _FilterButtonNumberState();
}

class _FilterButtonNumberState extends State<FilterButtonNumber> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = int.parse(widget.prevSelected!);
  }

  Future<void> _showMyDialog(text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          elevation: 24.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
          content: StatefulBuilder(
            builder: (context, builderSetState) {
              return NumberPicker(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 20),
                  selectedTextStyle:
                      const TextStyle(color: Colors.green, fontSize: 30),
                  itemCount: 4,
                  value: _currentValue,
                  minValue: 0,
                  maxValue: 150,
                  onChanged: (value) {
                    setState(() => _currentValue = value);
                    builderSetState(() => _currentValue = value);
                  });
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                  )),
              onPressed: () {
                widget.setFilter!(_currentValue.toString());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
          width: 400,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.querryText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Pallete.buttonGreen.withOpacity(0.8)),
                    onPressed: () => _showMyDialog(widget.querryText),
                    child: Text(
                      "$_currentValue",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
