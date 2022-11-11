import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late FancyDrawerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FancyDrawerController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {}); // Must call setState
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FancyDrawerWrapper(
      backgroundColor: Colors.black,
      controller: _controller,
      drawerItems: const [
        CircleAvatar(
          backgroundColor: Colors.black,
        )
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
              onPressed: () {},
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
