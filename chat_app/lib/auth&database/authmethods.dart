import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final auth = FirebaseAuth.instance;

  // sign up user
  Future<bool> signUp(String email, String password, String name) async {
    try {
      final UserCredential credential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // adding user to firestore...
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'uid': auth.currentUser!.uid,
        'name': name,
        'email': email,
        'groups': [],
        'profilePic': '',
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // log in user
  Future<bool> login(String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
