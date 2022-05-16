import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:snsc/Functions_and_Vars/api_services.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/widgets/all_widgets.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/widgets/rounded_input_field.dart';
import '../Functions_and_Vars/all_fvc.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
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
        await APIService.updatePassword(
            oldPasswordController.text, newPasswordController2.text, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          child: Column(
            children: [
              const AppBarReturn(
                returnPage: LandingPage(),
                popContext: true,
              ),
              SizedBox(
                height: 200,
                child: Image.asset('Assets/high_res_SNSC_logo.png'),
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
                        controller: oldPasswordController,
                        validator: Validators.passwordValidator,
                        obscure: true,
                        inputType: TextInputType.visiblePassword,
                      ),
                      RoundedInputField(
                        hintText: "New Password",
                        icon: Icons.lock,
                        onChanged: (value) {},
                        controller: newPasswordController1,
                        obscure: true,
                        inputType: TextInputType.visiblePassword,
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
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedRectangleButton(
                          width: 400,
                          onPressed: updatePassword,
                          text: "Update Password",
                          buttoncolor: Pallete.buttonBlue,
                          height: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
