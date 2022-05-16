import 'package:flutter/material.dart';
import 'package:snsc/Pages/admin/add_resource.dart';
import 'package:snsc/Pages/admin/change_credentials.dart';
import 'package:snsc/Pages/admin/edit_faqs.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/widgets/all_widgets.dart';

import '../../Functions_and_Vars/api_services.dart';

class AdminLandingPage extends StatefulWidget {
  const AdminLandingPage({Key? key}) : super(key: key);

  @override
  State<AdminLandingPage> createState() => _AdminLandingPageState();
}

class _AdminLandingPageState extends State<AdminLandingPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: screenHeight),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'Assets/high_res_SNSC_logo.png',
                      width: 200,
                      height: 100,
                    ),
                  ),
                  const Text(
                    "ADMIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                        color: Pallete.buttonGreen),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: [
                      ProfileButton(
                        text: "ADD A NEW RESOURCE",
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddResource()),
                          );
                        },
                      ),
                      ProfileButton(
                        text: "EDIT/DELETE A CURRENT RESOURCE",
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UpdatePasswordPage()),
                          );
                        },
                      ),
                      ProfileButton(
                        text: "ADD/EDIT/DELETE FAQ",
                        icon: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditFAQ()),
                          );
                        },
                      ),
                      ProfileButton(
                        text: "CHANGE ADMIN CREDENTIALS",
                        icon: const Icon(
                          Icons.password,
                          color: Colors.white,
                        ),
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChangeCredentials()),
                          );
                        },
                      ),
                    ],
                  ),
                  ProfileButton(
                    text: "LOGOUT",
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    press: () {
                      APIService.logout(context);
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
