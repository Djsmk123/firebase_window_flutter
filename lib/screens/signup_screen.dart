import 'package:firebase_windows/Firebase/firebase_servcies.dart';
import 'package:firebase_windows/screens/home_screen.dart';
import 'package:firebase_windows/screens/login_screen.dart';
import 'package:flutter/material.dart';

///Global Object for class firebase
final firebaseServices = FirebaseService();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image.network(
              "https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png",
              height: 200,
            )),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email can't be blanked";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text("Email"),
                                contentPadding: EdgeInsets.all(10),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "example.com",
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 1),
                                  gapPadding: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password can't be blanked";
                                  } else if (value.length < 6) {
                                    return "Password should be 6 characters long";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  label: Text("Password"),
                                  contentPadding: EdgeInsets.all(10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "*******",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 1),
                                    gapPadding: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  firebaseServices
                      .signUp(
                          eml: emailController.text,
                          ps: passwordController.text)
                      .then((user) {
                    if (user != null) {
                      setState(() {
                        emailController.clear();
                        passwordController.clear();
                      });
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    }
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      elevation: 10,
                      content: Text('Error!!!\n ${error.toString()}'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                    ));
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0XFF4D47C3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "If you already have an account",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Login Here!",
                    style: TextStyle(color: Color(0XFF4D47C3)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
