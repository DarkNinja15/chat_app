import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final auth = FirebaseAuth.instance;

  // sign up user
  signUp(String email, String password, String name) async {
    try {
      final UserCredential credential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'email': email,
        'name': name,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
