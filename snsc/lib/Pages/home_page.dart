import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/Pages/favorites_page.dart';
import 'package:snsc/config/pallete.dart';

class HomePage extends StatefulWidget {
  final bool wantsBiometrics;
  final String email;
  final String password;
  const HomePage({Key? key, required this.wantsBiometrics, required this.email, required this.password}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication auth = LocalAuthentication();
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    if (widget.wantsBiometrics) {
      authenticate();
    }
  }

  void authenticate() async {
    final canCheck = await auth.canCheckBiometrics;

    if (canCheck) {
      List availableBiometrics =
          await auth.getAvailableBiometrics();

      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          final authenticated = await auth.authenticate(
              localizedReason: 'Enable Face ID to sign in more easily');
          if (authenticated) {
            storage.write(key: 'email', value: widget.email);
            storage.write(key: 'password', value: widget.password);
            storage.write(key: 'usingBiometric', value: 'true');
          }
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          // Touch ID.
          final authenticated = await auth.authenticate(
              localizedReason: 'Enable Touch ID to sign in more easily');
          if (authenticated) {
            storage.write(key: 'email', value: widget.email);
            storage.write(key: 'password', value: widget.password);
            storage.write(key: 'usingBiometric', value: 'true');
          }
        }
      }
    } else {
      print('cant check');
    }
  }

  
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    SearchPage(userLoggedIn: true,),
    FavoritesPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Pallete.buttonGreen,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        iconSize: 36,
        backgroundColor: Colors.white,
      ),
    );
  }
}
