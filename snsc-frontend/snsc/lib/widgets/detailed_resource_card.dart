import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snsc/Functions_and_Vars/api_services.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/models/organization.dart';
import 'package:like_button/like_button.dart';
import 'package:snsc/widgets/action_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user.dart';

class DetailedResourceCard extends StatefulWidget {
  final Organization org;
  const DetailedResourceCard({Key? key, required this.org}) : super(key: key);

  @override
  _DetailedResourceCardState createState() => _DetailedResourceCardState();
}

class _DetailedResourceCardState extends State<DetailedResourceCard> {
  late Future<User> user;
  Future<void>? _launched;

  Future<User> getUser() async {
    return await APIService.getUserInfo();
  }

  // action button functions
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  static _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launch(launchUri.toString());
  }

  static Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    user = getUser();
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: user,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget child;
        if (snapshot.connectionState == ConnectionState.none) {
          child = const Center(child: Text('No Connection'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          child = const Center(
              child: SpinKitRing(
            color: Pallete.buttondarkBlue,
            size: 50.0,
          ));
        } else {
          if (snapshot.hasData) {
            bool isLiked = snapshot.data.favoriteIds.contains(widget.org.id);
            child = LikeButton(
              isLiked: isLiked,
              onTap: (isLiked) async {
                if (isLiked) {
                  await APIService.removeToFavorites(widget.org.id!);
                } else {
                  await APIService.saveToFavorites(widget.org.id!);
                }
                return !isLiked;
              },
            );
          } else {
            child = Container();
          }
        }

        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500), child: child);
      },
    );

    return Card(
        color: Pallete.cardBackground,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          splashColor: Colors.green.withAlpha(30),
          onTap: () {},
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        color: Pallete.cardBackground,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                        iconSize: 40,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: AutoSizeText('${widget.org.name}',
                            style: const TextStyle(
                                color: Pallete.buttonGreen,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('Assets/stock_resource_image.jpeg'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              widget.org.primaryEmail != ""
                                  ? ActionButton(
                                      icon: Icons.email,
                                      labelText: "Email",
                                      onPressed: () => setState(() {
                                            _launched = _sendEmail(widget
                                                .org.primaryEmail as String);
                                          }))
                                  : const SizedBox(),
                              widget.org.primaryWebsite != ""
                                  ? ActionButton(
                                      icon: Icons.web_outlined,
                                      labelText: "Website",
                                      onPressed: () => setState(() {
                                            _launched = _launchInBrowser(widget
                                                .org.primaryWebsite as String);
                                          }))
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            widget.org.primaryPhoneNumber != "" &&
                                    widget.org.primaryPhoneNumber != "Multiple"
                                ? ActionButton(
                                    icon: Icons.phone,
                                    labelText: "Phone",
                                    onPressed: () => setState(() {
                                          _launched = _makePhoneCall(widget.org
                                              .primaryPhoneNumber as String);
                                        }))
                                : const SizedBox(
                                    width: 100,
                                  ),
                          ])
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 340,
                        height: 410,
                        child: ListView(children: [
                          AutoSizeText.rich(
                            TextSpan(
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                children: [
                                  const TextSpan(
                                      text: "\nSpeciality: ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${widget.org.descriptions}',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  const TextSpan(
                                      text: "\nAges: ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          '${widget.org.agesServed?.lowerRange} to ${widget.org.agesServed?.upperRange}',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  const TextSpan(
                                      text: "\nState Served: ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${widget.org.statesServed}',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  const TextSpan(
                                      text: "\nService Fee? ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${widget.org.fee}',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  const TextSpan(
                                      text: "\nInsurance accepted? ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${widget.org.insurancesAccepted}',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  const TextSpan(
                                      text: "\nType of Service: ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${widget.org.disabilitiesServed}',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  const TextSpan(
                                    text: "\n\n",
                                  ),
                                  const TextSpan(
                                      text: "Contact us: ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  const TextSpan(
                                      text: "\nPoint of Contact: ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${widget.org.primaryContactName}',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  const TextSpan(
                                      text: "\n By Phone: ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${widget.org.fullPhoneNumber}',
                                      style:
                                          const TextStyle(color: Colors.blue)),
                                  const TextSpan(
                                      text: "\n By Email: ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${widget.org.fullEmail}',
                                      style:
                                          const TextStyle(color: Colors.blue)),
                                  const TextSpan(
                                      text: "\n Website: ",
                                      style: TextStyle(
                                          color: Pallete.buttonGreen,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${widget.org.fullWebsite}',
                                      style:
                                          const TextStyle(color: Colors.blue)),
                                ]),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(child: futureBuilder),
                      const SizedBox(
                        width: 240,
                      ),
                      IconButton(
                        color: Pallete.cardBackground,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                onPressed: () {},
                                label: '',
                              ),
                              content: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    "Information not up to date?\nVisit the Feedback page and leave us a message"),
                              ),
                              duration: const Duration(seconds: 4),
                              width: 250, // Width of the SnackBar.
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
                        icon: const Icon(
                          Icons.info,
                          color: Colors.grey,
                        ),
                        iconSize: 30,
                      ),
                    ],
                  )
                ],
              )),
        ));
  }
}
