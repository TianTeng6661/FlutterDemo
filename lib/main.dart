import 'package:flutter/material.dart';
import 'TTBaseWidget.dart';
import 'CarList/TTListViewDemo.dart';
import 'root_page.dart';

void main() {
  runApp(ListViewApp());
}

class ListViewApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        highlightColor: Color.fromRGBO(1, 0, 0, 0.0),
        splashColor: Color.fromRGBO(1, 0, 0, 0.0),
      ),
      home: RootPage(),
    );
  }

}
class ListViewHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('TTCarList', style: TextStyle(color: Colors.white)),
        ),
        body: TTListView()
    );
  }
}

