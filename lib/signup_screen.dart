import 'dart:convert';
import 'dart:ui';

import 'package:auth_with_api/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _signup(String email, String password) async {

    try{

      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),

        body: {
          'email' : email,
          'password' : password,
        }
      );

      if(response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print('Token : ' + data['token'].toString());

        print('Create Account Successfully!');

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));

      } else {
        print('Create Account Failed!');
      }

    }catch(e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Signup Screen',
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
            const SizedBox(height: 20.0,),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),

            const SizedBox(height: 20.0,),
            InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: (){
                _signup(emailController.text.toString(), passwordController.text.toString());
              },
              child: Ink(
                height: 50.0,
                width: window.physicalSize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.cyan,
                ),
                child: const Center(
                  child: Text('Sign up',
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
