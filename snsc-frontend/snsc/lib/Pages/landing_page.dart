import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/widgets/all_widgets.dart';
import 'package:snsc/config/pallete.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

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
                Align(
                  alignment: Alignment.centerRight,
                  child: CircleButton(
                      icon: Icons.settings_accessibility,
                      iconSize: 40,
                      color: Pallete.buttondarkBlue,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AccesibilityWidget();
                            });
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage('Assets/high_res_SNSC_logo.png'),
                    width: 500,
                    height: 250,
                  ),
                ),
                const Spacer(),
                RoundedRectangleButton(
                  width: 290,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage(
                                userLoggedIn: false,
                              )),
                    );
                  },
                  text: "Search Resources",
                  buttoncolor: Pallete.buttonGreen,
                  height: 50,
                ),
                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      const Text(
                        "MAKE A DIFFERENCE: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Pallete.buttonBlue,
                            fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 120,
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            RotateAnimatedText('DONATE',
                                transitionHeight: 20.0,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Pallete.buttonGreen)),
                            RotateAnimatedText('SPONSOR',
                                transitionHeight: 20.0,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Pallete.buttonGreen)),
                            RotateAnimatedText('VOLUNTEER',
                                transitionHeight: 20.0,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Pallete.buttonGreen)),
                          ],
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
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
                const Spacer(flex: 2),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    children: [
                      IconButton(
                        color: Colors.blue,
                        iconSize: 28.0,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                onPressed: () {},
                                label: '',
                              ),
                              content: const Text(
                                  "Sign up or Log in to save your favorites and settings between devices"),
                              duration: const Duration(seconds: 4),
                              width:
                                  screenWidth * 0.72, // Width of the SnackBar.
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.info),
                      ),
                      const SizedBox(width: 190)
                    ],
                  ),
                ),
                Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedRectangleButton(
                        width: 120,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        text: "Log in",
                        buttoncolor: Pallete.buttonBlue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedRectangleButton(
                        width: 120,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()),
                          );
                        },
                        text: "Sign up",
                        buttoncolor: Pallete.buttonBlue,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Wrap(children: const [
                  TextAndLink(
                      text1: "",
                      text2: "Give Feedback or view FAQ",
                      navigateTo: FeedbackPage()),
                ]),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
