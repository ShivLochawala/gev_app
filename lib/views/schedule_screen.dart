import 'package:flutter/material.dart';
import 'package:gev_app/views/navigation_bar.dart';
import 'package:gev_app/widgets/appbar.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      NavigationBar(3);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Schedule"),
      bottomNavigationBar: NavigationBar(3),
    );
  }
}