import 'package:chat_app/auth&database/authmethods.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:chat_app/pages/search_page.dart';
import 'package:chat_app/shared/loading1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late FancyDrawerController _controller;
  var userdata = {};
  bool _isloading = false;
  String profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    getdata();
    _controller = FancyDrawerController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {}); // Must call setState
      });
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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Scaffold(
            body: Center(
              child: Loading1(
                color: Colors.purpleAccent,
              ),
            ),
          )
        : FancyDrawerWrapper(
            drawerPadding: const EdgeInsets.only(
              right: 40,
            ),
            hideOnContentTap: true,
            itemGap: 1,
            backgroundColor: Colors.white,
            controller: _controller,
            drawerItems: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Center(
                    child: profileImageUrl == ''
                        ? const Icon(
                            Icons.account_circle,
                            size: 150,
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(profileImageUrl),
                          )),
              ),
              Text(
                userdata['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.purple.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.grey),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.people,
                  color: Colors.purpleAccent,
                ),
                label: const Text(
                  'Groups',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.purpleAccent,
                ),
                label: const Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'LogOut',
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                          content: const Text(
                            'Are You sure you want to logout?',
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await AuthMethods().signmeout();
                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                  if (!mounted) return;

                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(
                                    color: Colors.purpleAccent,
                                  ),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.purpleAccent,
                                  ),
                                )),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.purpleAccent,
                ),
                label: const Text(
                  'LogOut',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purpleAccent,
                centerTitle: true,
                elevation: 0,
                title: Text(
                  'Chats',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  )
                ],
                leading: IconButton(
                  onPressed: () {
                    _controller.toggle();
                  },
                  icon: const Icon(
                    Icons.menu,
                  ),
                ),
              ),
            ),
          );
  }
}
