import 'package:googleapis/youtube/v3.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'dart:core';
import 'package:parroquiamar/youtube_player.dart';

  GlobalKey<RefreshIndicatorState> _refreshKeyYoutube;

class Youtube extends StatefulWidget {
  ListView menuLateral;
  Youtube({this.menuLateral});

  @override
  _YoutubeState createState() => new _YoutubeState();
 }
class _YoutubeState extends State<Youtube> {

static String key = "AIzaSyASnejgf2y5Mj5VuIb1cT_DNOzUcILSsWY"; // ** ENTER YOUTUBE API KEY HERE **

  YoutubeAPI ytApi = new YoutubeAPI(key);
  List<YT_API> ytResult;

  call_API() async {
    print('UI callled');
    ytResult = await ytApi.channel("UCmfKy4_JWomY6hM5488ZjJQ");
    setState(() {
      print('UI Updated');
      
    });
  }


isChannelEmpty() {
    return( null == ytResult || null == ytResult.length);

  }
 
  body_youtube(BuildContext context) {
    return isChannelEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
                itemCount: ytResult.length,
                itemBuilder: (_, int index) => ListItem(index,context)
                );       
  }

 @override
   void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    call_API();
//    _refreshKeyYoutube = GlobalKey<RefreshIndicatorState>();
    print('hello');
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
          appBar: new AppBar(
                title: new Text("Parroquia Ntra. Señora del Mar",
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
                      ],
                ),

          drawer: new Drawer(
                        child: widget.menuLateral,              
                        ),
          body: body_youtube(context),          
      );
  }

  Widget ListItem(index,BuildContext context){

    return new InkWell(
      onTap: () => {
//                  print("HOLA " + ytResult[index].url.replaceAll(' ', '')+","+ytResult[index].thumbnail['default']['url']),
                   Navigator.push(context,MaterialPageRoute(builder: (context) => 
                        YoutubePlayerScreen(urlMedia: ytResult[index].url.replaceAll(' ', ''),
                                            title: ytResult[index].title,
                                            thumbnail: ytResult[index].thumbnail['default']['url'],
                                            channelTitle: ytResult[index].channelTitle,
                                            description: ytResult[index].description
                                            ))),
               },
      child:
            new Card(              
              child: new Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child:new Row(
          children: <Widget>[
            new Image.network(ytResult[index].thumbnail['default']['url'],),
            new Padding(padding: EdgeInsets.only(right: 20.0)),
            new Expanded(child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  ytResult[index].title,
                  softWrap: true,
                  style: TextStyle(fontSize:18.0),
                ),
                new Padding(padding: EdgeInsets.only(bottom: 1.5)),
                new Text(
                  ytResult[index].channelTitle,
                  softWrap: true,
                ),
                new Padding(padding: EdgeInsets.only(bottom: 3.0)),
                new Text(
                  ytResult[index].url,
                  softWrap: true,
                ),
              ]
            ))
          ],
        ),
      ),
  
            ),

    );
  }
}

  
_launchURL(String url) async {

  if (await canLaunch(url)) { 
    await launch(url); //forceWebView
  } else {
    throw 'Could not launch $url';
  }

}