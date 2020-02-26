import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class YoutubePlayerScreen extends StatefulWidget {
//  VideoPlayerScreen({Key key}) : super(key: key);
String urlMedia;
String title;
String thumbnail;
String channelTitle;
String description;
  YoutubePlayerScreen({this.urlMedia,this.title,this.thumbnail,this.channelTitle,this.description});
  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  YoutubePlayerController  _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    String videoId;
    videoId = YoutubePlayer.convertUrlToId(widget.urlMedia);
    _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
            forceHideAnnotation: true,
        ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  
@override
Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: new Text("Parroquia Ntra. Señora del Mar",
                                style: new TextStyle(fontSize: 18.0),),            
              centerTitle: true,
                backgroundColor: Colors.blueAccent,  
                actions: <Widget>[
                        IconButton(
                          icon: new Image.asset("assets/images/no_image.png"),
                          onPressed: () {
                            // do something
                          },
                        )
                      ],),
      backgroundColor: Colors.blue[50],
      body: Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[ Card(
                                        color:Colors.white,
                                        child: Text(widget.title,
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[800],
                                           ),
                                          ),
                                        ),
                                      
                                      new Padding(padding: EdgeInsets.only(bottom: 4.5)),
                                      new Divider(height: 10.0,),

                                      YoutubePlayer(
                                    controller: _controller,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.amber,
                                    progressColors: ProgressBarColors(
                                                    playedColor: Colors.amber,
                                                    handleColor: Colors.amberAccent,
                                                ),
                                    onReady: () {
                                                print('Player is ready.');
                                                },
                                    thumbnailUrl: widget.thumbnail
                                    ),
                                      new Padding(padding: EdgeInsets.only(bottom: 10)),
                                      Text(widget.urlMedia,
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.lightBlueAccent,
                                           ),
                                          ),
                                      new Padding(padding: EdgeInsets.only(bottom: 10)),
                                      Container(
                                        color:Colors.white,
                                        child:  Text(widget.description,
                                                  textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.blue[400],
                                                      ),
                                                ),
                                          )
                           ]
              ),
    );
  }
}