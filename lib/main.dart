import 'package:flutter/material.dart';
import 'package:geekshub/home/homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GeeksHub());
}

class GeeksHub extends StatelessWidget {
  const GeeksHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geeks HUB',
      home: HomeScreen(),
    );
  }
}
