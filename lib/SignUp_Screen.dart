import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

final FirebaseAuth  reg = FirebaseAuth.instance;

class SignUp extends StatefulWidget{
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp>{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool success;
  late String email;

  void _register() async{
    final User? user = (
    await reg.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
    ).user;

    if(user != null){
      setState(() {
        success = true;
        User email = user.email as User;
      });
    }
    else{
      setState(() {
        success = false;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) =>
            Scaffold(
              appBar: AppBar(
                title: Text("Register"),
                backgroundColor: Colors.deepOrange,
              ),
              body: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/sun.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        "Register",
                        style: const TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                        textScaleFactor: 3,
                      ),
                    ),

                    // Username Textfield
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Username'),
                      ),
                    ),

                    // Password Textfield
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true, // Hide the password input
                      ),
                    ),

                    // Button to bring you to the main page
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent),
                      child: Text('Register'),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return Home();
                            }));
                      },
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }

}