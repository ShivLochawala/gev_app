import 'package:flutter/material.dart';
import 'package:gev_app/services/database_model.dart';
import 'package:gev_app/views/signin_screen.dart';
import 'package:gev_app/views/splash_screen.dart';
// myAppBar(String title){
//   return AppBar(
//     title: Text(
//       title, 
//       style: TextStyle(
//         color: Color(0xff8b5d2e),
//         fontWeight: FontWeight.bold,
//         fontSize: 25.0
//       ),
//     ),
//     automaticallyImplyLeading: false,
//     actions: [
//       GestureDetector(
//         onTap: (){
//           signOutUser();
//         },
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal:16),
//           child: Icon(Icons.logout),
//         ),
//       )
//     ],
//   );
// }
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  MyAppBar(this.title);
  signOutUser() async{
    DataBaseModel dataBaseModel = new DataBaseModel();
    try {
      dataBaseModel.signOutUser().then((value){
        
      });
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title, 
        style: TextStyle(
          color: Color(0xff8b5d2e),
          fontWeight: FontWeight.bold,
          fontSize: 25.0
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        GestureDetector(
          onTap: (){
            signOutUser();
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => SignInScreen()
              )
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:16),
            child: Icon(Icons.logout),
          ),
        )
      ],
    );
  }
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}