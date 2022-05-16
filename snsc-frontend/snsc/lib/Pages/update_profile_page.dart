import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snsc/Functions_and_Vars/api_services.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/models/user.dart';
import 'package:snsc/widgets/all_widgets.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/widgets/rounded_input_field.dart';
import '../Functions_and_Vars/all_fvc.dart';
import '../models/filter.dart';
import '../widgets/filter_button_dropdown.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late Future<User> user;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  Future<User> getUser() async {
    return await APIService.getUserInfo();
  }

  updateProfile() async {
    if (_formKey.currentState!.validate()) {
      await APIService.updateUser(
          User(
              name: nameController.text,
              email: emailController.text,
              location: locationController.text,
              dateOfBirth: dateOfBirthController.text),
          context);
    }
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
    Size size = MediaQuery.of(context).size;

    var futureBuilder = FutureBuilder(
      future: user,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget child;
        if (snapshot.connectionState == ConnectionState.none) {
          child = const Center(child: Text('No Connection'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          child = const Center(
              child: SpinKitFadingCube(
            color: Pallete.buttondarkBlue,
            size: 50.0,
          ));
        } else {
          if (snapshot.hasData) {
            nameController.text = snapshot.data.name;
            emailController.text = snapshot.data.email;
            locationController.text = snapshot.data.location;
            dateOfBirthController.text = snapshot.data.dateOfBirth;

            child = Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    children: [
                      RoundedInputField(
                        hintText: "Name",
                        icon: Icons.account_circle_outlined,
                        onChanged: (value) {},
                        controller: nameController,
                        validator: Validators.otherValidator,
                        obscure: false,
                        inputType: TextInputType.name,
                      ),
                      RoundedInputField(
                        hintText: "Email Address",
                        icon: Icons.email,
                        onChanged: (value) {},
                        controller: emailController,
                        validator: Validators.emailValidator,
                        obscure: false,
                        inputType: TextInputType.emailAddress,
                      ),
                      RoundedInputField(
                        hintText: "City/Town, State ",
                        icon: Icons.location_city,
                        onChanged: (value) {},
                        controller: locationController,
                        validator: Validators.otherValidator,
                        obscure: false,
                        inputType: TextInputType.streetAddress,
                      ),
                      RoundedInputField(
                        hintText: "Age",
                        icon: Icons.numbers,
                        onChanged: (value) {},
                        controller: dateOfBirthController,
                        validator: Validators.ageValidator,
                        obscure: false,
                        inputType: TextInputType.number,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 5.0, bottom: 5.0),
                    child: RoundedRectangleButton(
                      width: 200,
                      onPressed: () async {
                        await updateProfile();
                      },
                      text: "Update Profile",
                      buttoncolor: Pallete.buttonBlue,
                      height: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          } else {
            child = Center(child: Text('Error: ${snapshot.error}'));
          }
        }
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500), child: child);
      },
    );

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(screenWidth < 700
                ? "Assets/background_1.jpg"
                : "Assets/web_background_1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  const AppBarReturn(
                    returnPage: AccountPage(),
                    popContext: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("Update Profile",
                          style: TextStyle(
                              color: Pallete.buttonGreen,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  futureBuilder,
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
