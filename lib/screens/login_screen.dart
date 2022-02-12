import 'package:firebase_windows/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../Firebase/firebase_servcies.dart';
import '../main.dart';
import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
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
            Center(child: Image.network("https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png",height: 200,)),
            Form(
              key:_formKey,
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
                              controller:emailController,
                              validator: (value) {
                                if(value!.isEmpty)
                                {
                                  return "Email can't be blanked";
                                }
                              },
                              decoration:  const InputDecoration(
                                  label: Text("Email"),
                                  contentPadding: EdgeInsets.all(10),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  hintText:  "example.com",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green,width: 1),
                                      gapPadding: 10
                                  )
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
                                controller:passwordController,
                                validator: (value) {
                                  if(value!.isEmpty)
                                  {
                                    return "Password can't be blanked";
                                  }
                                  else if(value.length<6) {
                                    return "Password should be 6 characters long";

                                  }},
                                decoration:  const InputDecoration(
                                    label: Text("Password"),
                                    contentPadding: EdgeInsets.all(10),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    hintText:  "*******",
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green,width: 1),
                                        gapPadding: 10
                                    )
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
                  firebaseServices.logIn(
                      eml: emailController.text, ps: passwordController.text)
                      .then((user) {

                    if(user!=null)
                    {
                      setState(() {
                      emailController.clear();
                      passwordController.clear();
                    });
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    }
                  }).catchError((error){
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
                  decoration:  BoxDecoration(
                    color: const Color(0XFF4D47C3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text("Login",style:  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
