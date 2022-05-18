import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snsc/Functions_and_Vars/api_services.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/models/organization.dart';
import 'package:snsc/widgets/all_widgets.dart';

final bucketGlobal = PageStorageBucket();

class ResultsPage extends StatefulWidget {
  const ResultsPage(
      {Key? key,
      this.searchText,
      this.disabilities,
      this.services,
      this.states,
      this.insurances,
      this.fee,
      this.age})
      : super(key: key);

  final String? searchText;
  final List<String>? disabilities;
  final List<String>? services;
  final List<String>? states;
  final List<String>? insurances;
  final String? fee;
  final String? age;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  String currSortOrder = "Sort A-Z";
  late int numResults = 0;
  late Future<List<Organization>> entries;

  Future<List<Organization>> searchByText() async {
    if (widget.searchText == " ") {
      return await APIService.getAllOrganizations();
    } else {
      return await APIService.searchByText(widget.searchText!);
    }
  }

  Future<List<Organization>> searchByFilter() async {
    return await APIService.searchByFilter(
        disabilities: widget.disabilities,
        services: widget.services,
        states: widget.states,
        insurances: widget.insurances,
        fee: widget.fee,
        age: widget.age);
  }

  refresh() {
    if (widget.searchText != null) {
      setState(() {
        entries = searchByText();
      });
    } else {
      setState(() {
        entries = searchByFilter();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.searchText != null) {
      entries = searchByText();
    } else {
      entries = searchByFilter();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    var futureBuilder = FutureBuilder(
      future: entries,
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
            numResults = snapshot.data.length;
            if (numResults == 0) {
              child = Center(child: Image.asset("Assets/no_results_found.png"));
            } else {
              child = Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60, bottom: 5),
                    child: SizedBox(
                      width: 400,
                      child: Text("$numResults results found ",
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        key: const PageStorageKey<String>('results_page'),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(8),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 400,
                            child: ResourceCard(
                              org: snapshot.data[index],
                              reloadAllPages: refresh,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Disability Resources",
                  style: TextStyle(
                      color: Pallete.buttonGreen,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            Wrap(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedRectangleButton(
                    width: 120,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Edit Search",
                    buttoncolor: Pallete.buttonGreen,
                    height: 40),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Pallete.buttonGreen,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.sort, color: Colors.white),
                        const SizedBox(width: 5),
                        DropdownButton(
                          dropdownColor: Pallete.buttonGreen,
                          value: currSortOrder,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 25,
                          iconEnabledColor: Colors.white,
                          elevation: 8,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          underline: Container(
                            height: 2,
                            color: Pallete.buttonGreen,
                          ),
                          onChanged: (String? newSortOrder) {
                            setState(() {
                              currSortOrder = newSortOrder!;
                              refresh();
                            });
                          },
                          items: ['Sort A-Z', 'Sort Z-A'].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ]),
                ),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: SizedBox(
                    width: 600,
                    child: PageStorage(
                        bucket: bucketGlobal, child: futureBuilder))),
          ]),
        ),
      ),
    );
  }
}
