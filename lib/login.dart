
import 'package:firebase_auth/firebase_auth.dart';
import 'package:units/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:units/login.dart';
import 'register_screen.dart';

class Loginpage extends StatefulWidget {

  @override
  _Loginpage createState() => _Loginpage();

}

class _Loginpage extends State<Loginpage>  {

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return MaterialApp(
      home: Builder(
        builder: (context) =>
            Scaffold (
              appBar: AppBar(
                title: Text("Login"),
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
                        "Login",
                        style: const TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                        textScaleFactor: 3,
                      ),
                    ),

                    // Username Textfield
                    Padding (
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Username'),
                        controller: _emailController,
                      ),
                    ),

                    // Password Textfield
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Password'),
                        controller: _passwordController,
                        obscureText: true, // Hide the password input
                      ),
                    ),

                    // Button to bring you to the main page
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent),
                      child: Text('Login'),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              testLogin(_emailController.text.trim(), _passwordController.text.trim());
                              return Loginpage();
                            }));
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent),
                      child: Text('Register'),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return RegisterPage(showLoginPage: () {  },);
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



