import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String tokenText;
  const HomeScreen({Key? key, required this.tokenText,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text('Home Screen',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),

      body: Center(
        child: Text('Welcome Token : ${widget.tokenText} '),
      ),
    );
  }
}
