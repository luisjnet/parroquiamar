import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:parroquiamar/full_news.dart';
import 'package:parroquiamar/search.dart';
import 'package:transparent_image/transparent_image.dart';

    final _root = 'http://parroquiamar.com'; //replace with your site url
    final wp.WordPress wordPress = wp.WordPress(baseUrl: _root);


class Noticias extends StatefulWidget {

   ListView menuLateral;
    Noticias({this.menuLateral});

  @override
  _NoticiasState createState() => new _NoticiasState();
 }
class _NoticiasState extends State<Noticias> with TickerProviderStateMixin{
  
  // Base URL for our wordpress API
  final String apiUrl = "http://parroquiamar.com/wp-json/wp/v2/";
  // Empty list for our posts
  List posts;
  List postsFull;

  // Function to fetch list of posts
   Future<String> getPosts() async {

    var res = await http.get(Uri.encodeFull(apiUrl + "posts?_embed"), headers: {"Accept": "application/json"});
    var resFull = await http.get(Uri.encodeFull(apiUrl + "posts"), headers: {"Accept": "application/json"});

    // fill our posts list with results and update state
    if(mounted)
      setState(() {
        if (res.statusCode == 200) 
          {
          var resBody = json.decode(res.body);
          posts = resBody;
          }
        if (resFull.statusCode == 200) 
          {
          var resBodyFull = json.decode(resFull.body);
          postsFull = resBodyFull;
          }
      });

    return "Success!";
  }


ListView menuFloatButton= new ListView(
    children: <Widget>[
           new ListTile(
             contentPadding: new EdgeInsets.only(left: 50.0),
  //            leading: new Icon(MdiIcons.accountMultiple),
              title: new Text("Consejo Pastoral"),        
              onTap: () {}
            ), 
           new ListTile(
             contentPadding: new EdgeInsets.only(left: 50.0),
              title: new Text("Cáritas"),        
              onTap: () {}
            ),
            new ListTile(
             contentPadding: new EdgeInsets.only(left: 50.0),
              title: new Text("Catequesis de Iniciación Cristiana"),        
              onTap: () {}
            ),
    ],
  );


  @override
  void initState() {
    super.initState();
    this.getPosts();
  }


isBlogEmpty() {
    return null == posts || null == posts.length;
  }
 
  bodyBlog() {
    return isBlogEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : new ListView.builder(
            itemCount: posts == null ? 0 : posts.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        new FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                            image: posts[index]["featured_media"] == 0
                                  ? 'images/logo-parroquia-transparente.png'
                                  : posts[index]["_embedded"]["wp:featuredmedia"][0]["source_url"],
                          ),
                        new Padding(
                          padding: EdgeInsets.all(10.0),
                          child: new ListTile(
                            title: new Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0), 
                                child: new Text(
                                  posts[index]["title"]["rendered"],
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                                )
                            ),
                            subtitle: new Text(
                              posts[index]["excerpt"]["rendered"].replaceAll(new RegExp(r'<[^>]*>'), '').replaceAll(new RegExp(r'&nbsp;'),' ').substring(0,posts[index]["excerpt"]["rendered"].replaceAll(new RegExp(r'<[^>]*>'), '').replaceAll(new RegExp(r'&nbsp;'),' ').indexOf("Comparte esto"))
                          ),
                        onTap: () {
                          
                          _launchURL(posts[index]["link"]);
                          

                                   

/*                          Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(postsFull, index)
                          )
                        );
*/                        
                      },

                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );   
          
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
          
      body: bodyBlog(),
          

      floatingActionButton: new SpeedDial(
      animatedIcon: AnimatedIcons.list_view,
      animatedIconTheme: IconThemeData(size: 22.0),
      // this is ignored if animatedIcon is non null
      // child: Icon(Icons.add),
      visible: true,
      curve: Curves.bounceIn,
      overlayColor: Colors.white,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL Cerrado'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Theme.of(context).accentColor,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(Icons.library_books),
          backgroundColor: Theme.of(context).accentColor,
          label: 'Todas las Noticias',
          onTap: () {
                          Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Full_News()
                          )
                          );
                      },
        ),
        SpeedDialChild(
          child: Icon(Icons.find_in_page),
          backgroundColor: Theme.of(context).accentColor,
          label: 'Buscar',
          onTap: () {
                          Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Search()
                          )
                          );
                      },
        ),
      ],
    ),
      
      ); 
  }
}



 _launchURL(String url) async {

  if (await canLaunch(url)) { 
    await launch(url, forceWebView: true,
    forceSafariVC: true,
    enableJavaScript: true); //forceWebView
  } else {
    throw 'Could not launch $url';
  }

}