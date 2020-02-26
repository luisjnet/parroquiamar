import 'package:flutter/material.dart';
import 'dart:core';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:parroquiamar/player.dart';


class Podcast extends StatefulWidget {
  final String title = 'Podcast de la Parroquia de Nuestra Señora del Mar';
  
  ListView menuLateral;
  Podcast({this.menuLateral});

  @override
  _PodcastState createState() => new _PodcastState();
  
 }
class _PodcastState extends State<Podcast> {


 static const String FEED_URL =
      'https://www.ivoox.com/podcast-parroquiamar_fg_f1173676_filtro_1.xml';
  RssFeed _feed;
  String _title;
  static const String loadingFeedMsg = 'Loading Feed...';
  static const String feedLoadErrorMsg = 'Error Loading Feed.';
  static const String feedOpenErrorMsg = 'Error Opening Feed.';
  static const String placeholderImg = 'images/no_image.png';
  GlobalKey<RefreshIndicatorState> _refreshKey;
 
  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }
 
  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }
 /*
 VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
*/
  Future<void> openFeed(RssItem item) async {
    
    Navigator.push(context,MaterialPageRoute(builder: (context) => VideoPlayerScreen(urlMedia: item.enclosure.url,title: item.title)));

/*    _controller = VideoPlayerController.network(url,);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    VideoPlayer(_controller);
    _controller.play();
*/
/*    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
      return;
    }*/
    updateTitle(feedOpenErrorMsg);
  }
 
  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }
 
  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
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
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }
 
  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
 
  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
 
  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset(placeholderImg),
        imageUrl: imageUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }
 
  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30.0,
    );
  }
 
  list() {
    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items[index];
        return ListTile(
          title: title(item.title),
          subtitle: subtitle(item.pubDate),
          leading:  new Image.asset("assets/images/no_image.png"),
//           leading: new Image.asset("assets/images/no_image.png"),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () => openFeed(item),
        );
      },
    );
  }
 
  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }
 
  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: 
          body(),       
    );
  }

}

  
