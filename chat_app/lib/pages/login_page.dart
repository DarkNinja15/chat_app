import 'package:chat_app/pages/signup_page.dart';
import 'package:chat_app/shared/shared_properties.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
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
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: TextForm(
                        hintText: 'Enter Your username',
                        labelText: 'Username',
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: TextForm(
                        hintText: 'Enter Your Password',
                        labelText: 'Password',
                        textInputType: TextInputType.text,
                        obscure: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {},
                        child: PhysicalModel(
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
                                  fontFamily: GoogleFonts.roboto().fontFamily,
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
