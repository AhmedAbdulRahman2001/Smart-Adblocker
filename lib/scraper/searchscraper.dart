import 'dart:convert';
import 'package:http/http.dart';


// main() async {
//   SearchScraper searchScraper = SearchScraper("java");
//   await searchScraper.initiateSearch();
//   print("Done!");
// }


class SearchScraper{
  var searchData;
  Map<String, dynamic>? searchResult;
  Client? client;


  SearchScraper(this.searchData){
    client = Client();
  }

  initiateSearch() async{
    var response = await client!.get(Uri.parse("https://www.googleapis.com/customsearch/v1?key=AIzaSyClGQgrGfrby9LY0bUSEUy-6OdbumIyccU&cx=98253223e7a67256a&q="+searchData));
    searchResult = jsonDecode(response.body);

    print("==========Fetched the Data========");

    // print(searchResult!['items'][0]['link']);

    return searchResult!['items'][0]['link'];
  }
}