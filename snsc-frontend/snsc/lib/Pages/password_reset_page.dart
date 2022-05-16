import 'package:flutter/material.dart';
import '../Functions_and_Vars/functions.dart';
import '../config/pallete.dart';
import '../widgets/all_widgets.dart';
import '../widgets/rounded_input_field.dart';
import 'all_pages.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  TextEditingController emailController = TextEditingController();

  validateEmail() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PasswordResetOTP(email: emailController.text,)),
    );
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
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                        "Enter the Email Address associated with your account.You will receive a one time pin (OTP) to verify your identity and reset your password.",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    RoundedInputField(
                      hintText: "Email Address",
                      icon: Icons.email,
                      onChanged: (value) {},
                      controller: emailController,
                      validator: Validators.emailValidator,
                      obscure: false,
                      inputType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RoundedRectangleButton(
                        width: 400,
                        onPressed: validateEmail,
                        text: "Send Reset Link",
                        buttoncolor: Pallete.buttonBlue,
                        height: 50,
                      ),
                    ),
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
