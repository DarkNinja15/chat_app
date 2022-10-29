import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/shared/shared_properties.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: TextForm(
                        hintText: 'Enter Your email',
                        labelText: 'Username',
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: TextForm(
                        hintText: 'Create a Password',
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
                                'SigUp',
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
