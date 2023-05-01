import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathers/ViewModel/Capital_viewModel.dart';
import 'Screens/Signup.dart';
import 'ViewModel/user_viewModel.dart';
// 1
//2
//3
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( providers:[
      ChangeNotifierProvider(create: (_) => UserViewModel(),
      ),
      ChangeNotifierProvider(create: (_) => CapitalViewModel()),
    ],
      child: MaterialApp(
        home: LoginSignupPage(),
      ),
    );
  }
}


