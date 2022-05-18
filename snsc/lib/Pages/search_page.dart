import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snsc/Functions_and_Vars/all_fvc.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/widgets/all_widgets.dart';
import 'package:snsc/widgets/filter_button_dropdown.dart';
import 'package:snsc/widgets/filter_button_number.dart';

import '../Functions_and_Vars/api_services.dart';
import '../models/filter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.userLoggedIn}) : super(key: key);

  final bool userLoggedIn;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchText = TextEditingController();
  late Future<List<Filter>> disabilityFilters;
  late Future<List<Filter>> serviceFilters;
  late Future<List<Filter>> stateFilters;
  late Future<List<Filter>> insuranceFilters;

  late List<String> disabilitesChosen;
  late List<String> servicesChosen;
  late List<String> statesChosen;
  late List<String> insurancesChosen;

  late List<Filter> previousDisChosen;
  late List<Filter> previousServChosen;
  late List<Filter> previousStateChosen;
  late List<Filter> previousInsurChosen;

  late String? fee;
  late String? age;

  late String? prevFee;
  late String? prevAge;

  Future<List<Filter>> getDisabilityFilters() async {
    return await APIService.getDisabilityFilters();
  }

  Future<List<Filter>> getServiceFilters() async {
    return await APIService.getServiceFilters();
  }

  Future<List<Filter>> getStateFilters() async {
    return await APIService.getStateFilters();
  }

  Future<List<Filter>> getInsuranceFilters() async {
    return await APIService.getInsuranceFilters();
  }

  setDisabilties(List<String> data, List<Filter> prev) {
    setState(() {
      disabilitesChosen = data;
      previousDisChosen = prev;
    });
  }

  setServices(List<String> data, List<Filter> prev) {
    setState(() {
      servicesChosen = data;
      previousServChosen = prev;
    });
  }

  setStates(List<String> data, List<Filter> prev) {
    setState(() {
      statesChosen = data;
      previousStateChosen = prev;
    });
  }

  setInsurance(List<String> data, List<Filter> prev) {
    setState(() {
      insurancesChosen = data;
      previousInsurChosen = prev;
    });
  }

  setFee(String data) {
    setState(() {
      fee = data;
      prevFee = data;
    });
  }

  setAge(String data) {
    setState(() {
      age = data;
      prevAge = data;
    });
  }

  @override
  void initState() {
    super.initState();
    disabilitesChosen = [];
    servicesChosen = [];
    statesChosen = [];
    insurancesChosen = [];

    previousDisChosen = [];
    previousServChosen = [];
    previousStateChosen = [];
    previousInsurChosen = [];

    fee = "";
    age = "";

    prevFee = "NO";
    prevAge = "0";

    disabilityFilters = getDisabilityFilters();
    serviceFilters = getServiceFilters();
    stateFilters = getStateFilters();
    insuranceFilters = getInsuranceFilters();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var futureBuilder = FutureBuilder(
      future: Future.wait(
          [disabilityFilters, serviceFilters, stateFilters, insuranceFilters]),
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
            child = Column(
              children: [
                Wrap(
                  runSpacing: 15,
                  alignment: WrapAlignment.center,
                  children: [
                    FilterButtonBottomSheet(
                        name: "Area Of Disability",
                        objects: snapshot.data[0],
                        setFilter: setDisabilties,
                        previouslySelected: previousDisChosen),
                    FilterButtonBottomSheet(
                        name: "Service Provided",
                        objects: snapshot.data[1],
                        setFilter: setServices,
                        previouslySelected: previousServChosen),
                    FilterButtonBottomSheet(
                        name: "State Served",
                        objects: snapshot.data[2],
                        setFilter: setStates,
                        previouslySelected: previousStateChosen),
                    FilterButtonBottomSheet(
                        name: "Insurance",
                        objects: snapshot.data[3],
                        setFilter: setInsurance,
                        previouslySelected: previousInsurChosen),
                    FilterButtonDropdown(
                        items: const [],
                        querryText: "Service Fee",
                        setFilter: setFee,
                        prevSelected: prevFee),
                    FilterButtonNumber(
                        querryText: "Age",
                        setFilter: setAge,
                        prevSelected: prevAge),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedRectangleButton(
                        width: 120,
                        onPressed: () {
                          setState(() {
                            disabilitesChosen = [];
                            servicesChosen = [];
                            statesChosen = [];
                            insurancesChosen = [];

                            previousDisChosen = [];
                            previousServChosen = [];
                            previousStateChosen = [];
                            previousInsurChosen = [];

                            fee = "";
                            age = "";

                            prevFee = "NO";
                            prevAge = "0";
                          });
                        },
                        text: "Clear Filters",
                        buttoncolor: Pallete.buttonGreen,
                        height: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedRectangleButton(
                        width: 200,
                        onPressed: () {
                          if (age == "0") {
                            age = "-1";
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsPage(
                                    disabilities: disabilitesChosen,
                                    services: servicesChosen,
                                    states: statesChosen,
                                    insurances: insurancesChosen,
                                    fee: fee,
                                    age: age)),
                          );
                        },
                        text: "SEARCH",
                        buttoncolor: Pallete.buttonGreen,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ],
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
              ? "Assets/background_1.jpg"
              : "Assets/web_background_1.jpg"),
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
              const AppBarLogo(),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 5.0),
                child: SizedBox(
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 300,
                          decoration: const BoxDecoration(),
                          child: TextField(
                            controller: searchText,
                            maxLines: 2,
                            minLines: 1,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Search Organization Name'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleButton(
                        icon: Icons.search,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsPage(
                                      searchText: searchText.text.isEmpty
                                          ? " "
                                          : searchText.text,
                                    )),
                          );
                        },
                        color: Pallete.buttonGreen,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: SizedBox(
                  width: 400,
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "   or  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                "Search Using Filters",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: widget.userLoggedIn ? 490 : 660,
                child: SingleChildScrollView(child: futureBuilder),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
