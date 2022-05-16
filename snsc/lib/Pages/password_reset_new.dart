import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:snsc/Pages/all_pages.dart';
import '../Functions_and_Vars/api_services.dart';
import '../Functions_and_Vars/functions.dart';
import '../config/pallete.dart';
import '../widgets/all_widgets.dart';

class PasswordResetNew extends StatefulWidget {
  const PasswordResetNew({Key? key}) : super(key: key);

  @override
  State<PasswordResetNew> createState() => _PasswordResetNewState();
}

class _PasswordResetNewState extends State<PasswordResetNew> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController1 = TextEditingController();
  TextEditingController newPasswordController2 = TextEditingController();

  bool validPasword = false;

  updatePassword() async {
    if (_formKey.currentState!.validate() && validPasword) {
      if (newPasswordController1.text != newPasswordController2.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New passwords do not match')),
        );
      } else {
        // await APIService.updatePassword(
        //     oldPasswordController.text, newPasswordController2.text, context);
      }
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
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                const AppBarReturn(
                  returnPage: LandingPage(),
                  popContext: true,
                ),
                SizedBox(
                  height: 150,
                  width: 550,
                  child: Image.asset('Assets/high_res_SNSC_logo.png'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "PASSWORD RESET",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                        "Enter new password. You will be required to log in once you set the new password",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RoundedInputField(
                              hintText: "New Password",
                              icon: Icons.lock,
                              onChanged: (value) {},
                              controller: newPasswordController1,
                              obscure: true,
                              inputType: TextInputType.visiblePassword,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: FlutterPwValidator(
                                  width: 300,
                                  height: 80,
                                  minLength: 8,
                                  numericCharCount: 1,
                                  uppercaseCharCount: 1,
                                  onSuccess: () {
                                    setState(() {
                                      validPasword = true;
                                    });
                                  },
                                  onFail: () {
                                    setState(() {
                                      validPasword = false;
                                    });
                                  },
                                  controller: newPasswordController1),
                            ),
                            RoundedInputField(
                              hintText: "Enter Password Again",
                              icon: Icons.lock,
                              onChanged: (value) {},
                              controller: newPasswordController2,
                              validator: Validators.passwordValidator,
                              obscure: true,
                              inputType: TextInputType.visiblePassword,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RoundedRectangleButton(
                                width: 400,
                                onPressed: () {},
                                text: "RESET PASSWORD",
                                buttoncolor: Pallete.buttonBlue,
                                height: 50,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
