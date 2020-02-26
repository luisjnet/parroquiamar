import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {

  List post;
  int   index;
  DetailsPage(this.post,this.index);

  _getPostImage() {
   return( post[index]["featured_media"] == 0
            ? 'images/logo-parroquia-transparente.png'
          : post[index]["_links"]["wp:featuredmedia"][0]["href"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Text(
                post[index]["title"]["rendered"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              new FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                        image: post[index]["featured_media"] == 0
                               ? 'images/placeholder.png'
                               : post[index]["_links"]["wp:featuredmedia"][0]["href"],
                      ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                           Text(post[index]["content"]["rendered"].replaceAll(new RegExp(r'<[^>]*>'), '').replaceAll(new RegExp(r'&nbsp;'),' ').substring(0,post[index]["content"]["rendered"].replaceAll(new RegExp(r'<[^>]*>'), '').replaceAll(new RegExp(r'&nbsp;'),' ').indexOf("Comparte esto"))),
//                  Text(post.author.name.toString())
                ],
              ),
/*              Html(
                data: post[index]["content"]["rendered"],
                onLinkTap: (String url) {
                  _launchUrl(url);
                },
              )
*/
            ],
          ),
        )

      ),
    );
  }
}

 _launchURL(String url) async {

  if (await canLaunch(url)) { 
    await launch(url, forceWebView: false); //forceWebView
  } else {
    throw 'Could not launch $url';
  }

}