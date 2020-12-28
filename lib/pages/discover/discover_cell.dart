import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/discover/discover_child_page.dart';



class DiscoverCell extends StatelessWidget {

  final String title;
  final String subTitle;
  final String imageName;
  final String subImageName;

  DiscoverCell({this.title,this.subTitle,this.imageName,this.subImageName});

      @override
      Widget build(BuildContext context) {
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
            DiscoverChildPage(title: '$title')));
          },
          child: Container(
            color: Colors.white,
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //left
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage(imageName),
                        width: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(title),
                    ],
                  ),
                ),

                //right
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      subTitle != null ? Text(subTitle) : Text(''),
                      subImageName != null
                          ? Image(
                        image: AssetImage(subImageName),
                        width: 12,
                      )
                          : Container(),
                      Image(
                        image: AssetImage('images/icon_right.png'),
                        width: 15,
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      }
    }
