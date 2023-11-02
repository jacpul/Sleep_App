import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateReminder extends StatefulWidget {
  @override
  _CreateReminder createState() => _CreateReminder();
}

class _CreateReminder extends State<CreateReminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create a Reminder')),
      backgroundColor: Colors.white,

    );
  }
}