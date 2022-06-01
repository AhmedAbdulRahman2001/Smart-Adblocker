import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

// main() async {
//   HomeScraper a = HomeScraper();
//   await a.search("https://www.javatpoint.com/kotlin-tutorial");
//   print(await a.getMainBody());
//   print(await a.getHeadings());
// }

class HomeScraper {
  late final client;
  var name;
  late Document doc;

  // Create a HTTP Client
  HomeScraper() {
    client = Client();
  }

  // Start the Scraper by requesting the url and parse the response
  Future<void> search(name) async {
    this.name = name;
    Response response = await client.get(Uri.parse(name));
    doc = parse(response.body);
  }

  // Getting the main content
  getMainBody() {
    Map bodyContent = {};
    try{
      Element? temp = doc.getElementsByClassName("onlycontentinner")[0];
      temp = temp.querySelector('div#city > table');
      List<Element?> elements = temp!.getElementsByTagName("h2");

      for(int i=0; i<elements.length; i++){
        bodyContent[i] = {};
        bodyContent[i]["heading"] = elements[i]!.text;

        List<String> result = [];
        Element? headSiblings = elements[i]!.nextElementSibling;
        while(headSiblings != null && headSiblings.outerHtml.substring(1, 3) != "h2"){
          if(headSiblings.text != '') result.add(headSiblings.text);
          headSiblings = headSiblings.nextElementSibling;
        }
        bodyContent[i]["content"] = result;
      }
    }catch(e){
      print(e.toString());
    }

    return bodyContent;
  }

  // Getting the hyperlinks(Sub-headings)
  getHeadings() {
    Map resultLinks = {};
    try {
      Element? temp = doc.getElementById('menu');

      // get the headings in one array and links for corresponding in other
      List<Element>? head = temp!.querySelectorAll('div.leftmenu2');
      List<Element>? links = temp.querySelectorAll('div.leftmenu');
      for (var i=0;i<links.length;i++) {
        Map subLinks = {};
        subLinks.addEntries(links[i].querySelectorAll('a').map((e) =>
            MapEntry(
                e.text,
                e.attributes['href'])));
        resultLinks[head[i].text] = subLinks;
      }
    }catch(e){
      print(e.toString());
    }
    return resultLinks;
  }
}
