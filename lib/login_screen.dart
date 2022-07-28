import 'dart:ui';
import 'dart:convert';

import 'package:auth_with_api/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login(String email, String password) async {
    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/login'), body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print('Token : ' + data['token'].toString());

        print('login Successfully!');

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              tokenText: data['token'].toString(),
            ),
          ),
        );
      } else {
        print('login Failed!');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Login Screen',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email Address',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                _login(emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: Ink(
                height: 50.0,
                width: window.physicalSize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.cyan,
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
