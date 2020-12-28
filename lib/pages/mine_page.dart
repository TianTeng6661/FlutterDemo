import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/discover/discover_cell.dart';


class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();

}

class _MinePageState extends State<MinePage> {

  Widget headerWidget() {
    return Container(
      color: Colors.white,
      height: 200,
      child: Container(
//        color: Colors.yellow,
        margin: EdgeInsets.only(top: 100, bottom: 20),
//        padding: EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.only(left: 30),
//          padding: EdgeInsets.all(5),
//          color: Colors.red,
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: AssetImage('images/微信表情.png'), fit: BoxFit.cover),
                ),
              ), //头像
              Container(
                margin:
                EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
                width: MediaQuery.of(context).size.width - 95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'TT_Yunxiao',
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ), //昵称
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '微信号:TT_Yunxiao',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Image(
                            image: AssetImage('images/icon_right.png'),
                            width: 15,
                          )
                        ],
                      ),
                    ), //微信号+箭头
                  ],
                ),
              ), //右边的部分
            ],
          ),
        ),
//        padding: ,
      ), //头部
    ); //整个头部
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              color: Color.fromRGBO(220, 220, 220, 1),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: <Widget>[
                    headerWidget(), //头部
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信 支付.png',
                      title: '支付',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信收藏.png',
                      title: '收藏',
                    ),
                  ],
                ),
              )), //列表
          Container(
            height: 25,
            color: Color.fromRGBO(0, 0, 0, 0),
            margin: EdgeInsets.only(top: 40, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(
                  image: AssetImage('images/相机.png'),
                )
              ],
            ),
          ), //相机
        ],
      ),
    );
  }

}

