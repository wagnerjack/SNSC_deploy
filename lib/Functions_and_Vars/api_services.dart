import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snsc/Pages/all_pages.dart';
import 'package:snsc/models/organization.dart';
import 'package:snsc/models/filter.dart';
import 'package:snsc/models/faq.dart';

import '../config/api_config.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var server = http.Client();

  // user functions

  static Future<String> signup(User user, BuildContext context) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.signupAPI);

    var response = await server.post(url,
        headers: requestHeaders, body: jsonEncode(user.toJson()));

    // if successful
    if (response.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      User apiUserInfo = User.fromJson(json.decode(response.body));
      String savedUserInfo = jsonEncode(apiUserInfo);
      localStorage.setString('user', savedUserInfo);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(
                    email: '',
                    password: '',
                    wantsBiometrics: false,
                  )),
          (route) => false);
    } else {
      final Map<String, dynamic> error = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error['error'])),
      );
    }

    return response.body;
  }

  static Future<String> login(String email, String password,
      BuildContext context, bool wantsBiometrics) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.loginAPI);

    var response = await server.post(url,
        headers: requestHeaders, body: jsonEncode(_data));

    // if successful
    if (response.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      User apiUserInfo = User.fromJson(json.decode(response.body));
      String savedUserInfo = jsonEncode(apiUserInfo);
      localStorage.setString('user', savedUserInfo);

      if (apiUserInfo.isAdmin!) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AdminLandingPage()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      email: email,
                      password: password,
                      wantsBiometrics: wantsBiometrics,
                    )),
            (route) => false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Email or Password')),
      );
    }

    return response.body;
  }

  static Future<void> logout(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
        (route) => false);
  }

  // can only use this function if the user is logged in
  // hence why there are no arguments
  static Future<User> getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String userStringInfo = localStorage.getString('user')!;
    Map<String, dynamic> userMap = jsonDecode(userStringInfo);
    User user = User.fromJson(userMap);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': '${user.token}'
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.userAPI);
    var response = await server.get(url, headers: requestHeaders);
    Map<String, dynamic> responseUserMap = jsonDecode(response.body);
    User responseUser = User.fromJson(responseUserMap);

    return responseUser;
  }

  //Test
  // update user info
  static Future<String> updateUser(
      User updatedUser, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String userStringInfo = localStorage.getString('user')!;
    Map<String, dynamic> userMap = jsonDecode(userStringInfo);
    User user = User.fromJson(userMap);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': '${user.token}'
    };

    final _data = <String, dynamic>{};

    if (updatedUser.name != null) {
      _data['name'] = updatedUser.name;
    }

    if (updatedUser.email != null) {
      _data['email'] = updatedUser.email;
    }

    if (updatedUser.dateOfBirth != null) {
      _data['dateOfBirth'] = updatedUser.dateOfBirth;
    }

    if (updatedUser.location != null) {
      _data['location'] = updatedUser.location;
    }

    if (updatedUser.disability != null) {
      _data['disability'] = updatedUser.disability;
    }

    if (updatedUser.insurance != null) {
      _data['insurance'] = updatedUser.insurance;
    }

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.userAPI);
    var response =
        await server.put(url, headers: requestHeaders, body: jsonEncode(_data));

    // if successful
    if (response.statusCode == 200) {
      // update the user info in sharedpreferences
      // rethink this because the token will disappear
      // this also mean the user data saved in local storage will be out of date
      // that is okay because the only thing we need is the token which never changes

      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // User apiUserInfo = User.fromJson(json.decode(response.body));
      // String savedUserInfo = jsonEncode(apiUserInfo);
      // localStorage.setString('user', savedUserInfo);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile successfully updated')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating profile')),
      );
    }

    return response.body;
  }

  // Test
  // update user password
  static Future<String> updatePassword(
      String oldPassword, String newPassword, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String userStringInfo = localStorage.getString('user')!;
    Map<String, dynamic> userMap = jsonDecode(userStringInfo);
    User user = User.fromJson(userMap);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': '${user.token}'
    };

    final _data = <String, dynamic>{};
    _data['old'] = oldPassword;
    _data['new'] = newPassword;

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.userpasswordAPI);
    var response =
        await server.put(url, headers: requestHeaders, body: jsonEncode(_data));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password successfully changed')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Old password is incorrect')),
      );
    }

    return response.body;
  }

  // todo: delete user (so that they can delete there account)

  // organization functions

  static Future<List<Organization>> getAllOrganizations() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.organizationsAPI);
    var response = await server.get(url, headers: requestHeaders);

    List responseJson = jsonDecode(response.body);

    return responseJson.map((m) => Organization.fromJson(m)).toList();
  }

  static Future<Organization> getOrganization(String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.organizationsAPI + '/$id');
    var response = await server.get(url, headers: requestHeaders);

    Map<String, dynamic> responseJson = jsonDecode(response.body);
    return Organization.fromJson(responseJson);
  }

  static Future<String> saveOrganization(Organization organization) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.organizationsAPI);
    var response = await server.post(url,
        headers: requestHeaders, body: jsonEncode(organization.toJson()));

    return response.body;
  }

  static Future<String> deleteOrganization(String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.organizationsAPI + '/$id');
    var response = await server.delete(url, headers: requestHeaders);

    return response.body;
  }

  static Future<String> updateOrganization(
      String id, Organization organization) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.organizationsAPI + '/$id');
    var response = await server.put(url,
        headers: requestHeaders, body: jsonEncode(organization.toJson()));

    return response.body;
  }

  static Future<String> saveToFavorites(String organizationId) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String userStringInfo = localStorage.getString('user')!;
    Map<String, dynamic> userMap = jsonDecode(userStringInfo);
    User user = User.fromJson(userMap);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': '${user.token}'
    };

    var url = Uri.http(
        ApiConfig.rootURL, ApiConfig.userFavoritesAPI + '/add/$organizationId');
    var response = await server.put(url, headers: requestHeaders);

    return response.body;
  }

  static Future<String> removeToFavorites(String organizationId) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String userStringInfo = localStorage.getString('user')!;
    Map<String, dynamic> userMap = jsonDecode(userStringInfo);
    User user = User.fromJson(userMap);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': '${user.token}'
    };

    var url = Uri.http(ApiConfig.rootURL,
        ApiConfig.userFavoritesAPI + '/remove/$organizationId');
    var response = await server.put(url, headers: requestHeaders);

    return response.body;
  }

  static Future<List<Organization>> getAllFavorites() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String userStringInfo = localStorage.getString('user')!;
    Map<String, dynamic> userMap = jsonDecode(userStringInfo);
    User user = User.fromJson(userMap);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': '${user.token}'
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.userFavoritesAPI);
    var response = await server.get(url, headers: requestHeaders);

    List responseJson = jsonDecode(response.body);

    return responseJson.map((m) => Organization.fromJson(m)).toList();
  }

  static Future<List<Organization>> searchByText(
      String organizationName) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final _data = <String, String>{};
    _data['name'] = organizationName;

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.textSearch);

    var response = await server.post(url,
        headers: requestHeaders, body: json.encode(_data));

    List responseJson = jsonDecode(response.body);

    return responseJson.map((m) => Organization.fromJson(m)).toList();
  }

  static Future<List<Organization>> searchByFilter(
      {List<String>? disabilities,
      List<String>? services,
      List<String>? states,
      List<String>? insurances,
      String? fee,
      String? age}) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final _data = <String, dynamic>{};

    if (disabilities!.isNotEmpty) {
      _data['disabilities'] = disabilities;
    }
    if (services!.isNotEmpty) {
      _data['services'] = services;
    }
    if (states!.isNotEmpty) {
      _data['states'] = states;
    }
    if (insurances!.isNotEmpty) {
      _data['insurances'] = insurances;
    }
    if (fee != "") {
      _data['fee'] = fee;
    }
    if (age != "") {
      _data['age'] = int.parse(age!);
    }

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.filterSearch);
    var response = await server.post(url,
        headers: requestHeaders, body: jsonEncode(_data));

    List responseJson = jsonDecode(response.body);

    return responseJson.map((m) => Organization.fromJson(m)).toList();
  }

  // filter functions
  static Future<List<Filter>> getDisabilityFilters() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url =
        Uri.http(ApiConfig.rootURL, ApiConfig.filterAPI + "/disabilities");
    var response = await server.get(url, headers: requestHeaders);

    List responseJson = jsonDecode(response.body);

    return responseJson.map((m) => Filter.fromJson(m)).toList();
  }

  static Future<List<Filter>> getServiceFilters() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.filterAPI + "/services");
    var response = await server.get(url, headers: requestHeaders);

    List responseJson = jsonDecode(response.body);

    return responseJson.map((m) => Filter.fromJson(m)).toList();
  }

  static Future<List<Filter>> getStateFilters() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.filterAPI + "/states");
    var response = await server.get(url, headers: requestHeaders);

    List responseJson = jsonDecode(response.body);

    return responseJson.map((m) => Filter.fromJson(m)).toList();
  }

  static Future<List<Filter>> getInsuranceFilters() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.filterAPI + "/insurances");
    var response = await server.get(url, headers: requestHeaders);

    List responseJson = jsonDecode(response.body);

    return responseJson.map((m) => Filter.fromJson(m)).toList();
  }

  // faq functions
  static Future<List<Faq>> getFaqs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.faqAPI);
    var response = await server.get(url, headers: requestHeaders);

    List responseJson = jsonDecode(response.body);

    return responseJson.map((m) => Faq.fromJson(m)).toList();
  }

  static Future<String> saveFaq(Faq faq) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.faqAPI);
    var response = await server.post(url,
        headers: requestHeaders, body: jsonEncode(faq.toJson()));

    return response.body;
  }

  static Future<String> deleteFaq(String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.faqAPI + '/$id');
    var response = await server.delete(url, headers: requestHeaders);

    return response.body;
  }

  static Future<String> updateFaq(String id, Faq faq) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(ApiConfig.rootURL, ApiConfig.faqAPI + '/$id');
    var response = await server.put(url,
        headers: requestHeaders, body: jsonEncode(faq.toJson()));

    return response.body;
  }
}
