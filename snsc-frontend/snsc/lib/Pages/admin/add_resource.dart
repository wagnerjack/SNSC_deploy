import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/widgets/all_widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../all_pages.dart';

class AddResource extends StatefulWidget {
  const AddResource({Key? key}) : super(key: key);

  @override
  State<AddResource> createState() => _AddResourceState();
}

class _AddResourceState extends State<AddResource> {
  File? image;

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController contactPersonName = TextEditingController();
  TextEditingController contactPersonRole = TextEditingController();

  Future pickImage(ImageSource source) async {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          bottom: false,
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Assets/background_1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
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
                        width: 200,
                      ),
                      CircleButton(
                          icon: Icons.home,
                          iconSize: 40,
                          color: Pallete.buttondarkBlue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminLandingPage()),
                            );
                          })
                    ],
                  ),
                ),
                const Text(
                  "ADD NEW RESOURCE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Pallete.buttonGreen),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Pallete.buttonGreen, width: 2),
                      ),
                      child: image != null
                          ? Image.file(
                              image!,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              'Assets/stock_org_picture.jpeg',
                              fit: BoxFit.fill,
                            ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    RoundedRectangleButton(
                        width: 0.5 * size.width,
                        onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Add Resource Image'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context,
                                        pickImage(ImageSource.gallery)),
                                    child: const Text('Choose From Gallery'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        context, pickImage(ImageSource.camera)),
                                    child: const Text('Take Photo'),
                                  ),
                                ],
                              ),
                            ),
                        text: "Add Resource Image",
                        buttoncolor: Pallete.buttonGreen,
                        height: 50)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size.width,
                  height: 450,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OrgInputField(
                            hintText: "Enter the organization name.",
                            labelText: "Organization Name",
                            minLines: 1,
                            controller: name,
                          ),
                          OrgInputField(
                            hintText: "Enter the organization description.",
                            labelText: "Description",
                            minLines: 2,
                            controller: description,
                          ),
                          OrgInputField(
                            hintText:
                                "For example +16031234567. If multiple begin with primary and seperate using comma.",
                            labelText: "Phone Number",
                            minLines: 1,
                            controller: phone,
                          ),
                          OrgInputField(
                            hintText:
                                "For example SNSC@gmail.com. If multiple list all seperate by comma begining with primary email",
                            labelText: "Email Address",
                            minLines: 1,
                            controller: email,
                          ),
                          OrgInputField(
                            hintText:
                                "For example SNSC.org. If multiple list all seperate by comma begining with primary website",
                            labelText: "Website",
                            minLines: 1,
                            controller: website,
                          ),
                          OrgInputField(
                            hintText:
                                "The name of the primary contact person for the organization",
                            labelText: "Primary Contact Name",
                            minLines: 1,
                            controller: contactPersonName,
                          ),
                          OrgInputField(
                            hintText:
                                "The role of the primary contact person for the organization",
                            labelText: "Primary Contact role",
                            minLines: 1,
                            controller: contactPersonRole,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                RoundedRectangleButton(
                    width: size.width * 0.8,
                    onPressed: () {},
                    text: "Create Resource",
                    buttoncolor: Pallete.buttonGreen,
                    height: 50)
              ],
            ),
          )),
    );
  }
}
