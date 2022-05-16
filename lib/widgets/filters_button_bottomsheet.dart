import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../models/filter.dart';

class FilterButtonBottomSheet extends StatefulWidget {
  final String name;
  final List<Filter> objects;
  final Function(List<String>, List<Filter>)? setFilter;
  final List<Filter> previouslySelected;

  const FilterButtonBottomSheet(
      {Key? key,
      required this.name,
      required this.objects,
      this.setFilter,
      required this.previouslySelected})
      : super(key: key);

  @override
  _FilterButtonBottomSheetState createState() =>
      _FilterButtonBottomSheetState();
}

class _FilterButtonBottomSheetState extends State<FilterButtonBottomSheet> {
  List<Filter> selectedObjects = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    selectedObjects = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
        ),
        child: Column(
          children: <Widget>[
            MultiSelectBottomSheetField(
              initialValue: widget.previouslySelected,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              initialChildSize: 0.4,
              maxChildSize: 0.9,
              minChildSize: 0.1,
              listType: MultiSelectListType.CHIP,
              searchable: true,
              buttonText: Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              title: Text(widget.name),
              items: widget.objects
                  .map((e) => MultiSelectItem(e, e.name!))
                  .toList(),
              onConfirm: (values) {
                widget.setFilter!(
                    Filter.convertToStringList(values), values.cast());
                selectedObjects = values.cast();
              },
              chipDisplay: MultiSelectChipDisplay(
                height: 45,
                scroll: true,
                onTap: (value) {
                  setState(() {
                    selectedObjects.remove(value);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
