import 'package:firebase_windows/Firebase/firebase_servcies.dart';
import 'package:firebase_windows/screens/login_screen.dart';
import 'package:firebase_windows/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions:[
        IconButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          icon: const Icon(Icons.logout,color: Colors.green,),
        ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome"),
            const SizedBox(height: 50,),
            Text(firebaseServices.user!.email.toString()),
          ],
        ),
      ),
    );
  }
}
