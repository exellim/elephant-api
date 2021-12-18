import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Elephant>> _getElephant() async {
    var data = await http.get(Uri.parse("https://elephant-api.herokuapp.com/elephants/sex/male"));
    var jsonData = json.decode(data.body);

    List<Elephant> Elephants = [];

    for(var i in jsonData){
      Elephant elephant = Elephant(i["index"], i["name"], i["affiliation"], i["species"], i["sex"],i["note"], i["image"]);

      Elephants.add(elephant);
    }
    print(Elephants.length);

    return Elephants;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: 
        Text('1461900256-ExelensiChristianSimonLimartha-Ujian Praktikum',
            style: GoogleFonts.ubuntu(
              color: Colors.black,
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: Container(
          child: FutureBuilder(
            future: _getElephant(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              print(snapshot.data);
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...")
                  )
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data[index].image
                        ),
                      ),
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].affiliation),
                      onTap: (){

                        Navigator.push(context, 
                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                        );
                      },
                      
                    ),
                    elevation: 8,
                    shadowColor: Colors.yellow.shade400,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      );
  }
}

class DetailPage extends StatelessWidget {

  final Elephant elephants;

  DetailPage(this.elephants);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
          Text(elephants.name,
           style: GoogleFonts.spaceMono(
            color: Colors.black,
           textStyle: Theme.of(context).textTheme.headline4,
           fontSize: 17.5,
           fontWeight: FontWeight.w700,
           fontStyle: FontStyle.normal,
         ),
         ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                        ),
                        child: Column(
                          children: [
                            Card(
                              child: Row(
                                children: [
                                  Expanded(child: Image(image: NetworkImage(elephants.image), height:200, fit: BoxFit.fill,)),
                                  Expanded(
                                    child: Container(
                                      height: 250,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [Colors.yellow, Colors.yellow.shade300, Colors.yellow.shade100]),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.40),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Name
                                                Text("Name: ",
                                                style: GoogleFonts.spaceMono(
                                                  color: Colors.black,
                                                textStyle: Theme.of(context).textTheme.headline4,
                                                fontSize: 19.5,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              ),
                                              ),
                                              Text(elephants.name,
                                                style: GoogleFonts.spaceMono(
                                                  color: Colors.black,
                                                textStyle: Theme.of(context).textTheme.headline4,
                                                fontSize: 19.5,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                              ),
                                              ),
                                  
                                              // Gender / sex
                                                Text("Gender: ",
                                                style: GoogleFonts.spaceMono(
                                                  color: Colors.black,
                                                textStyle: Theme.of(context).textTheme.headline4,
                                                fontSize: 19.5,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              ),
                                              ),
                                              Text(elephants.sex,
                                                style: GoogleFonts.spaceMono(
                                                color: Colors.black,
                                                textStyle: Theme.of(context).textTheme.headline4,
                                                fontSize: 19.5,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                              ),
                                              ),
                                  
                                                // Species
                                                Text("Species: ",
                                                style: GoogleFonts.spaceMono(
                                                color: Colors.black,
                                                textStyle: Theme.of(context).textTheme.headline4,
                                                fontSize: 19.5,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              ),
                                              ),
                                              Text(elephants.species,
                                                style: GoogleFonts.spaceMono(
                                                  color: Colors.black,
                                                textStyle: Theme.of(context).textTheme.headline4,
                                                fontSize: 19.5,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                              ),
                                              ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                        ),
                                  ),
                                ],
                              ),
                              elevation: 8,
                              shadowColor: Colors.yellow,
                              margin: EdgeInsets.all(2),
                            ),
                            SizedBox(height: 5,),
            
                            Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Description: ",
                                              style: GoogleFonts.spaceMono(
                                              color: Colors.black,
                                              textStyle: Theme.of(context).textTheme.headline4,
                                              fontSize: 19.5,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                            ),
                                            ),
                                  ),
                                  ListTile(
                                    title: Text(elephants.note,
                                              style: GoogleFonts.spaceMono(
                                              color: Colors.black,
                                              textStyle: Theme.of(context).textTheme.headline4,
                                              fontSize: 19.5,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                            ),
                                            ),
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                              elevation: 8,
                              shadowColor: Colors.yellow,
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}

class Elephant {
  final int index;
  final String name;
  final String affiliation;
  final String species;
  final String sex;
  final String note;
  final String image;

  Elephant(this.index, this.name, this. affiliation, this.species, this.sex,this.note, this.image);
}