import 'package:flutter/material.dart';
import 'package:gev_app/views/navigation_bar.dart';
import 'package:gev_app/widgets/appbar.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      NavigationBar(0);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Events"),
      bottomNavigationBar: NavigationBar(0),
    );
  }
}