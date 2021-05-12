import 'package:shared_preferences/shared_preferences.dart';


class HelperFuctions{
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserIdKey = "USERIDKEY";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceUserCountryCodeKey = "USERCOUNTRYCODEKEY";
  static String sharedPreferenceUserPhoneKey = "USERPHONEKEY";
  static String sharedPreferenceUserAddressKey = "USERADDRESSKEY";
  static String sharedPreferenceUserDobKey = "USERDOBKEY";
  static String sharedPreferenceUserTokenKey = "USERTOKENKEY";


  // Saving data to SharedPreference
   
  saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  saveUserUserIdSharedPreference(int isUserId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(sharedPreferenceUserIdKey, isUserId);
  }

  saveUserNameSharedPreference(String isUserName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, isUserName);
  }

  saveUserEmailSharedPreference(String isUserEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, isUserEmail);
  }

  saveUserCountryCodeSharedPreference(String isUserCountryCode) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserCountryCodeKey, isUserCountryCode);
  }
  
  saveUserPhoneSharedPreference(String isUserPhone) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserPhoneKey, isUserPhone);
  }

  saveUserAddressSharedPreference(String isUserAddress) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserAddressKey, isUserAddress);
  }
  
  saveUserDobSharedPreference(DateTime isUserDob) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserDobKey, isUserDob.toString());
  }
  
  saveUserTokenSharedPreference(String isUserToken) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserTokenKey, isUserToken);
  }

  // Getting data from SharedPreference
  getUserLoggedInSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn =  prefs.getBool(sharedPreferenceUserLoggedInKey);
    return isLoggedIn;
  }

  getUserUserIdSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt(sharedPreferenceUserIdKey);
    return id;
  }

  getUserNameSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(sharedPreferenceUserNameKey);
    return name;
  }

  getUserEmailSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString(sharedPreferenceUserEmailKey);
    return email;
  }

  getUserCountryCodeSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String countryCode = prefs.getString(sharedPreferenceUserCountryCodeKey);
    return countryCode;
  }
  
  getUserPhoneSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString(sharedPreferenceUserPhoneKey);
    return phone;
  }

  getUserAddressSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString(sharedPreferenceUserAddressKey);
    return address;
  }
  
  getUserDobSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dob = prefs.getString(sharedPreferenceUserDobKey);
    return dob;
  }
  
  getUserTokenSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(sharedPreferenceUserTokenKey);
    return token;
  }
  
}