import 'package:flutter/material.dart';
import 'package:parroquiamar/resultado_busqueda.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => new _SearchState();
 }

class _SearchState extends State<Search>  {
  
  final String apiUrl = "http://parroquiamar.com/wp-json/wp/v2/posts?search=";
  // Empty list for our posts
  List posts;
  
String inputValue ="";
final TextEditingController textcontroller = new TextEditingController();

Future<String> getPosts(String search) async {
    
    var res = await http.get(Uri.encodeFull(apiUrl + search), headers: {"Accept": "application/json"});
    print(apiUrl + search);

    // fill our posts list with results and update state
    if(mounted)
      setState(() {
      if (res.statusCode == 200) 
          {          
        var resBody = json.decode(res.body);
          posts = resBody;
          Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) =>ResultadoBusqueda(
            posts: posts)
                      )
                    );
          
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
                    title: Text('No hay noticias con este término'),
                    );          
                  }
                );
          }
        }        
        );

    return "Success!";
  }




 void onSubmitted (String value){
  if(mounted)
    setState(() {
      inputValue=value;
      textcontroller.text="";
      print("Termino "+inputValue.toString());
      this.getPosts(inputValue.toString());

    });
}

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
            appBar: new AppBar(
                    title: new Text("Parroquia Ntra. Señora del Mar",
                                style: new TextStyle(fontSize: 18.0),),
                centerTitle: true,
                backgroundColor: Colors.blueAccent,               
                ),
            body: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new Center(
                      child: new Column(
                        children: <Widget>[
                          new TextField(
                            decoration: new InputDecoration(
                              hintText: "Introduzca el término de búsqueda de noticias",               
                            ),
                            onSubmitted: (String value){
                              onSubmitted(value);
                            },
                            controller: textcontroller,
                            maxLines: 1,
                          ),
                          new Text(inputValue),
                        ],
                        
                      ),
                    )
                  )
                );
  }
}