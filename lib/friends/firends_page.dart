import 'package:flutter/material.dart';


class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();

}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通讯录'),
      ),
      body: Center(
        child: Text('通讯录'),
      ),
    );

  }
}