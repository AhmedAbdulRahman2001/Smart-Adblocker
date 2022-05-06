import 'package:flutter/material.dart';
import 'package:geekshub/main.dart';
import 'package:geekshub/scraper/homescraper.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var mainBody;
  var sideHeadings;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(onPressed: callScraper, child: Text("Click")),
          ...mainBody.map((key, value)=>{
            Text("key: $key"+ " value is $value")
          }).toList()
        ],
      ),
    );
  }

  callScraper(){
    HomeScraper homeScraper = new HomeScraper();
    homeScraper.search("https://www.javatpoint.com/kotlin-tutorial");
    setState(() {
      mainBody = homeScraper.getMainBody();
      sideHeadings = homeScraper.getHeadings();
    });
  }
}
