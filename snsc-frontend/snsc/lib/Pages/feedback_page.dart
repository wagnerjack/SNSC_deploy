import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/widgets/all_widgets.dart';
import 'dart:io';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int value = 0;
  bool positive = false;
  bool account = false;
  bool suggestion = false;
  bool app = false;
  bool resource = false;
  bool contact = false;
  bool other = false;
  File? image;

  Future pickImage(source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on Exception catch (e) {
      print("failed to pick image: $e");
    }
  }

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
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              reverse:true,
              child: Column(
                children: [
                  const AppBarReturn(
                    returnPage: LandingPage(),
                    popContext: true,
                  ),
                  SizedBox(
                    height: 70,
                    child: Image.asset('Assets/high_res_SNSC_logo.png'),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                                      builder: (context) => const FeedbackPage()),
                                );
                              },
                              child: const Text(
                                "Feedback",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 63, 67, 68),
                                    fontSize: 24),
                              ),
                            )),
                        TextButton(
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
                                color: Pallete.buttonGrey,
                                fontSize: 24),
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Please select the type of feedback",
                      style: TextStyle(
                          color: Color.fromARGB(255, 63, 67, 68),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 110,
                          width: 300,
                          child: GridView.count(
                              scrollDirection: Axis.vertical,
                              crossAxisCount: 3,
                              childAspectRatio: 2 / 1,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              children: [
                                TextButton(
                                  child: const Text('Account'),
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: account
                                          ? Pallete.buttonGreen
                                          : Pallete.buttonGrey),
                                  onPressed: () => {
                                    setState(() {
                                      account = !account;
                                    })
                                  },
                                ),
                                TextButton(
                                  child: const Text('Suggestion'),
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: suggestion
                                          ? Pallete.buttonGreen
                                          : Pallete.buttonGrey),
                                  onPressed: () => {
                                    setState(() {
                                      suggestion = !suggestion;
                                    })
                                  },
                                ),
                                TextButton(
                                  child: const Text('App'),
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: app
                                          ? Pallete.buttonGreen
                                          : Pallete.buttonGrey),
                                  onPressed: () => {
                                    setState(() {
                                      app = !app;
                                    })
                                  },
                                ),
                                TextButton(
                                  child: const Text('Resource'),
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: resource
                                          ? Pallete.buttonGreen
                                          : Pallete.buttonGrey),
                                  onPressed: () => {
                                    setState(() {
                                      resource = !resource;
                                    })
                                  },
                                ),
                                TextButton(
                                  child: const Text('Contact'),
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: contact
                                          ? Pallete.buttonGreen
                                          : Pallete.buttonGrey),
                                  onPressed: () => {
                                    setState(() {
                                      contact = !contact;
                                    })
                                  },
                                ),
                                TextButton(
                                  child: const Text('Other'),
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: other
                                          ? Pallete.buttonGreen
                                          : Pallete.buttonGrey),
                                  onPressed: () => {
                                    setState(() {
                                      other = !other;
                                    })
                                  },
                                ),
                              ]),
                        ),
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                      width: 300,
                      height: 200,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 20,
                        decoration: InputDecoration(
                            hintText:
                                'Enter your feedback and suggestions here. This includes any potential resources we should add to the database and ideas you want to recommend. We look forward to what you have to say, thanks!',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Pallete.buttonGreen),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3, color: Pallete.buttonGreen))),
                        style: TextStyle(
                          fontSize: 14,
                          height: 2,
                          color: Colors.black,
                        ),
                      )),
                  Container(
                    width: 300,
                    height: 50,
                    margin: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Pallete.buttonGreen, width: 3)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Pallete.buttonGreen,
                              border: Border.all(
                                  color: Pallete.buttonGreen, width: 1),
                            ),
                            child: IconButton(
                              color: Colors.white,
                              padding: const EdgeInsets.all(0),
                              icon: const Icon(Icons.add),
                              iconSize: 24,
                              onPressed: () => pickImage(ImageSource.gallery),
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: SizedBox(
                            child: Text(
                                image == null
                                    ? "Upload screenshot (optional)"
                                    : "{$image.path}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 63, 67, 68),
                                  fontSize: 12,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Send Anonymously",
                          style: TextStyle(
                              color: Color.fromARGB(255, 63, 67, 68),
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 90,
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: positive,
                          first: false,
                          second: true,
                          dif: 30.0,
                          borderColor: Colors.transparent,
                          borderWidth: 2.0,
                          height: 25,
                          animationOffset: const Offset(15.0, 0),
                          clipAnimation: true,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (b) => setState(() => positive = b),
                          colorBuilder: (b) =>
                              b ? Pallete.buttonGreen : Colors.red,
                          iconBuilder: (value) => value
                              ? const Icon(Icons.check)
                              : const Icon(Icons.close),
                          textBuilder: (value) => value
                              ? const Center(child: Text('YES'))
                              : const Center(child: Text('NO')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedRectangleButton(
                    width: 200,
                    onPressed: () {},
                    text: "Send Feedback",
                    buttoncolor: Pallete.buttonGreen,
                    height: 50,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
