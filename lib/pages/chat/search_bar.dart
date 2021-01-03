
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/chat/chat_page.dart';
import 'package:flutter_demo/pages/chat/search_page.dart';
import 'package:flutter_demo/const.dart';

class SearchCell extends StatelessWidget {
  final List<Chat> datas;
  const SearchCell({this.datas});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (d){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SearchPage(
            datas: datas,
          );
        }));
      },
      child: Container(
        height: 44,
        color: WeChatThemeColor,
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
            ), //白色底
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('images/放大镜b.png'),
                  width: 15,
                  color: Colors.grey,
                ),
                Text(
                  '  搜索',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ), //中间的文字和放大镜
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const SearchBar({this.onChanged});
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;
  _onChange(String text) {
    if (text.length > 0) {
      widget.onChanged(text);
      setState(() {
        _showClear = true;
      });
    } else {
      widget.onChanged('');
      _showClear = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      color: WeChatThemeColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            height: 44,
//            color: Colors.red,
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenWidth(context) - 40,
                  height: 34,
                  margin: EdgeInsets.only(left: 5),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/放大镜b.png'),
                        width: 20,
                        color: Colors.grey,
                      ), //放大镜
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _controller,
                          onChanged: _onChange,
                          autofocus: true,
                          cursorColor: Colors.green,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.only(left: 5, bottom: 10),
                              border: InputBorder.none,
                              hintText: '搜索'),
                        ),
                      ), //输入框
                      _showClear
                          ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller.clear();
                            _onChange(''); //如果不出发onChange,那么外接将无法回去数据!
                          });
                        },
                        child: Icon(
                          Icons.cancel,
                          size: 20,
                          color: Colors.grey,
                        ),
                      )
                          : Container(), //取消按钮
                    ],
                  ),
                ), //左边的圆角背景
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(' 取消'),
                )
              ],
            ),
          ), //下面的搜索条
        ],
      ),
    );
  }
}