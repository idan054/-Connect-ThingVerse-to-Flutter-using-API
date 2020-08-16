import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  void _incrementCounter() {

    setState(() {
      _counter++;
    });
  }


  get()async{
    var authorizationToken = "";
    final response = await http.get('https://api.thingiverse.com/users/idan054/likes',
        //Insert your Link you like to use here https://www.thingiverse.com/developers/rest-api-reference
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "Bearer 5ddb8eeeb534d2e001918930d35bxxxx"
          //Insert your App Token Here http://prntscr.com/u0nowl
        });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      return jsonData;
    }

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(child: FutureBuilder(future:get(),builder: (context,snapshot){
          if(snapshot.hasData)
          {
            print(snapshot.data[0]["name"].toString());
            return Text(snapshot.data[0]["name"].toString());
          }
          else{
            return Text('');
          }
        },)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
