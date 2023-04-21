import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ViewModel/user_viewModel.dart';

class LoginSignupPage extends StatelessWidget {
  const LoginSignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar:AppBar(backgroundColor: Color(0xff14306F),
              title: Text(provider.isLoginForm ? 'Login' : 'Signup'),//The String is changed based on if user choose login or create account
            ),
            body: Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: provider.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                      onSaved: (value) => provider.email1 = value!.trim(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Password can\'t be empty' : null,
                      onSaved: (value) => provider.password1 = value!.trim(),
                    ),
                    SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {

                        Provider.of<UserViewModel>(context, listen: false)
                            .submitForm(context);

                      },
                      child:
                          Container(
                            height: 50,
                            width: 60,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(color: Colors.black12),

                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                    bottomLeft: Radius.circular(18),
                                    bottomRight: Radius.circular(18)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(child: Text(// The String is changed based on if user choose login or create account

                                  provider.isLoginForm ? 'Login' : 'Create account',style: TextStyle(fontSize: 22,color:Color(0xff14306F),fontWeight: FontWeight.w900)))),
                    ),
                    SizedBox(height: 25,),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Provider.of<UserViewModel>(context, listen: false)
                              .setStatus(!provider.isLoginForm);

                        },
                        child: Text(provider.isLoginForm //The String is changed based on if user choose login or create account
                            ? 'Create an account'
                            : 'Have an account? Login',style: TextStyle(color:Colors.blue,fontWeight: FontWeight.bold,fontSize: 16),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  }

/*  void _submitForm() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form!.save();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (_isLoginForm) {
        // handle login
        String email = prefs.getString('email')??'';
        String password = prefs.getString('password')??'';
        if (email == _email && password == _password) {
          print('success');
        } else {
         print('failed');
        }
      } else {
        // handle signup
        await prefs.setString('email', _email);
        await prefs.setString('password', _password);
        // signup successful
      }
    }
  }*/
}
