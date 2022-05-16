import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/widgets/all_widgets.dart';

import '../../Functions_and_Vars/api_services.dart';
import '../../models/faq.dart';

class EditFAQ extends StatefulWidget {
  const EditFAQ({Key? key}) : super(key: key);

  @override
  State<EditFAQ> createState() => _EditFAQState();
}

class _EditFAQState extends State<EditFAQ> {
  late Future<List<Faq>> faqs;
  List<bool>? _isExpanded;

  Future<List<Faq>> getFaqs() async {
    return await APIService.getFaqs();
  }

  deleteFaq(String id) async {
    await APIService.deleteFaq(id);
    setState(() {
      faqs = getFaqs();
    });
  }

  addFaq(Faq faq) async {
    _isExpanded!.add(false);
    await APIService.saveFaq(faq);
    setState(() {
      faqs = getFaqs();
    });
  }

  updateFaq(String id, Faq faq) async {
    await APIService.updateFaq(id, faq);
    setState(() {
      faqs = getFaqs();
    });
  }

  void expandList(int length) {
    // check if _isExpanded is initialized
    _isExpanded ??= List.filled(length, false, growable: true);
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

            child = SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: ExpansionPanelList(
                      animationDuration: const Duration(milliseconds: 500),
                      dividerColor: Colors.red,
                      expandedHeaderPadding: const EdgeInsets.only(bottom: 0.0),
                      elevation: 1,
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: Wrap(
                                children: [
                                  Text(
                                    snapshot.data[index].question,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        _isExpanded!.removeAt(index);
                                        deleteFaq(snapshot.data[index].id);
                                      },
                                      alignment: Alignment.center,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              FaqPopUp(
                                            question:
                                                snapshot.data[index].question,
                                            answer: snapshot.data[index].answer,
                                            tittle: "EDIT FAQ",
                                            faqId: snapshot.data[index].id,
                                            updateFaq: updateFaq,
                                          ),
                                        );
                                      },
                                      alignment: Alignment.center,
                                    ),
                                  ]),
                                ],
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
              ),
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          minimum: const EdgeInsets.all(10.0),
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                height: screenHeight, width: screenWidth),
            child: Column(children: [
              SizedBox(
                width: screenWidth,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'Assets/high_res_SNSC_logo.png',
                        width: 100,
                        height: 80,
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleButton(
                        icon: Icons.home,
                        iconSize: 40,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminLandingPage()),
                          );
                        },
                        color: Pallete.buttonGreen,
                      ),
                    )
                  ],
                ),
              ),
              const Text(
                "Manage FAQs",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.black),
              ),
              // const Spacer(),
              const SizedBox(
                height: 20,
              ),
              RoundedRectangleButton(
                width: 130,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => FaqPopUp(
                      question: "",
                      answer: "",
                      tittle: "ADD FAQ",
                      addFaq: addFaq,
                    ),
                  );
                },
                text: " + Add FAQ",
                buttoncolor: Pallete.buttonGreen,
                height: 35,
              ),
              // const Spacer(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: futureBuilder,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
