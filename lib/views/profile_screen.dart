import 'package:flutter/material.dart';
import 'package:gev_app/services/database_model.dart';
import 'package:gev_app/services/gev_podo.dart';
import 'package:gev_app/services/helper_function.dart';
import 'package:gev_app/views/navigation_bar.dart';
import 'package:gev_app/widgets/appbar.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;
  DataBaseModel dataBaseModel = new DataBaseModel();
  HelperFuctions helperFuctions = new HelperFuctions();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _conturyCodeController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      builder: (context, child) {
      return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff8b5d2e), // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color(0xff8b5d2e), // button text color
              ),
            ),
          ),
          child: child,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 8),
      lastDate: DateTime(2100));
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          var date =
              "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
          _dateController.text = date;
        });
  }
  
  getUserDetails() {
   dataBaseModel.getUserDetails().then((value){
    var rest = value["user_info"] as List;
    List<User> list = rest.map<User>((json) => User.fromJson(json)).toList();
    _nameController.text = list[0].name;
    _conturyCodeController.text = list[0].countryCode;
    _phoneController.text = list[0].phone;
    _emailController.text = list[0].email;
    _addressController.text = list[0].address;
    _dateController.text = list[0].dob;
    // final Map<String, dynamic> parsed = value;
    // print(parsed['user_info']);
    // final List<dynamic> userData = parsed['user_info'];
    //_nameController.text = list[0].name;
    // _conturyCodeController.text = userData[0]['country_code'].toString();
    // _phoneController.text = userData[0]['phone'].toString();
    // _emailController.text = userData[0]['email'];
    // _addressController.text = userData[0]['address'];
    // _dateController.text = userData[0]['dob'];
   });
  }

  editUserDetails(){
    if(formkey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      print(_dateController.text);
      try {
        dataBaseModel.updateUserDetails(_nameController.text, _conturyCodeController.text, _phoneController.text, _emailController.text, _addressController.text, _dateController.text).then((value){
          
        });
      } catch (e) {
        print(e.toString());
      }
      
    }
  }
  
  @override
  void initState() {
    getUserDetails();
    super.initState();
    setState(() {
      NavigationBar(4);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Profile"),
      bottomNavigationBar: NavigationBar(4),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value){
                      if(value.isEmpty){
                        return "Name can't be empty";
                      }
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Color(0xffFFCF70),),
                      border: InputBorder.none,
                      hintText: "Name",
                      hintStyle: TextStyle(
                        color: Color(0xffFFCF70),
                        fontSize: 20.0,
                      ),
                      errorStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,  
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xffFFCF70),
                      fontSize: 20.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff8b5d2e),
                    borderRadius: BorderRadius.circular(13.0)
                  ),
                ),
                SizedBox(height: 8.0,),
                Row(
                  children: [
                    SizedBox(
                      width: 70.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _conturyCodeController,
                          validator: (value){
                            if(value.isEmpty){
                              return "Country Code can't be empty";
                            }else if(value.length < 2 || value.length > 2){
                              return "Country Code must be 2 Digit";
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "+91",
                            hintStyle: TextStyle(
                              color: Color(0xffFFCF70),
                              fontSize: 20.0,
                            ),
                            errorStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,  
                            ),
                          ),
                          style: TextStyle(
                            color: Color(0xffFFCF70),
                            fontSize: 20.0,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff8b5d2e),
                          borderRadius: BorderRadius.circular(13.0)
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0,),
                    Expanded(
                      child:Container(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _phoneController,
                          validator: (value){
                            if(value.isEmpty){
                              return "Phone No can't be empty";
                            }else if(value.length < 10 || value.length > 10){
                              return "Phone No must be 10 Digit";
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone Number",
                            hintStyle: TextStyle(
                              color: Color(0xffFFCF70),
                              fontSize: 20.0,
                            ),
                            errorStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,  
                            ),
                          ),
                          style: TextStyle(
                            color: Color(0xffFFCF70),
                            fontSize: 20.0,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff8b5d2e),
                          borderRadius: BorderRadius.circular(13.0)
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8.0,),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value){
                      if(value.isEmpty){
                        return "Email can't be empty";
                      }else if(!RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
.hasMatch(value)){
                      return "Invalid Email Id";
                      }
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.email_outlined, color: Color(0xffFFCF70),),
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Color(0xffFFCF70),
                        fontSize: 20.0,
                      ),
                      errorStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,  
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xffFFCF70),
                      fontSize: 20.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff8b5d2e),
                    borderRadius: BorderRadius.circular(13.0)
                  ),
                ),
                SizedBox(height: 8.0,),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_on, color: Color(0xffFFCF70),),
                      border: InputBorder.none,
                      hintText: "Address",
                      hintStyle: TextStyle(
                        color: Color(0xffFFCF70),
                        fontSize: 20.0,
                      ),
                      errorStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,  
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xffFFCF70),
                      fontSize: 20.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff8b5d2e),
                    borderRadius: BorderRadius.circular(13.0)
                  ),
                ),
                SizedBox(height: 8.0,),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.date_range_outlined, color: Color(0xffFFCF70),),
                          border: InputBorder.none,
                          hintText: "DOB",
                          hintStyle: TextStyle(
                            color: Color(0xffFFCF70),
                            fontSize: 20.0,
                          ),
                          errorStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,  
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xffFFCF70),
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff8b5d2e),
                    borderRadius: BorderRadius.circular(13.0)
                  ),
                ),
                SizedBox(height: 12,),
                Container(
                  width: 380.0,
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    onPressed: () { 
                      editUserDetails();
                    },
                    child: Text("Update Details", 
                      style: TextStyle(
                        color: Color(0xff8b5d2e),
                        fontSize: 25.0
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffFCCC89),
                    borderRadius: BorderRadius.circular(13.0)
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}