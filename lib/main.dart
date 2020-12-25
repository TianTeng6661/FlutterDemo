import 'package:flutter/material.dart';
import 'TTBaseWidget.dart';
import 'TTListViewDemo.dart';

void main() {
  runApp(ListViewApp());
}

class ListViewApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListViewHome(),
      theme: ThemeData(primaryColor: Colors.orange),
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

