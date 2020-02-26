import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class VideoPlayerScreen extends StatefulWidget {
//  VideoPlayerScreen({Key key}) : super(key: key);
String urlMedia;
String title;
  VideoPlayerScreen({this.urlMedia,this.title});
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {

    // Using an mp3 file instead of mp4.
    _controller = VideoPlayerController.network(widget.urlMedia);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),
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
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // not wrapped in an AspectRatio widget
            return VideoPlayer(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}