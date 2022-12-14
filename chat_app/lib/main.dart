import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/shared/loading1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.purple[400],
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.pink,
          )),
      // home: const SignUpPage(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const HomePage();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Some Error Occured!!'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading1(
              color: Colors.purpleAccent,
            );
          }
          return const LoginPage();
        }),
      ),
    );
  }
}
