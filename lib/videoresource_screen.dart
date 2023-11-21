import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoResource extends StatefulWidget {
  @override
  _VideoResource createState() => _VideoResource();
}

class _VideoResource extends State<VideoResource> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Online Resources"),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent
      ),

      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Video Resources').snapshots(),
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
                      height: MediaQuery.of(context).size.height/5,
                      child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
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
                            ),
                            Divider(
                              color: Colors.blueAccent,
                              thickness: 3,
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

/*late YoutubePlayerController controller;
void initState(){
  controller = YoutubePlayerController(initialVideoId: https://www.youtube.com/watch?v=eTgNgGO_bLs);
      super.initState();
}
YoutubePlayer(
controller: controller,
showVideoProgressIndicator: true, );*/
