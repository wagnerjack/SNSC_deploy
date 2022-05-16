import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snsc/Functions_and_Vars/api_services.dart';
import 'package:snsc/Pages/detailed_results_page.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/models/organization.dart';
import 'package:snsc/models/user.dart';
import 'package:snsc/widgets/action_button.dart';
import 'package:snsc/widgets/all_widgets.dart';
import 'package:like_button/like_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceCard extends StatefulWidget {
  final Organization org;
  final Function()? reloadFavoritesPage;
  final Function()? reloadAllPages;
  const ResourceCard(
      {Key? key,
      required this.org,
      this.reloadFavoritesPage,
      this.reloadAllPages})
      : super(key: key);

  @override
  _ResourceCardState createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard> {
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

                if (widget.reloadFavoritesPage == null) {
                  return !isLiked;
                } else {
                  widget.reloadFavoritesPage!();
                }
                return null;
              },
            );
          } else {
            // user is not logged in so remove the heart
            child = Container();
          }
        }

        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500), child: child);
      },
    );

    return SizedBox(
      child: Card(
          color: Pallete.cardBackground,
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            splashColor: Colors.green.withAlpha(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailedResultsPage(
                          org: widget.org,
                        )),
              ).then((value) {
                // reload all pages after exiting the detailed resource card
                widget.reloadAllPages!();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('Assets/stock_resource_image.jpeg'),
                      ),
                      RoundedRectangleButton(
                          width: 120,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailedResultsPage(
                                        org: widget.org,
                                      )),
                            ).then((value) {
                              widget.reloadAllPages!();
                            });
                          },
                          text: "More Info",
                          buttoncolor: Pallete.buttonGreen,
                          height: 40)
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        height: 60,
                        child: AutoSizeText('${widget.org.name}',
                            maxLines: 3,
                            style: const TextStyle(
                                color: Pallete.buttonGreen,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          widget.org.primaryEmail != ""
                              ? ActionButton(
                                  icon: Icons.email,
                                  labelText: "Email",
                                  onPressed: () => setState(() {
                                        _launched = _sendEmail(
                                            widget.org.primaryEmail as String);
                                      }))
                              : const SizedBox(),
                          widget.org.primaryWebsite != ""
                              ? ActionButton(
                                  icon: Icons.web_outlined,
                                  labelText: "Website",
                                  onPressed: () => setState(() {
                                        _launched = _launchInBrowser(
                                            widget.org.primaryWebsite as String);
                                      }))
                              : const SizedBox(),
                        ],
                      ),
                      Row(
                        children: [
                          widget.org.primaryPhoneNumber != "" &&
                                  widget.org.primaryPhoneNumber != "Multiple"
                              ? ActionButton(
                                  icon: Icons.phone,
                                  labelText: "Phone",
                                  onPressed: () => setState(() {
                                        _launched = _makePhoneCall(widget
                                            .org.primaryPhoneNumber as String);
                                      }))
                              : const SizedBox(
                                  width: 100,
                                ),
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(child: futureBuilder),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
