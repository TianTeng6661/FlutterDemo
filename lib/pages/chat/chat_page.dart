import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/chat/search_bar.dart';
import 'package:flutter_demo/const.dart';
import 'package:flutter_demo/tools/http_manager.dart' as http;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();

}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  Widget _buildPopupMenuItem(String imageAss, String title) {
    return Row(
      children: <Widget>[
        Image(
          image: AssetImage(imageAss),
          width: 20,
        ),
        Container(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

//  bool _cancleConnect = false;
  Timer _timer;
//  CancelToken _token = CancelToken();

  List<Chat> _datas = [];
  @override
  void initState() {
    super.initState();
//    int _count = 0;
//    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//      //main Isolate
////      print(Isolate.current.debugName);
//      _count++;
//      print(_count);
//      if (_count == 99) {
//        timer.cancel();
//      }
//    });
    print('Chat的init来了!');
    getDatas().then((List<Chat> datas) {
      print('数据来了!');
      print('更新数据');
      setState(() {
        _datas = datas;
      });
    }).catchError((e) {
      print('错误$e');
    }).whenComplete(() {
      print('完毕!');
    });
//        .timeout(Duration(microseconds: 6))
//        .catchError((timeout) {
////          _cancleConnect = true;
//          //取消网络请求
////          _token.cancel('因为网络超时!');
//          print('超时输出:$timeout');
//        });
  }

  Future<List<Chat>> getDatas() async {
    //不再是取消连接了!
//    _cancleConnect = false;
    final response = await http.get(
        'http://rap2api.taobao.org/app/mock/274598/flutter_List',
        timeout: 100);
    if (response.statusCode == 200) {
//      print(response.data);
      //获取相应数据,并转成Map类型!
//      final responseBody = json.decode(response.data);
      //转模型数组 map中遍历的结果需要返回出去
      List<Chat> chatList = response.data['chat_list'].map<Chat>((item) {
        return Chat.fromJson(item);
      }).toList();
      return chatList;
    } else {
      throw Exception('statusCode:${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('微信'),
        backgroundColor: WeChatThemeColor,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              offset: Offset(0, 60.0),
              child: Image(
                image: AssetImage('images/圆加.png'),
                width: 25,
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<String>>[
                  PopupMenuItem(
                      child: _buildPopupMenuItem('images/发起群聊.png', '发起群聊')),
                  PopupMenuItem(
                      child: _buildPopupMenuItem('images/添加朋友.png', '添加朋友')),
                  PopupMenuItem(
                      child: _buildPopupMenuItem('images/扫一扫1.png', '扫一扫')),
                  PopupMenuItem(
                      child: _buildPopupMenuItem('images/收付款.png', '收付款')),
                ];
              },
            ),
          ) //右上角按钮
        ],
      ),
      body: Container(
        child: _datas.length == 0
            ? Center(
          child: Text("Loading..."),
        )
            : ListView.builder(
          itemCount: _datas.length + 1,
          itemBuilder: _buildCellForRow,
        ),
      ),
    );
  }

  Widget _buildCellForRow(BuildContext context, int index) {
    if (index == 0) {
      return SearchCell(
        datas: _datas,
      );
    }
    //保证从模型数组中正确取出数据!从0开始!
    index--;

    return ListTile(
        title: Text(_datas[index].name),
        subtitle: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(right: 10),
          height: 25,
          child: Text(
            _datas[index].message,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image:
              DecorationImage(image: NetworkImage(_datas[index].imageUrl))),
        )); //聊天Cell
  }

  @override
  void dispose() {
    //取消我们的timer
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class Chat {
  final String name;
  final String message;
  final String imageUrl;

  const Chat({this.name,this.message,this.imageUrl});

  factory Chat.fromJson(Map json){
    return Chat(
      name: json['name'],
      message: json['message'],
      imageUrl: json['imageUrl'],
    );
  }

}