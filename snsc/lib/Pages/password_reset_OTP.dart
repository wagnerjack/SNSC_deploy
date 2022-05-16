import 'package:flutter/material.dart';
import 'package:snsc/Pages/password_reset_new.dart';
import '../Functions_and_Vars/functions.dart';
import '../config/pallete.dart';
import '../widgets/all_widgets.dart';
import 'all_pages.dart';

class PasswordResetOTP extends StatefulWidget {
  final String email;
  const PasswordResetOTP({Key? key, required this.email}) : super(key: key);

  @override
  State<PasswordResetOTP> createState() => _PasswordResetOTPState();
}

class _PasswordResetOTPState extends State<PasswordResetOTP> {
  TextEditingController OTP1 = TextEditingController();
  TextEditingController OTP2 = TextEditingController();
  TextEditingController OTP3 = TextEditingController();
  TextEditingController OTP4 = TextEditingController();

  validateOTP() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PasswordResetNew()),
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
                        "VERIFICATION",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                        "Enter the One Time Pin (OTP) sent to ${widget.email}",
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      children: [
                        OTPTextField(first: true, last: false, pinController: OTP1,),
                        OTPTextField(first: false, last: false, pinController: OTP2,),
                        OTPTextField(first: false, last: false, pinController: OTP3,),
                        OTPTextField(first: false, last: true, pinController: OTP4,),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RoundedRectangleButton(
                        width: 400,
                        onPressed: validateOTP,
                        text: "Verify",
                        buttoncolor: Pallete.buttonBlue,
                        height: 50,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Did not recieve the pin? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Resend New Code",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    )
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
