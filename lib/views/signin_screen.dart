import 'package:flutter/material.dart';
import 'package:gev_app/services/database_model.dart';
import 'package:gev_app/views/home_screen.dart';
import 'package:gev_app/views/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool isLoading = false ;
  String errors = "";
  final formkey = GlobalKey<FormState>();

  DataBaseModel dataBaseModel = new DataBaseModel();
   
  TextEditingController _phone = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  signInUser(){
    if(formkey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      try {
        dataBaseModel.signInUser(_phone.text, _password.text).then((value){
          print("Value: "+value.toString());
          if(value != null){
            setState(() {
              isLoading = false;
              errors = "Invalid Details";  
            });
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => HomeScreen()
              )
            );
          }
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFCF70),
      body: Container(
        margin: EdgeInsets.only(top: 100.0),
        child: isLoading? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
        :
        SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Image.asset("assets/images/Logo.png",width: 80, height: 80,),
                  Text("Sign In", 
                    style: TextStyle(
                      color: Color(0xff8b5d2e),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Text(errors, 
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _phone,
                      validator: (value){
                        if(value.isEmpty){
                          return "Phone No can't be empty";
                        }else if(value.length < 10 || value.length > 10){
                          return "Phone No must be 10 Digit";
                        }
                      },
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Color(0xff8b5d2e),
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration(
                        icon: Icon(Icons.call),
                        hintText: "Phone No",
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,  
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(13.0)
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _password,
                      validator: (value){
                        if(value.isEmpty){
                          return "Password can't be empty";
                        }else if(value.length < 6){
                          return "Password must be atleast 6 character";
                        }
                      },
                      style: TextStyle(
                        color: Color(0xff8b5d2e),
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration(
                        icon: Icon(Icons.security),
                        hintText: "Password",
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,  
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(13.0)
                    ),
                  ),
                  SizedBox(height: 12.0,),
                  Container(
                    width: 380.0,
                    padding: const EdgeInsets.all(10.0),
                    child: FlatButton(
                      onPressed: () { 
                        signInUser();
                      },
                      child: Text("LogIn", 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff8b5d2e),
                      borderRadius: BorderRadius.circular(13.0)
                    ),
                  ),
                  SizedBox(height: 12.0,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Here for first time? ", 
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black87
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => SignUpScreen()
                              )
                            );
                          },
                          child: Text("Sign Up",
                            style: TextStyle(
                              fontSize: 19.0,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}