import 'package:fistbump/screens/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fistbump/screens/home.dart';
import 'package:fistbump/screens/login_page.dart';
import 'config/themes/dark_theme.dart';

/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: darkTheme,
      home: FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) 
            return Container();

          if (snapshot.connectionState == ConnectionState.done)
            return authBuilder();

          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget authBuilder(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasError)
          return Container();

        if(snapshot.data == null)
          return AuthPage();

        return Home();

      }
    );
  }
  
}
