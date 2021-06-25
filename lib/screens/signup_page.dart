import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fistbump/screens/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.changePage}) : super(key: key);
  final Function changePage;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var usernameFieldController = TextEditingController();
  var emailFieldController = TextEditingController();
  var passwordFieldController = TextEditingController();
  bool loggingIn = false;
  final _formKey = GlobalKey<FormState>();
  
  void _displaySnackBarMessage(message){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
  }

  void _loginFunction() async {
    if (_formKey.currentState!.validate()) {
      if(loggingIn)
        return;

      _displaySnackBarMessage('Signing Up');

      loggingIn = true;
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailFieldController.text,
          password: passwordFieldController.text
        );
        _displaySnackBarMessage('Signed up');
      } on FirebaseAuthException catch (e) {
        _displaySnackBarMessage(e.message);
      } catch (e) {
        print(e);
      }
      
      loggingIn = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container(
                height: 100,
                width: 100,
                color: Colors.blue,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(
                        height: 50,
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: height * .14),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _entryField(String title, controller, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'You can\'t leave this empty';
                }
                return null;
              },
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: _loginFunction,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.lightBlue.shade300, Colors.blue])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => LoginPage()));
        widget.changePage('sign-in');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'SAMU',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username", usernameFieldController),
        _entryField("Email id", emailFieldController),
        _entryField("Password", passwordFieldController, isPassword: true),
      ],
    );
  }

}
