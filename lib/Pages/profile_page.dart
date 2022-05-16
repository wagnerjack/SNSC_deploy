import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snsc/Functions_and_Vars/api_services.dart';
import 'package:snsc/Pages/account_page.dart';
import 'package:snsc/models/user.dart';
import 'package:snsc/widgets/all_widgets.dart';

import '../config/pallete.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
              child: Column(children: [
                const AppBarReturn(returnPage: AccountPage(), popContext: true),
                SizedBox(
                  height: 70,
                  child: Image.asset('Assets/high_res_SNSC_logo.png'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text("My Profile",
                        style: TextStyle(
                            color: Pallete.buttonGreen,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                FutureBuilder(
                  future: user,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    Widget child;
                    if (snapshot.hasData) {
                      child = SizedBox(
                        height: 650,
                        width: 350,
                        child: ListView(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            ProfileText(
                                tittle: "Name",
                                content: "${snapshot.data.name}"),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 86.0,
                              ),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            ProfileText(
                                tittle: "Email",
                                content: "${snapshot.data.email}"),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 86.0,
                              ),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            ProfileText(
                                tittle: "Age",
                                content: "${snapshot.data.dateOfBirth}"),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 86.0,
                              ),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            ProfileText(
                                tittle: "Location",
                                content: "${snapshot.data.location}"),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 86.0,
                              ),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            ProfileText(
                                tittle: "Disability",
                                content: "${snapshot.data.disability}"),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 86.0,
                              ),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            ProfileText(
                                tittle: "Insurance",
                                content: "${snapshot.data.insurance}"),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      child = Container();
                    }
                    return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: child);
                  },
                ),
              ]),
            )),
      ),
    );
  }
}
