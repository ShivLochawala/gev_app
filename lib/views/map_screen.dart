import 'package:flutter/material.dart';
import 'package:gev_app/views/navigation_bar.dart';
import 'package:gev_app/widgets/appbar.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      NavigationBar(1);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Map"),
      bottomNavigationBar: NavigationBar(1),
    );
  }
}