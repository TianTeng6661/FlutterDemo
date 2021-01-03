import 'package:flutter/material.dart';
import 'package:flutter_demo/const.dart';
import 'package:flutter_demo/pages/friends/friends_data.dart';
import 'package:flutter_demo/pages/friends/index_bar.dart';
import 'package:flutter_demo/pages/discover/discover_child_page.dart';


class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();

}

class _FriendPageState extends State<FriendPage> with AutomaticKeepAliveClientMixin{

  //字典里面放item和高度的对应数据,默认前两个是头部
  final Map _groupOffsetMap = {
    INDEX_WORDS[0]:0.0,
    INDEX_WORDS[1]: 0.0,
  };

  ScrollController _scrollController;

  final List<Friends> _listDatas = [];

  @override
  void initState() {
    super.initState();
    //    _listDatas.addAll(datas);
    //    _listDatas.addAll(datas);
    //多弄一点数据!
    _listDatas..addAll(datas)..addAll(datas);
    //排序!
    _listDatas.sort((Friends a, Friends b) {
      return a.indexLetter.compareTo(b.indexLetter);
    });

    var _groupOffset = 54.5 * 4;
    //经过循环计算,将每一个头的位置算出来.放入字典!
    for (int i = 0; i < _listDatas.length; i++) {
      if (i < 1) {
        //第一个Cell
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        //保存完了再加_groupOffset偏移
        _groupOffset += 84.5;
      } else if (_listDatas[i].indexLetter == _listDatas[i - 1].indexLetter) {
        //此时没有头部,只需要加偏移量就好了!
        _groupOffset += 54.5;
      } else {
        //这部分就是有头部的Cell了!
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        _groupOffset += 84.5;
      }
    }

    _scrollController = ScrollController();

  }

  final List<Friends> _headerData = [
    Friends(imageUrl: 'images/新的朋友.png', name: '新的朋友'),
    Friends(imageUrl: 'images/群聊.png', name: '群聊'),
    Friends(imageUrl: 'images/标签.png', name: '标签'),
    Friends(imageUrl: 'images/公众号.png', name: '公众号'),
  ];

  Widget _itemForRow(BuildContext context, int index) {
    //顶部cell
    if(index < _headerData.length){
      return _FriendCell(
        imageAssets: _headerData[index].imageUrl,
        name: _headerData[index].name,
      );
    }else{
      //显示剩下的Cell
      //如果当前和上一个Cell的IndexLetter一样,就不显示!
      bool _hideIndexLetter = (index - 4 > 0 &&
          _listDatas[index - 4].indexLetter == _listDatas[index - 5].indexLetter);
      return _FriendCell(
        imageUrl: _listDatas[index - 4].imageUrl,
        name: _listDatas[index - 4].name,
        groupTitle: _hideIndexLetter ? null : _listDatas[index - 4].indexLetter,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: WeChatThemeColor,
          title: Text('通讯录'),
          actions: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Image(
                  image: AssetImage('images/icon_friends_add.png'),
                  width: 25,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => DiscoverChildPage(
                      title: '添加朋友',
                    )));
              },
            )
          ],
        ),
      body: Stack(
        children: <Widget>[
          Container(
              color: WeChatThemeColor,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _listDatas.length + _headerData.length,
                itemBuilder: _itemForRow,
              )), //列表
          IndexBar(
            indexBarCallBack: (String str) {
              if (_groupOffsetMap[str] != null) {
                _scrollController.animateTo(_groupOffsetMap[str],
                    duration: Duration(milliseconds: 1), curve: Curves.easeIn);
              }
            },
          ), //悬浮检索控件
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _FriendCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAssets;
  const _FriendCell({this.imageUrl,this.name,this.groupTitle,this.imageAssets});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          height: groupTitle != null ? 30 : 0,
          color: Color.fromRGBO(1, 1, 1, 0.0),
          child: groupTitle != null
              ? Text(
            groupTitle,
            style: TextStyle(color: Colors.grey),
          )
              : null,
        ), //cell的头
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                      image: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : AssetImage(imageAssets),
                    )),
              ), //图片
              Container(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 17),
                ),
              ), //昵称
            ],
          ),
        ), //Cell内容
        Container(
          height: 0.5,
          color: WeChatThemeColor,
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                color: Colors.white,
              )
            ],
          ),
        ) //分割线
      ],
    );
  }
}
