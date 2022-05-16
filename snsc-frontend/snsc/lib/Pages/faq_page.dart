import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/widgets/all_widgets.dart';

import '../Functions_and_Vars/api_services.dart';
import '../models/faq.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  late Future<List<Faq>> faqs;
  List<bool>? _isExpanded;

  Future<List<Faq>> getFaqs() async {
    return await APIService.getFaqs();
  }

  void expandList(int length) {
    // check if _isExpanded is initialized
    _isExpanded ??= List.filled(length, false);
  }

  @override
  void initState() {
    super.initState();
    faqs = getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var futureBuilder = FutureBuilder(
      future: faqs,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget child;
        if (snapshot.connectionState == ConnectionState.none) {
          child = const Center(child: Text('No Connection'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          child = const Center(
              child: SpinKitFadingCube(
            color: Pallete.buttondarkBlue,
            size: 50.0,
          ));
        } else {
          if (snapshot.hasData) {
            expandList(snapshot.data.length);

            child = ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionPanelList(
                    animationDuration: const Duration(milliseconds: 500),
                    expandedHeaderPadding: const EdgeInsets.only(bottom: 0.0),
                    elevation: 1,
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              snapshot.data[index].question,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        body: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data[index].answer,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        isExpanded: _isExpanded![index],
                        canTapOnHeader: true,
                      )
                    ],
                    expansionCallback: (int item, bool status) {
                      setState(() {
                        _isExpanded![index] = !status;
                      });
                    },
                  ),
                );
              },
            );
          } else {
            child = Center(child: Text('Error: ${snapshot.error}'));
          }
        }

        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500), child: child);
      },
    );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(screenWidth < 700
              ? "Assets/background_2.jpg"
              : "Assets/web_background_2.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(children: [
              const AppBarReturn(returnPage: LandingPage(), popContext: false),
              SizedBox(
                height: 70,
                child: Image.asset('Assets/high_res_SNSC_logo.png'),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeedbackPage()),
                        );
                      },
                      child: const Text(
                        "Feedback",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Pallete.buttonGrey,
                            fontSize: 24),
                      ),
                    ),
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.green,
                          width: 4,
                        ))),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FaqPage()),
                            );
                          },
                          child: const Text(
                            "FAQ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 63, 67, 68),
                                fontSize: 24),
                          ),
                        ))
                  ]),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 560,
                width: 450,
                child: SingleChildScrollView(
                  reverse: true,
                  child: futureBuilder,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
