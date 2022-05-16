import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snsc/Functions_and_Vars/api_services.dart';
import 'package:snsc/config/pallete.dart';
import 'package:snsc/models/organization.dart';
import 'package:snsc/widgets/all_widgets.dart';

final bucketGlobal = PageStorageBucket();

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Organization>> entries;

  Future<List<Organization>> getOrganizations() async {
    return await APIService.getAllFavorites();
  }

  refresh() {
    setState(() {
      entries = getOrganizations();
    });
  }

  @override
  void initState() {
    super.initState();
    entries = getOrganizations();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var futureBuilder = FutureBuilder(
      future: entries,
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
            if (snapshot.data.length == 0) {
              child = Center(
                  child: Column(
                children: [
                  Image.asset("Assets/no_favorites.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      "Favorite resources and have them appear here for easier access!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  )
                ],
              ));
            } else {
              child = SizedBox(
                width: 400,
                child: ListView.builder(
                    key: const PageStorageKey<String>('favorites_page'),
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ResourceCard(
                        org: snapshot.data[index],
                        reloadFavoritesPage: refresh,
                        reloadAllPages: refresh,
                      );
                    }),
              );
            }
          } else {
            child = Container();
          }
        }
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500), child: child);
      },
    );

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
          child: Column(children: [
            const AppBarLogo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("FAVORITES",
                    style: TextStyle(
                        color: Pallete.buttonGreen,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: PageStorage(bucket: bucketGlobal, child: futureBuilder),
            )
          ]),
        ),
      ),
    );
  }
}
