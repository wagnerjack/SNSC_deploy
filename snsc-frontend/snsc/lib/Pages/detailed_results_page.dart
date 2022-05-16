import 'package:flutter/material.dart';
import 'package:snsc/models/organization.dart';
import 'package:snsc/widgets/all_widgets.dart';

class DetailedResultsPage extends StatefulWidget {
  final Organization org;
  const DetailedResultsPage({Key? key, required this.org}) : super(key: key);

  @override
  _DetailedResultsPageState createState() => _DetailedResultsPageState();
}

class _DetailedResultsPageState extends State<DetailedResultsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(screenWidth < 700
              ? "Assets/background_1.jpg"
              : "Assets/web_background_1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: Column(children: [
            const AppBarLogo(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 800,
                child: DetailedResourceCard(
                  org: widget.org,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
