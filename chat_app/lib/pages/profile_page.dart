import 'package:chat_app/shared/loading1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userdata = {};
  bool _isloading = false;
  String profileImageUrl = '';
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    setState(() {
      _isloading = true;
    });
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final usersnap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userdata = usersnap.data()!;
      print(userdata['name']);
      if (userdata['profilePic'] != null) {
        profileImageUrl = userdata['profilePic'];
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Scaffold(
            body: Loading1(
              color: Colors.purpleAccent,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.purpleAccent,
              title: const Text('Your Profile'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    profileImageUrl == ''
                        ? const Icon(
                            Icons.account_circle,
                            size: 150,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                NetworkImage(userdata['profilePic']),
                            radius: 64,
                          ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Name'),
                          Text(userdata['name']),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Email'),
                          Text(userdata['email']),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
