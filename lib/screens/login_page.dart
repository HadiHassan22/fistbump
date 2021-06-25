import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fistbump/screens/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.changePage}) : super(key: key);
  final Function changePage;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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

      _displaySnackBarMessage('Logging In');

      loggingIn = true;
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailFieldController.text,
          password: passwordFieldController.text
        );
        _displaySnackBarMessage('Logged In');
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
      child: Container(
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
                SizedBox(height: 50),
                _emailPasswordWidget(),
                SizedBox(height: 20),
                _submitButton(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerRight,
                  child: Text('Forgot Password ?',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: height * .055),
                _createAccountLabel(),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _entryField(String title, TextEditingController controller, {bool isPassword = false}) {
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
              obscureText: isPassword,
              controller: controller,
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
              spreadRadius: 2
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.lightBlue.shade300, Colors.blue]
          )
        ),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => SignUpPage()));
        // widget.changePage('sign-up');
        widget.changePage('sign-up');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
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
        _entryField("Email", emailFieldController),
        _entryField("Password", passwordFieldController, isPassword: true),
      ],
    );
  }


}
