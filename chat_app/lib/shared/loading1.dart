import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading1 extends StatelessWidget {
  const Loading1({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: Colors.purpleAccent[400],
    );
  }
}
