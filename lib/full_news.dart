import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
//import 'package:parroquiamar/details_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';




class Full_News extends StatefulWidget {
  @override
  _Full_NewsState createState() => new _Full_NewsState();
 }

class _Full_NewsState extends State<Full_News > {
  
  final _dialVisible=true;
  
  // Base URL for our wordpress API
  final String apiUrl = "http://parroquiamar.com/wp-json/wp/v2/";
  // Empty list for our posts
  List posts;
  int paginaActual=1;


  // Function to fetch list of posts
   Future<String> getPosts(int page) async {
    
    var res = await http.get(Uri.encodeFull(apiUrl + "posts/?page="+page.toString()), headers: {"Accept": "application/json"});

    print("PAGINA A VISITAR="+apiUrl + "posts/?page="+page.toString());

    // fill our posts list with results and update state
    if(mounted)
      setState(() {
      if (res.statusCode == 200) 
          {          
        var resBody = json.decode(res.body);
          posts = resBody;
        }
        else if(page > 40)
          {
            showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 5), () {
                            Navigator.of(context).pop(true);
                          });
                          return AlertDialog(
                            title: Text('No hay noticias más antiguas'),
                          );          
                        }
                        );

          }
        }
        
        );

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getPosts(paginaActual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: new AppBar(
                    title: new Text("Parroquia Ntra. Señora del Mar",
                                style: new TextStyle(fontSize: 18.0),),
                centerTitle: true,
                backgroundColor: Colors.blueAccent,               
                ),

            body: Container(
              child:    ListView.builder(
                itemCount: posts == null ? 0 : posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Card(
                          child: Column(
                            children: <Widget>[
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
                                /*
                                Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(posts, index)
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
            ),    
          ),
            floatingActionButton: 
              SpeedDial(
                // both default to 16
                marginRight: 18,
                marginBottom: 20,
                animatedIcon: AnimatedIcons.menu_close,
                animatedIconTheme: IconThemeData(size: 22.0),
                // this is ignored if animatedIcon is non null
                // child: Icon(Icons.add),
                visible: _dialVisible,
                // If true user is forced to close dial manually 
                // by tapping main button and overlay is not rendered.
                closeManually: false,
                curve: Curves.bounceIn,
                overlayColor: Colors.black,
                overlayOpacity: 0.5,
                onOpen: () => print('OPENING DIAL'),
                onClose: () => print('DIAL CLOSED'),
                tooltip: 'Speed Dial',
                heroTag: 'speed-dial-hero-tag',
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 8.0,
                shape: CircleBorder(),
                children: [
                  SpeedDialChild(
                    child: Icon(MdiIcons.arrowRightDropCircleOutline),
                    backgroundColor: Colors.blueAccent,
                    label: 'Noticias anteriores',
                    labelStyle: TextStyle(fontSize: 18.0),
                    onTap: () {
                                print("OK");
                                paginaActual=paginaActual+1;
                                getPosts(paginaActual);
                              }

                  ),
                  SpeedDialChild(
                    child: Icon(MdiIcons.arrowLeftDropCircleOutline),
                    backgroundColor: Colors.blue,
                    label: 'Noticias posteriores',
                    labelStyle: TextStyle(fontSize: 18.0),
                    onTap: () {
                              if (paginaActual > 1)
                                {
                                paginaActual=paginaActual-1;
                                print("PAG" + paginaActual.toString());
                                getPosts(paginaActual);
                                }
                              else 
                                {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(Duration(seconds: 5), () {
                                      Navigator.of(context).pop(true);
                                    });
                                    return AlertDialog(
                                      title: Text('No hay noticias más recientes'),
                                    );          
                                  }
                                  );
                                }
                              }

                  ),
                ],
              ),  
          );
        }
  
}



_launchURL(String url) async {

  if (await canLaunch(url)) { 
    await launch(url, forceWebView: true); //forceWebView
  } else {
    throw 'Could not launch $url';
  }

}