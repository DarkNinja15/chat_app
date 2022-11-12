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
        ? Loading1(color: Colors.purpleAccent)
        : FancyDrawerWrapper(
            backgroundColor: Colors.white,
            controller: _controller,
            drawerItems: [
              const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.purple,
                ),
              ),
              Text(
                userdata['name'],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.purple.shade700,
                  fontWeight: FontWeight.bold,
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
