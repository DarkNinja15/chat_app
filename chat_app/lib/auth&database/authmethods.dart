import 'dart:async';

import 'package:chat_app/models/usermodels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final auth = FirebaseAuth.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = auth.currentUser!;
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    return UserModel.fromSnap(snap);
  }

  // sign up user
  Future<String?> signUp(String email, String password, String name) async {
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
      return "Success";
    } on FirebaseAuthException catch (error) {
      print('error = ${error.code}');
      if (error.code == 'email-already-in-use') {
        return "Email already in use. Try using a diffrent email";
      } else if (error.code == 'invalid-email') {
        return "Invalid email";
      } else if (error.code == 'operation-not-allowed') {
        return "Operation not allowed";
      } else if (error.code == 'weak-password') {
        return "Password is too weak";
      }
    } catch (e) {
      print(e.toString());
      return "Failed";
    }
  }

  // log in user
  Future<String> login(String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        return 'Success';
      }
      return 'Failed';
    } on FirebaseAuthException catch (error) {
      print('error = ${error.code}');
      if (error.code == 'wrong-password') {
        return 'Incorrect Password';
      } else if (error.code == 'invalid-email') {
        return 'Invalid Email';
      } else if (error.code == 'user-disabled') {
        return 'User is disabled';
      } else if (error.code == 'user-not-found') {
        return 'User not found. Try creating an account';
      }
      return 'Failed';
    } catch (e) {
      print(e.toString());
      return 'Failed';
    }
  }
}
