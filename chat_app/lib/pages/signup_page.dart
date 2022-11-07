import 'dart:async';

import 'package:chat_app/auth&database/authmethods.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/shared/loading1.dart';
import 'package:chat_app/shared/shared_properties.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  Timer? _timer;
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _namecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Sign Up'),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/signUp.png'),
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
                        textEditingController: _namecontroller,
                        hintText: 'Enter Your name',
                        labelText: 'Name',
                        textInputType: TextInputType.text,
                        icon: const Icon(
                          Icons.abc_sharp,
                          color: Colors.purple,
                        ),
                      ),
                    ),
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
                        hintText: 'Create a Password',
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
                          print('name = ${_namecontroller.text}');
                          print('text = ${_emailcontroller.text}');
                          print('pass = ${_passwordcontroller.text}');
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              _isloading = true;
                            });
                            bool f = await AuthMethods().signUp(
                              _emailcontroller.text,
                              _passwordcontroller.text,
                              _namecontroller.text,
                            );
                            print("hello");
                            print(f);
                            setState(() {
                              _isloading = false;
                            });
                            if (f) {
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
                                      backgroundColor: Colors.grey,
                                      elevation: 5,
                                      title: Text(
                                        'Your Account was successfully created',
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
                              const AlertDialog(
                                title: Text('Failed'),
                                content: Text(
                                    'Some Error Occured. Try Again Later.'),
                              );
                            }
                          }
                        },
                        child: _isloading
                            ? Loading1(color: Colors.purpleAccent)
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
                                      'SignUp',
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
                    () => const LoginPage(),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: "Already Have an Account? ",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'LogIn Here',
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
