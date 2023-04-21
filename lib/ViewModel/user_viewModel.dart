import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathers/Screens/Capitals.dart';

class UserViewModel extends ChangeNotifier{
  bool isLoginForm = true;
  String email1='';
  String password1='';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
   Future<SharedPreferences> prefs=SharedPreferences.getInstance();
  UserViewModel(){
  }
  setStatus(bool status){ //This status is used to know weather user is doing login or signup
    isLoginForm=status;
    notifyListeners();
  }
  void submitForm(BuildContext context) async { //This method used to execute login and signup based on isLoginForm status
    final form = formKey.currentState;
    if (form!.validate()) {
      form!.save();
      final SharedPreferences prefs = await SharedPreferences.getInstance(); // User creditials is saved in shared preference
      if (isLoginForm) {
        // handle login
        String email = prefs.getString('email')??'';
        String password = prefs.getString('password')??'';
        if (email == email1 && password == password1) {
          Fluttertoast.showToast(
              msg: "Login Sucess",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
          print('success');
          Navigator.push( // Once Login is complete Capitals page is open
            context,
            MaterialPageRoute(builder: (context) => const Capitals()),);
        } else {
          Fluttertoast.showToast(
              msg: "Login Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );

        }
      } else {
        // handle signup
        await prefs.setString('email', email1);
        await prefs.setString('password', password1);
        Fluttertoast.showToast(
            msg: "Signup Sucess",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
    }
    notifyListeners();
  }
}
