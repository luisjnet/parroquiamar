import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';




class ResultadoBusqueda extends StatefulWidget {
   List posts;
  ResultadoBusqueda({this.posts});

  @override
  _ResultadoBusquedaState createState() => new _ResultadoBusquedaState();
 }

class _ResultadoBusquedaState extends State<ResultadoBusqueda> {
  
@override
   void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:    ListView.builder(
          itemCount: widget.posts == null ? 0 : widget.posts.length,
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
                                  widget.posts[index]["title"]["rendered"],
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                                )
                            ),
                            subtitle: new Text(
                              widget.posts[index]["excerpt"]["rendered"].replaceAll(new RegExp(r'<[^>]*>'), '').replaceAll(new RegExp(r'&nbsp;'),' ').substring(0,widget.posts[index]["excerpt"]["rendered"].replaceAll(new RegExp(r'<[^>]*>'), '').replaceAll(new RegExp(r'&nbsp;'),' ').indexOf("Comparte esto"))
                          ),
                        onTap: 
                        ()                         
                        {
                          _launchURL(widget.posts[index]["link"]);
                        
/*                          Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(widget.posts, index)
                          )
                          );
*/                      },

                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
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