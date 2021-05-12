import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:gev_app/services/gev_podo.dart';
import 'package:gev_app/services/helper_function.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseModel {
  HelperFuctions helperFuctions = new HelperFuctions();
  static Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId;  //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;  //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    //if (!mounted) return;
    return [deviceName, deviceVersion, identifier];
  }
  Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
  Future<String> getDeviceName() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.name; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.model; // unique ID on Android
    }
  }
  // Sign Up User
  Future signUpUser(String userName, String countryCode, String phone, String email, String password)async{
    print("DataBase Model");
    String deviceId = await getDeviceId();
    String deviceName = await getDeviceName();
    try {
      http.Response response;
      Uri url = Uri.parse('http://10.0.2.2:8000/api/add-user-info');
      response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': userName,
          'country_code' : countryCode,
          'phone' : phone,
          'email' : email,
          'password' : password,
          'device_id' : deviceId,
          'device_name' : deviceName
        }),
      );
      if (response.statusCode == 200) {
        print(response.body);
        //return json.decode(response.body);
        final Map parsed = json.decode(response.body);
        final List<dynamic> userData = parsed['user_info'];
        helperFuctions.saveUserLoggedInSharedPreference(true);
        helperFuctions.saveUserTokenSharedPreference(parsed['token']);
        helperFuctions.saveUserUserIdSharedPreference(userData[0]['id']);
        helperFuctions.saveUserNameSharedPreference(userData[0]['name']);
        helperFuctions.saveUserCountryCodeSharedPreference(userData[0]['country_code']);
        helperFuctions.saveUserPhoneSharedPreference(userData[0]['phone']);
        helperFuctions.saveUserEmailSharedPreference(userData[0]['email']);
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update album.');
      } 
    } catch (e) {
      print(e.toString());
    }
  }
  // Sign In User
  Future signInUser(String phone, String password)async{
    print("DataBase Model");
    String deviceId = await getDeviceId();
    String deviceName = await getDeviceName();
    try {
      http.Response response;
      Uri url = Uri.parse('http://10.0.2.2:8000/api/fetch-user-info');
      response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone' : phone,
          'password' : password,
          'device_id' : deviceId,
          'device_name' : deviceName
        }),
      );
      if (response.statusCode == 200) {
        print("True Condition");
        //return json.decode(response.body);
        final Map<String, dynamic> parsed = json.decode(response.body);
        final List<dynamic> userData = parsed['user_info'];
        //print(userData[0]['token']);
        // print(userData[0]['id']);
        // print(userData[0]['name']);
        // print(userData[0]['phone'].toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setBool('ISLOGGEDIN', true);
        // await prefs.setString('USERTOKENKEY', userData[0]['token']);
        // await prefs.setString('USERIDKEY', userData[0]['id']);
        // await prefs.setString('USERNAMEKEY', userData[0]['name']);
        // await prefs.setString('USERCOUNTRYCODEKEY', userData[0]['country_code'].toString());
        // await prefs.setString('USERPHONEKEY', userData[0]['phone'].toString());
        // await prefs.setString('USEREMAILKEY', userData[0]['email']);
        // await prefs.setString('USERADDRESSKEY', userData[0]['address']);
        // await prefs.setString('USERDOBKEY', userData[0]['dob']);
        helperFuctions.saveUserLoggedInSharedPreference(true);
        helperFuctions.saveUserTokenSharedPreference(userData[0]['token']);
        helperFuctions.saveUserUserIdSharedPreference(userData[0]['id']);
        helperFuctions.saveUserNameSharedPreference(userData[0]['name']);
        helperFuctions.saveUserCountryCodeSharedPreference(userData[0]['country_code']);
        helperFuctions.saveUserPhoneSharedPreference(userData[0]['phone']);
        helperFuctions.saveUserEmailSharedPreference(userData[0]['email']);
        helperFuctions.saveUserAddressSharedPreference(userData[0]['address']);
        helperFuctions.saveUserDobSharedPreference(userData[0]['dob']);
        bool isLoggedValue = prefs.getBool('ISLOGGEDIN');
        print(isLoggedValue);
        //return json.decode(response.body);
        return true;
      } else {
        print("false Condition");
        return false;
        //throw Exception('Failed to update album.');
      } 
    } catch (e) {
      print(e.toString());
    }
  }
  // Sing Out User (Logout)
  Future signOutUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('USERTOKENKEY');
    print('Token value before logout:'+token);
    bool isLoggedValue = prefs.getBool('ISLOGGEDIN');
    print("Logged In Value: "+isLoggedValue.toString());
    try {
      http.Response response;
      Uri url = Uri.parse('http://10.0.2.2:8000/api/logout-user');
      response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer '+token
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        helperFuctions.saveUserLoggedInSharedPreference(false);
        prefs.remove("ISLOGGEDIN");
        prefs.remove("USERIDKEY");
        prefs.remove("USERNAMEKEY");
        prefs.remove("USEREMAILKEY");
        prefs.remove("USERCOUNTRYCODEKEY");
        prefs.remove("USERPHONEKEY");
        prefs.remove("USERTOKENKEY");
        bool isLoggedValue = prefs.getBool('ISLOGGEDIN');
        print("Logged In Value: "+isLoggedValue.toString());
        print("Token Value: "+token.toString());
        //HelperFuctions.saveUserLoggedInSharedPreference(false);
        return json.decode(response.body);
      } else {
        throw Exception('Failed to Logout');
      } 
    } catch (e) {
      print(e.toString());
    }
  }

  // Get user all information
  Future getUserDetails()async{
    print("DataBase Model");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('USERTOKENKEY');
    int userId = prefs.getInt('USERIDKEY');
    print('User_id :'+userId.toString());

    try {
      http.Response response;
      Uri url = Uri.parse('http://10.0.2.2:8000/api/fetch-user-information/'+userId.toString());
      response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer '+token
        },
      );
      if (response.statusCode == 200) {
        print("True Condition");
        // var data = json.decode(response.body);
        // var rest = data["user_info"] as List;
        // List<User> list = rest.map<User>((json) => User.fromJson(json)).toList();
        return json.decode(response.body);
        // print(list);
        // return list;
      } else {
        print("false Condition");
        return false;
        //throw Exception('Failed to update album.');
      } 
    } catch (e) {
      print(e.toString());
    }
  }


  // Update Profile Details
  Future updateUserDetails(String name, String country_code, String phone, String email, String address, String dob)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('USERIDKEY');
    String token = prefs.getString('USERTOKENKEY');
    print('user_id '+userId.toString());
    
    try {
      http.Response response;
      Uri url = Uri.parse('http://10.0.2.2:8000/api/edit-user-info/'+userId.toString());
      response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer '+token
        },
        body: jsonEncode(<String, dynamic>{
          'name' : name,
          'country_code' : country_code,
          'phone' : phone,
          'email' : email,
          'address' : address,
          'dob' : dob
        }),
      );
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        final Map<String, dynamic> parsed = json.decode(response.body);
        final List<dynamic> userData = parsed['user_info'];
        // print(userData[0]['token']);
        // print(userData[0]['id']);
        // print(userData[0]['name']);
        helperFuctions.saveUserUserIdSharedPreference(userData[0]['id']);
        helperFuctions.saveUserNameSharedPreference(userData[0]['name']);
        helperFuctions.saveUserCountryCodeSharedPreference(userData[0]['country_code']);
        helperFuctions.saveUserPhoneSharedPreference(userData[0]['phone']);
        helperFuctions.saveUserEmailSharedPreference(userData[0]['email']);
        helperFuctions.saveUserAddressSharedPreference(userData[0]['address']);
        helperFuctions.saveUserDobSharedPreference(userData[0]['dob']);
        //return json.decode(response.body);
        return "Updated Details";
      } else {
        print("false Condition");
        return false;
        //throw Exception('Failed to update album.');
      } 
    } catch (e) {
      print(e.toString());
    }
  }

  //Notification add
  Future addNotification(String deviceToken)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('USERIDKEY');
    //print('User Id :'+id.toString());
    String token = prefs.getString('USERTOKENKEY');
    //print('Token value:'+token);
    //print('Device Token:'+deviceToken);
    try {
      http.Response response;
      Uri url = Uri.parse('http://10.0.2.2:8000/api/add-fcm-token');
      response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer '+token
        },
        body: jsonEncode(<String, dynamic>{
          'user_id' : id,
          'token' : deviceToken,
        }),
      );
      print(response.statusCode);
      //print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to AddNotification');
      } 
    } catch (e) {
      print(e.toString());
    }
  }
}