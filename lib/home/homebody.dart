import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geekshub/scraper/homescraper.dart';
import 'package:geekshub/scraper/searchscraper.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var mainBody;
  var sideHeadings;
  List<String> mainHeadings = [];
  List<String> content = [];
  final textController = TextEditingController();
  String searchUrl = "https://www.javatpoint.com/kotlin-tutorial";
  List<Widget> mainWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(controller: textController,
              decoration: InputDecoration(
                hintText: "type here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                )
              ),),
            ),
            TextButton(onPressed: () async {
              // reset all values before beginning new search
              mainBody = null;
              sideHeadings = null;
              mainHeadings = [];
              content = [];
              mainWidgets = [];

              print(textController.value.text);
              SearchScraper searchScraper = SearchScraper(textController.value.text);
              String? url = await searchScraper.initiateSearch();
              print(url);

              setState((){
                searchUrl = url!;
              });
              await callScraper();
            }, child: Text("Search")),
            (mainBody != null)?Column(
              children: mainWidgets,
            ):Container(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){}, child: Text("Previous")),
              TextButton(onPressed: (){}, child: Text("Next")),
            ],)
          ],
        ),
      ),
    );
  }

  callScraper() async{
    // check callScraper
    print("calling main scraper");


    HomeScraper homeScraper = new HomeScraper();
    await homeScraper.search(searchUrl);
    print(searchUrl);
    setState(() {
      mainBody = homeScraper.getMainBody();
      sideHeadings = homeScraper.getHeadings();
      // print(mainBody);
      for(MapEntry<dynamic, dynamic> element in mainBody.entries){
        // print(element.key); 0 1 2 3 4
        // print(element.value); main cheez yeich hai
        element.value.forEach((key, value){
          // print(key+":\n"); heading or content ye do ich hai isme
          // print(value); list of content
          if(key.toString() == "content"){
            content.add(value.join("\n"));
            // for(dynamic val in value){
            //   print(val.toString()+"\n");
            // }
          }else{
            mainHeadings.add(value.toString());
          }
        });
      }
      mainWidgets = getData();
    });
    // print(sideHeadings);
  }

  List<Widget> getData(){
    List<Widget> body = [];
    var length = content.length;

    for(int i=0; i<length; i++){
      if(i==length-1){
        body.add(Text(mainHeadings[i],style: TextStyle(fontWeight: FontWeight.bold),));
        body.add(Text(content[i].substring(0, content[i].length-52)));
      }else{
        body.add(Text(mainHeadings[i],style: TextStyle(fontWeight: FontWeight.bold),));
        body.add(Text(content[i]));
      }
    }
    return body;
  }
}
