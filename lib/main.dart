import 'package:flutter/material.dart';
import 'package:fetch_data/hero_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:percent_indicator/linear_percent_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List responseList;
  bool _loading;

  getHeroes() async {
    setState(() {
      _loading = true;
    });

    final response = 
      await http.get(Uri.parse('https://akabab.github.io/superhero-api/api/all.json'));
    List decodedJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        responseList = decodedJson;
        _loading = false;
      });
    } else {
      print("Something went wrong");
      setState(() {
        _loading = true;
      });
    }
  }

    // Build loading widget
   _buildProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Build List Heroes
  _buildList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          HeroItem heroItem = HeroItem.fromJson(responseList[index]);
          return Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Card(
              color: Colors.grey.withOpacity(0.4),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                heroItem.images.md,
                              ),
                              
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  heroItem.name,
                                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  heroItem.biography.fullName.isEmpty
                                    ? heroItem.name
                                    : heroItem.biography.fullName,
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.book,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Flexible(
                                      child: Text(
                                        heroItem.biography.publisher,
                                        style: TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // INTELLIGENCE
                                      Text(
                                        "Intelligence".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500, 
                                          color: Colors.white
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      new LinearPercentIndicator(
                                        animation: true,
                                        lineHeight: 14.0,
                                        animationDuration: 2500,
                                        percent: heroItem.powerstats.intelligence.toDouble() / 100.0,
                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        progressColor: Colors.blue,
                                      ),
                                      
                                      SizedBox(
                                        height: 18.0,
                                      ),

                                      // STRENGTH
                                      Text(
                                        "Power".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500, 
                                          color: Colors.white
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      new LinearPercentIndicator(
                                        animation: true,
                                        lineHeight: 14.0,
                                        animationDuration: 2500,
                                        percent: heroItem.powerstats.power.toDouble() / 100.0,
                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        progressColor: Colors.red,
                                      ),
                                      
                                      SizedBox(
                                        height: 18.0,
                                      ),

                                      // SPEED
                                      Text(
                                        "Speed".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500, 
                                          color: Colors.white
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      new LinearPercentIndicator(
                                        animation: true,
                                        lineHeight: 14.0,
                                        animationDuration: 2500,
                                        percent: heroItem.powerstats.speed.toDouble() / 100.0,
                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        progressColor: Colors.green,
                                      ),
                                      
                                      SizedBox(
                                        height: 18.0,
                                      ),

                                      // DURABILITY
                                      Text(
                                        "Durability".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500, 
                                          color:  Colors.white
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      new LinearPercentIndicator(
                                        animation: true,
                                        lineHeight: 14.0,
                                        animationDuration: 2500,
                                        percent: heroItem.powerstats.durability.toDouble() / 100.0,
                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        progressColor: Colors.orangeAccent,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getHeroes();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Color(0xff121212),
        centerTitle: true,
        title: Text('SUPERHEROES', style: TextStyle(color: Colors.white)),
      ),
     body: _loading
      ? _buildProgressIndicator()
      : _buildList(),
    );
  }
}
