import 'package:flutter/material.dart';
import 'package:gev_app/services/database_model.dart';
import 'package:gev_app/views/home_screen.dart';
import 'package:gev_app/views/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading=false;
  final formkey = GlobalKey<FormState>();

  DataBaseModel dataBaseModel = new DataBaseModel();

  TextEditingController _name = new TextEditingController();
  TextEditingController _countryCode = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  signUpUser(){
    if(formkey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      try {
        dataBaseModel.signUpUser(_name.text, _countryCode.text, _phone.text, _email.text, _password.text).then((value){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen()
            )
          );
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
        margin: EdgeInsets.only(top: 30.0),
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
                  Text("Sign Up", 
                    style: TextStyle(
                      color: Color(0xff8b5d2e),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _name,
                      validator: (value){
                        if(value.isEmpty){
                          return "Name can't be empty";
                        }
                      },
                      style: TextStyle(
                        color: Color(0xff8b5d2e),
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration(
                        icon: Icon(Icons.person_outline_rounded),
                        hintText: "Name",
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,  
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 70.0, 
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _countryCode,
                            validator: (value){
                              if(value.isEmpty){
                                return "Country Code can't be empty";
                              }else if(value.length < 2 || value.length > 2){
                                return "Country Code must be 2 Digit";
                              }
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Color(0xff8b5d2e),
                              fontSize: 20.0,
                            ),
                            decoration: InputDecoration(
                              hintText: "+91",
                              border: InputBorder.none,
                              errorStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,  
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0,),
                      Expanded(
                        child: Container(
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
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0,),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _email,
                      validator: (value){
                        if(value.isEmpty){
                          return "Email can't be empty";
                        }else if(!RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value)){
                          return "Invalid Email Id";
                        }
                      },
                      style: TextStyle(
                        color: Color(0xff8b5d2e),
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration(
                        icon: Icon(Icons.email_outlined),
                        hintText: "Email",
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
                        signUpUser();
                      },
                      child: Text("REGESTER", 
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
                        Text("Have an account? ", 
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black87
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => SignInScreen()
                              )
                            );
                          },
                          child: Text("Sign In",
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