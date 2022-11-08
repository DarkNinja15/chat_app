import 'dart:async';

import 'package:chat_app/pages/signup_page.dart';
import 'package:chat_app/shared/loading1.dart';
import 'package:chat_app/shared/loading2.dart';
import 'package:chat_app/shared/shared_properties.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth&database/authmethods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  Timer? _timer;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text('LogIn'),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/login.png'),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextForm(
                        textEditingController: _emailcontroller,
                        hintText: 'Enter Your email',
                        labelText: 'email',
                        textInputType: TextInputType.emailAddress,
                        icon: const Icon(
                          Icons.mail,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextForm(
                        textEditingController: _passwordcontroller,
                        hintText: 'Enter Your Password',
                        labelText: 'Password',
                        textInputType: TextInputType.text,
                        obscure: true,
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            String? f = await AuthMethods().login(
                              _emailcontroller.text,
                              _passwordcontroller.text,
                            );
                            print("hello");
                            print(f);
                            setState(() {
                              _isLoading = false;
                            });
                            if (f == 'Success') {
                              showDialog(
                                context: context,
                                builder: (BuildContext buildcontext) {
                                  _timer =
                                      Timer(const Duration(seconds: 5), () {
                                    Navigator.of(context).pop();
                                  });
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text(
                                        'Welcome Back',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              GoogleFonts.lobster().fontFamily,
                                        ),
                                      ),
                                      content: Text(
                                        'Preparing your Dashboard\n\nPlease Wait',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.lobster().fontFamily,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => print('ho gya bhai!!'));
                            } else {
                              await Future.delayed(const Duration(seconds: 1));
                              if (!mounted) return;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  f,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.lato().fontFamily,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }
                        },
                        child: _isLoading
                            ? Loading1(
                                color: Colors.purpleAccent,
                              )
                            : PhysicalModel(
                                color: Colors.transparent,
                                shadowColor: Colors.purple.shade200,
                                elevation: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    25.0,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: double.infinity,
                                    color: Colors.purple,
                                    child: Text(
                                      'LogIn',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.roboto().fontFamily,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Shared().navigate(
                    context,
                    () => const SignUpPage(),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: "Don't Have an Account? ",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'SignUp Here',
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
