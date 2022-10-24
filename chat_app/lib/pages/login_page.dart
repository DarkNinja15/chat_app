import 'package:chat_app/shared/shared_properties.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Login'),
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
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: TextForm(
                        hintText: 'Enter Your username',
                        labelText: 'Username',
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: TextForm(
                        hintText: 'Enter Your Password',
                        labelText: 'Password',
                        textInputType: TextInputType.text,
                        obscure: true,
                      ),
                    ),
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
