import 'package:flutter/material.dart';
import 'package:gev_app/services/database_model.dart';
import 'package:gev_app/views/navigation_bar.dart';
import 'package:gev_app/widgets/appbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  DataBaseModel dataBaseModel = new DataBaseModel();
  Future<String> permissionStatusFuture;
  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";
  String deviceToken;

  void registerNotification() async {
  
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    messaging.getToken().then((token) {
      deviceToken = token;
      //print('Token: '+deviceToken);
      dataBaseModel.addNotification(deviceToken).then((value){
        //print('Added Token into table :'+value.toString());
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return null;
      }
    });
  }

  
  @override
  void initState() {
    super.initState();
    permissionStatusFuture = getCheckNotificationPermStatus();
    registerNotification();
    setState(() {
      NavigationBar(2);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Home"),
      bottomNavigationBar: NavigationBar(2),
    );
  }
  
}