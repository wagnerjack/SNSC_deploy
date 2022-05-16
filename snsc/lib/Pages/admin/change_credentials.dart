import 'package:flutter/material.dart';
import 'package:snsc/Functions_and_Vars/api_services.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/models/user.dart';
import 'package:snsc/widgets/all_widgets.dart';
import 'package:snsc/Pages/all_pages.dart';
import '/Functions_and_Vars/all_fvc.dart';

class ChangeCredentials extends StatefulWidget {
  const ChangeCredentials({Key? key}) : super(key: key);

  @override
  State<ChangeCredentials> createState() => _ChangeCredentialsState();
}

class _ChangeCredentialsState extends State<ChangeCredentials> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  validateSignup() async {
    if (_formKey.currentState!.validate()) {
      var response = await APIService.signup(
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
    Size size = MediaQuery.of(context).size;
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'Assets/high_res_SNSC_logo.png',
                      width: 100,
                      height: 80,
                    ),
                    const SizedBox(
                      width: 180,
                    ),
                    CircleButton(
                        icon: Icons.home,
                        iconSize: 40,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminLandingPage()),
                          );
                        }, color: Pallete.buttonGreen,)
                  ],
                ),
              ),
              // const Spacer(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "ADMIN CREDENTIALS",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                    color: Pallete.buttonGreen),
              ),
              // const Spacer(),
              const SizedBox(
                height: 50,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RoundedInputField(
                        hintText: "Old Password",
                        icon: Icons.password,
                        onChanged: (value) {},
                        controller: passwordController,
                        validator: Validators.passwordValidator,
                        obscure: false, inputType: TextInputType.visiblePassword,
                      ),
                      RoundedInputField(
                        hintText: "New Password",
                        icon: Icons.lock,
                        onChanged: (value) {},
                        controller: passwordController,
                        validator: Validators.passwordValidator,
                        obscure: false, inputType: TextInputType.visiblePassword,
                      ),
                      RoundedInputField(
                        hintText: "Enter Password Again",
                        icon: Icons.lock,
                        onChanged: (value) {},
                        controller: passwordController,
                        validator: Validators.passwordValidator,
                        obscure: false, inputType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RoundedRectangleButton(
                        width: 0.8 * size.width,
                        onPressed: validateSignup,
                        text: "Update Password",
                        buttoncolor: Pallete.buttonBlue,
                        height: 50,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
