import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  // Text Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();




  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
   // if(passwordConfirmed()){
      print('Sign Up button tapped'); // Add this line
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          )
      );
   // }
  }

  bool passwordConfirmed(){
    if(_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    }else{
      return false;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
        child: Center(
          child: Column(
            children: <Widget>[
              // email textfield
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                )
              ),
              SizedBox(height: 10),

            // password text field
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                )
            ),
              InkWell(
                onTap: () => signUp(),
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
            ],
          ),
        ),
      ),
    );
  }
}