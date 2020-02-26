import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:parroquiamar/calendar.dart';
import 'package:parroquiamar/noticias.dart';
import 'package:parroquiamar/youtube.dart';
import 'package:parroquiamar/podcast.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new MaterialApp(
    home: new Parroquiamar(),
  ));
}

class Parroquiamar extends StatefulWidget {
  @override
  _ParroquiamarState createState() => new _ParroquiamarState();
}

class _ParroquiamarState extends State<Parroquiamar> {
  @override
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 5), onClose);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Align(
          alignment: FractionalOffset.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    'assets/images/Logonuevoparroquia.jpg',
                    height: 630.0,
                    width: 293.0,
                  ),
                ],
              )
            ],
          )),
    );
  }

  void onClose() {
    Navigator.of(context).pushReplacement(new PageRouteBuilder(
        maintainState: true,
        opaque: true,
        pageBuilder: (context, _, __) => new Home(),
        transitionDuration: const Duration(seconds: 2),
        transitionsBuilder: (context, anim1, anim2, child) {
          return new FadeTransition(
            child: child,
            opacity: anim1,
          );
        }));
  }
}


class Home extends StatefulWidget {

  @override
  _HomeState createState() => new _HomeState();
 }

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController tabBottomController;
  

  ListView menuPrincipal= new ListView(
    children: <Widget>[
      new Container(
        color: Colors.blue[50],
        child: Column(
          children: <Widget>[
                    new DrawerHeader(
                      margin: EdgeInsets.only(top: 1.0,bottom: 1.0),
                      child: new Image.asset("assets/images/banner.png"),),
                    ExpansionTile(       
                      title: Text("Grupos",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                      children: <Widget>[
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                //            leading: new Icon(MdiIcons.accountMultiple),
                            title: new Text(
                              "Consejo Pastoral",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/consejo-pastoral/",false,false,true);}
                          ), 
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Cáritas",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/caritas/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Catequesis de Iniciación Cristiana",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/catequesis-iniciacion-cristiana/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Catequesis de adultos",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/catequesis-adultos/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Catequesis de preparación al Bautismo",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/cataquesis-familiar/",false,false,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Pastoral de la salud",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/pastoral-de-la-salud/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Grupo Joven",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/grupo-joven/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Consejo de Economía",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/consejo-de-economia/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Manos Unidas",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/manos-unidas/",true,true,true);}
                          ),
                        ],
                    ),
                  
                  new Divider(height: 5.0,),

                    ExpansionTile(
                      
                      title: Text("Carismas",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                      children: <Widget>[
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                //            leading: new Icon(MdiIcons.accountMultiple),
                            title: new Text("Camino Neocatecumenal",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/camino-neocatecumenal/",true,true,true);}
                          ), 
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Vida Ascendente",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/vida-ascendente/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Marías de los Sagrarios",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/marias-de-los-sagrarios/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Apostolado de la Oración",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/apostolado-de-la-oracion/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Carisma Cofrade",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/grupo-cofrade/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Pastoral de la salud",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/pastoral-de-la-salud/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Renovación Carismática Católica",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/renovacion-carismatica-catolica/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Oración de las Madres",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/oracion-de-las-madres/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Franciscanos de María",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/franciscanos-de-maria/",true,true,true);}
                          ),
                        ],
                    ),
                  
                  new Divider(height: 5.0,),

                    ExpansionTile(
                      title: Text("Sacramentos",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                      children: <Widget>[
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                //            leading: new Icon(MdiIcons.accountMultiple),
                            title: new Text("Bautismo",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/bautismo/",true,true,true);}
                          ), 
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Penitencia",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/confesion/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Eucaristía",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/eucaristia/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Confirmación",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/confirmacion/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Matrimonio",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/matrimonio/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Orden sacerdotal",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/orden-sacerdotal/",true,true,true);}
                          ),
                          new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Unción de enfermos",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/uncion-de-enfermos/",true,true,true);}
                          ),
                        ],
                    ),

                  new Divider(height: 5.0,),


                  ExpansionTile(        
                      title: Text("Horarios",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                      children: <Widget>[
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                //            leading: new Icon(MdiIcons.accountMultiple),
                            title: new Text("Horario de Misas",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/horario-de-misas/",true,true,true);}
                          ), 
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Horario de Despacho y Archivos",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/horarios-de-despacho-y-archivos/",true,true,true);}
                          ),
                        ],
                    ),     


                  new Divider(height: 5.0,),


                  ExpansionTile(        
                      title: Text("Galerías",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                      children: <Widget>[
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                //            leading: new Icon(MdiIcons.accountMultiple),
                            title: new Text("Templo de Bermejales",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/templo-de-bermejales/",true,true,true);}
                          ), 
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Capilla del Carmen",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/capilla-del-carmen/",true,true,true);}
                          ),
                        ],
                    ),     
                    
                    new Divider(height: 5.0,),

                    ExpansionTile(
                      
                      title: Text("Inscripciones",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                      children: <Widget>[
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                //            leading: new Icon(MdiIcons.accountMultiple),
                            title: new Text("Inscripciones de catequesis",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/inscripciones-catequesis/",false,false,true);}
                          ), 
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Inscripciones de catequesis de adultos",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/inscripcion-catequesis-de-adultos/",false,false,true);}
                          ),
                      ],
                    ),     
                
                new Divider(height: 5.0,),

                
                ExpansionTile(       
                      title: Text("Formación",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                      children: <Widget>[
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                //            leading: new Icon(MdiIcons.accountMultiple),
                            title: new Text("Escuela parroquial de familia 'Stella Maris'",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/escuela-parroquial-familia-stella-maris/",false,false,true);}
                          ), 
                        new ListTile(
                          contentPadding: new EdgeInsets.only(left: 50.0),
                            title: new Text("Escuela de formación 'Evangelii Gaudium'",
                              style: TextStyle(color: Colors.blueAccent),
                              ),        
                            onTap: () {_launchURL("http://parroquiamar.com/evangelii-gaudium/",false,false,true);}
                          ),
                        ],
                    ),     
                  
                  new Divider(height: 5.0,),


                  new ListTile(
                      leading: new Icon(MdiIcons.pen,color: Colors.blueAccent,),
                      title: new Text("Formularios",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                      onTap: () {_launchURL("http://parroquiamar.com/formularios/",true,true,true);}
                    ),

                  new ListTile(
                      leading: new Icon(Icons.add_box,color: Colors.blueAccent,),
                      title: new Text("Columbario",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                      onTap: () {_launchURL("http://parroquiamar.com/columbario/",false,false,true);}
                      
                    ),
                  new ListTile(
                      leading: new Icon(MdiIcons.handHeart,color: Colors.blueAccent,),
                      title: new Text("Colabora",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                      onTap: () {_launchURL("http://parroquiamar.com/colabora/",false,false,true);}
                      
                    ),
                ]
            )
      ),
    ],
  );


  @override
    void initState(){
      super.initState();
      tabBottomController = new TabController(length: 4,vsync: this);
    }

  @override
  Widget build(BuildContext context) {
     return new Scaffold(
          body: new TabBarView(
                    children: <Widget>[
                        new Noticias(menuLateral: menuPrincipal),
                        new Calendar(menuLateral: menuPrincipal,),
                        new Youtube(menuLateral: menuPrincipal,),
                        new Podcast(menuLateral: menuPrincipal,),
                      ],
                    controller: tabBottomController    
                    ),
                    bottomNavigationBar:   new Material(
                      color: Colors.blue[800],
                    child: new TabBar(
                                      tabs: <Tab> [
                                        new Tab(
                                        icon: new Icon(MdiIcons.formatFloatLeft),
                                      ),
                                        new Tab(
                                        icon: new Icon(MdiIcons.calendarMonth),
                                      ),
                                        new Tab(
                                        icon: new Icon(MdiIcons.youtubeSubscription),
                                      ),
                                        new Tab(
                                        icon: new Icon(MdiIcons.headphones),
                                      ),

                                      ],
                                      controller: tabBottomController, 
                                      unselectedLabelColor: Colors.blue[200],
                                      labelColor: Colors.white,
                                      )
                                    ),
                                  
                    ); 
      }
}


   /* WebviewScaffold(
      url: url,
      hidden: true,
      appBar: AppBar(title: Text("Open Web Page URL in webview")),
    );
      WebView(
        initialUrl: url,
      );
*/






_launchURL(String url, bool forceWebView, bool forceSafariVC, bool enableJava) async {

  if (await canLaunch(url)) { 
    await launch(url, 
    forceWebView: forceWebView,
    forceSafariVC: forceSafariVC,
    enableJavaScript: enableJava
    ); //forceWebView
  } else {
    throw 'Could not launch $url';
  }

}