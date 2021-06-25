import 'package:fistbump/screens/login_page.dart';
import 'package:fistbump/screens/signup_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({ Key? key }) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  String page = 'sign-in';

  void _changePage(String id){
    setState(() {
      page = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(page == 'sign-in')
      return LoginPage(changePage: _changePage);
    if(page == 'sign-up')
      return SignUpPage(changePage: _changePage);
    return Container();
  }
}

