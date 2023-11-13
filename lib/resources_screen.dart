import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:html' as html;


class ResourcesScreen extends StatefulWidget {
  @override
  _ResourcesScreen createState() => _ResourcesScreen();
}

class _ResourcesScreen extends State<ResourcesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources"),
          backgroundColor: Colors.deepOrangeAccent
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Online Resources').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Text("No Data Available")
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document){
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width /1.2,
                  height: MediaQuery.of(context).size.height/6,
                  child: Column(
                    children: <Widget>[
                      Text(document["title"], style: const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 22,
                          )),
                      //Text("URL: "+ document["url"]),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                      ),
                          child: Text('Open Link',  style: const TextStyle(fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.white),
                            textAlign: TextAlign.center),
                          onPressed: () async {
                            final url = document["url"];

                            if (await canLaunch(url)) {
                              await launch(
                                  url,
                                  forceWebView: true,
                                enableJavaScript: true,
                              );
                            }
                            }
                      )
                    ]
                  )
                  ),
              );
            }).toList(),
          );
        }
      ),
      backgroundColor: Colors.yellow.shade800,
    );
  }
}