import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
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

  /**
   * Creates a popup if your login information is invalid.
   *
   * Inputs: None
   * Outputs: Creates a popup that tells you there is a error with
   * the login information
   *
   */
  void showInvalidLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Information'),
          content: Text('You have entered an incorrect email and or password. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    Future signIn(BuildContext context) async {
      try {
        print('login button tapped');
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        // If an exception is thrown, show the invalid login dialog
        showInvalidLoginDialog(context);
      }
    }

    @override
    void dispose(){
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
                          decoration: InputDecoration(labelText: 'Email'),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /**
                           * A click on this button takes you to the register page
                           *
                           * Input: A tap on the button that says register
                           *
                           *Output: The screen changing to the register screen
                           *
                           */
                          InkWell(
                            onTap: () => goToSignUp(context),
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              color: Colors.blueAccent,
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          /**
                           * Tries and logs you into the app, with the account that
                           * you already have in firebase
                           *
                           * Input: A tap on the login button
                           *
                           * Output: If successfully logs in brings you to the home page
                           * if not a popup tells you what went wrong
                           *
                           */
                          InkWell(
                            onTap: () => signIn(context),
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              color: Colors.blueAccent,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                ),
              ),
            ),
      ),
    );
  }
}


