import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/DetailPage.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'Model/Data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<MaterialColor>_color = [Colors.deepOrange,Colors.amber,Colors.red,Colors.green,Colors.purple,Colors.brown];

  Future<List<Data>> getAllData() async {
    var api = "http://jsonplaceholder.typicode.com/photos";
    var data = await http.get(api);
    // Now decode the data
    var jsonData = json.decode(data.body);

    List<Data>ListOf = [];

    for(var i in jsonData){
      Data data = new Data(i["id"],i["title"],i["url"],i["thumbnailUrl"]);
      ListOf.add(data);
    }
    return ListOf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Json Parsing App"),
        backgroundColor: Colors.deepOrange,
        actions: [
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () => debugPrint("Search")
          ),

          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () => debugPrint("Add")
          ),
        ],
      ),
      // Navigation Part

      drawer: new Drawer(
        child: new ListView(
          children: [
            new UserAccountsDrawerHeader(
                accountName: new Text("Ruhul Amin Sujon"),
                accountEmail: new Text("rasujon3@gmail.com"),
              decoration: new BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
            
            new ListTile(
              title: new Text("First Page"),
              leading: new Icon(Icons.search, color: Colors.orange,),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),

            new ListTile(
              title: new Text("Second Page"),
              leading: new Icon(Icons.add, color: Colors.red,),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),

            new ListTile(
              title: new Text("Third Page"),
              leading: new Icon(Icons.title, color: Colors.purple,),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),

            new ListTile(
              title: new Text("Fourth Page"),
              leading: new Icon(Icons.list, color: Colors.green,),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),

            new Divider(
              height: 5.0,
            ),
            new ListTile(
              title: new Text("Close"),
              leading: new Icon(Icons.close, color: Colors.red,),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),

      body: new ListView(
        children: [
          new Container(
            margin: EdgeInsets.all(10.0),
            height: 250.0,
            child: new FutureBuilder(
                future: getAllData(),
              builder: (BuildContext c, AsyncSnapshot snapshot){
                  if(snapshot.data==null){
                    return Center(
                      child: new Text("Loading Data...."),
                    );
                  }else{
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext c,int index){
                          MaterialColor mColor = _color[index % _color.length];
                          return Card(
                            elevation: 10.0,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Image.network(snapshot.data[index].url,

                                  height: 150.0,
                                  width: 150.0,
                                  fit: BoxFit.cover,
                                ),

                                new SizedBox(height: 7.0,),

                                new Container(
                                  margin: EdgeInsets.all(6.0),
                                  height: 50.0,
                                  child: new Row(

                                    children: [
                                      new Container(
                                        child: new CircleAvatar(
                                          child: new Text(snapshot.data[index].id.toString()),
                                          backgroundColor: mColor,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                      new SizedBox(width: 6.0,),

                                      new Container(
                                        width: 80.0,
                                        child: new Text(snapshot.data[index].title,
                                        maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.deepOrange,
                                          ),
                                        ),

                                      )
                                    ],
                                  ),
                                )

                              ],
                            ),
                          );
                      }
                    );
                  }
              }
            ),
          ),//end of first container

          new SizedBox(height: 7.0,),

          new Container(
            margin: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: new FutureBuilder(

                future: getAllData(),
              builder: (BuildContext e, AsyncSnapshot snapshot){

                    if(snapshot.data==null){
                    return Center(
                    child: new Text("Loading Data...."),
                    );
                    }else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext c, int index) {
                          MaterialColor mColor = _color[index % _color.length];
                          return Card(
                            elevation: 7.0,
                            child: Container(
                              height: 80.0,
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new Expanded(
                                    flex: 1,
                                    child: new Image.network(
                                      snapshot.data[index].thumbnailUrl,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  new SizedBox(width: 6.0,),
                                  new Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      child: new Text(snapshot.data[index].title,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      onTap: (){
                                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext c)=>Detail(snapshot.data[index])));
                                      },
                                    ),
                                  ),

                                  //new SizedBox(width: 6.0,),
                                  new Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        child: new Text(
                                            snapshot.data[index].id.toString()),
                                        backgroundColor: mColor,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
              }
            ),
          )

        ],
      ),

    );
  }
}
