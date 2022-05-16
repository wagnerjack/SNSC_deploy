import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:snsc/Functions_and_Vars/api_services.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/models/user.dart';
import 'package:snsc/widgets/all_widgets.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/widgets/rounded_input_field.dart';

import '../Functions_and_Vars/all_fvc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool validPasword = false;

  validateSignup() async {
    if (_formKey.currentState!.validate() && validPasword) {
      await APIService.signup(
          User(
              email: emailController.text,
              password: passwordController.text,
              name: nameController.text),
          context);
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
                  popContext: false,
                ),
                SizedBox(
                  height: 150,
                  width: 550,
                  child: Image.asset('Assets/high_res_SNSC_logo.png'),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RoundedInputField(
                          hintText: "Name",
                          icon: Icons.account_circle_outlined,
                          onChanged: (value) {},
                          controller: nameController,
                          validator: Validators.otherValidator,
                          obscure: false, inputType: TextInputType.name,
                        ),
                        RoundedInputField(
                          hintText: "Email Address",
                          icon: Icons.email,
                          onChanged: (value) {},
                          controller: emailController,
                          validator: Validators.emailValidator,
                          obscure: false, inputType: TextInputType.emailAddress,
                        ),
                        RoundedInputField(
                          hintText: "Password",
                          icon: Icons.lock,
                          onChanged: (value) {},
                          controller: passwordController,
                          obscure: true, inputType: TextInputType.visiblePassword,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                              controller: passwordController),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RoundedRectangleButton(
                            width: 400,
                            onPressed: validateSignup,
                            text: "Sign up",
                            buttoncolor: Pallete.buttonBlue,
                            height: 50,
                          ),
                        ),
                        const TextAndLink(
                            text1: "Already have an account?",
                            text2: "Log In",
                            navigateTo: LoginPage()),
                      ],
                    )),
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
