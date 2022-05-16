import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:snsc/Functions_and_Vars/api_services.dart';
import 'package:snsc/Pages/feedback_page.dart';
import 'package:snsc/Pages/profile_page.dart';
import 'package:snsc/Pages/update_password_page.dart';
import 'package:snsc/Pages/update_profile_page.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/models/user.dart';
import '../widgets/all_widgets.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final LocalAuthentication auth = LocalAuthentication();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  late Future<User> user;

  Future<User> getUser() async {
    return await APIService.getUserInfo();
  }

  @override
  void initState() {
    super.initState();
    user = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/background_1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            const AppBarLogo(),
            FutureBuilder(
              future: user,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Widget child;
                if (snapshot.hasData) {
                  child = Column(
                    children: [
                      Text("Hi, ${snapshot.data.name}",
                          style: const TextStyle(
                              color: Pallete.buttonGreen,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      Text('${snapshot.data.email}',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ],
                  );
                } else {
                  child = Container();
                }
                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500), child: child);
              },
            ),
            Wrap(
              children: [
                ProfileButton(
                  text: "My Profile",
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                ProfileButton(
                  text: "Update Profile",
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateProfilePage()),
                    );
                  },
                ),
                ProfileButton(
                  text: "Update Password",
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdatePasswordPage()),
                    );
                  },
                ),
                ProfileButton(
                  text: "Feedback and FAQ",
                  icon: const Icon(
                    Icons.feedback_outlined,
                    color: Colors.white,
                  ),
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedbackPage()),
                    );
                  },
                ),
                ProfileButton(
                    text: "Disable Face Id/ Touch Id",
                    icon: const Icon(
                      Icons.fingerprint,
                      color: Colors.white,
                    ),
                    press: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Disable Face/Touch ID? ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0)),
                              content: const Text(
                                  "You will be required to sign out to re-enable biometric Login ",
                                  style: TextStyle(fontSize: 16.0)),
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Pallete.buttonGreen,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "No",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Pallete.buttonGreen,
                                    ),
                                    onPressed: () {
                                      storage.deleteAll();
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ],
                            );
                          });
                    }),
              ],
            ),
            Wrap(
              children: const [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: DonateButton(
                    text: "DONATE",
                    icon: Icon(Icons.volunteer_activism_outlined),
                    url:
                        'https://pages.donately.com/specialneedssupportcenter/campaigns',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: DonateButton(
                    text: "SPONSOR",
                    icon: Icon(Icons.favorite),
                    url: 'https://snsc-uv.org/sponsor/',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: DonateButton(
                    text: "VOLUNTEER",
                    icon: Icon(Icons.group),
                    url: 'https://snsc-uv.org/volunteer/',
                  ),
                )
              ],
            ),
            ProfileButton(
              text: "Log Out",
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              press: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Log out of SNSC?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0)),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Pallete.buttonGreen,
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Pallete.buttonGreen,
                              ),
                              onPressed: () {
                                APIService.logout(context);
                              },
                              child: const Text(
                                "Log Out",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ))
                        ],
                      );
                    });
              },
            ),
          ]),
        ),
      ),
    );
  }
}
