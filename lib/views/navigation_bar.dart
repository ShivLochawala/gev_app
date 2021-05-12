import 'package:flutter/material.dart';
import 'package:gev_app/views/event_screen.dart';
import 'package:gev_app/views/home_screen.dart';
import 'package:gev_app/views/map_screen.dart';
import 'package:gev_app/views/profile_screen.dart';
import 'package:gev_app/views/schedule_screen.dart';

class NavigationBar extends StatefulWidget {
  final int currentInt;
  NavigationBar(this.currentInt);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
       _selectedIndex = widget.currentInt;
    });
  }
   void _onItemTapped(int index) {
    setState(() {
       _selectedIndex = index;
    });
    if(_selectedIndex == 0){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => EventScreen()
        )
      );
    }else if(_selectedIndex == 1){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => MapScreen()
        )
      );
    }else if(_selectedIndex == 2){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomeScreen()
        )
      );
    }else if(_selectedIndex == 3){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ScheduleScreen()
        )
      );
    }else if(_selectedIndex == 4){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProfileScreen()
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xffFFCF70),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.event, color: Color(0xff8b5d2e), size: 35.0,),
          label: "Event",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on, color: Color(0xff8b5d2e),size: 35.0,),
          label: "Map",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Color(0xff8b5d2e), size: 60.0,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule, color: Color(0xff8b5d2e),size: 35.0,),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Color(0xff8b5d2e),size: 35.0,),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black87,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: true,
      unselectedItemColor: Color(0xff8b5d2e),
      unselectedFontSize: 13.0,
      selectedFontSize: 15.0,
      onTap: _onItemTapped,
      
    );
  }
}