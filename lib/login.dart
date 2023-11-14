import 'package:firebase_auth/firebase_auth.dart';
import 'package:units/main.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:units/login.dart';
import 'register_screen.dart';

Future goToSignUp(BuildContext context) async {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RegisterPage(showLoginPage: () {  },),
      )
  );
}

class Loginpage extends StatefulWidget {

  @override
  _Loginpage createState() => _Loginpage();

}

class _Loginpage extends State<Loginpage>  {

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    Future signIn(BuildContext context) async {
      print('login button tapped'); // Add this line
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          )
      );
    }

    @override
    void dispose(){
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

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

                      // login button
                      InkWell(
                        onTap: () => signIn(context),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          color: Colors.blue,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => goToSignUp(context),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          color: Colors.blue,
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      )
                    ]
                ),
              ),
            ),
      ),
    );
  }
}


