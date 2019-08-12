import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ChainCard extends StatefulWidget {
  @override
  _ChainCardState createState() => _ChainCardState();
}

class _ChainCardState extends State<ChainCard>
    with AutomaticKeepAliveClientMixin {
  String moneyUnitStr = "USD";
  List<String> moneyUnitList = ["USD", "CNY", "KRW", "GBP", "JPY"];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bg_card.png")),
      ),
      height: ScreenUtil().setHeight(42.5),
      width: ScreenUtil().setWidth(77.5),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Text("666");
          } else {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  new Row(children: [
                    GestureDetector(
                      onTap: () {
                        print("money unit is click~~~");
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(12.5),
                              top: ScreenUtil().setWidth(6.25)),
                          child: Row(children: <Widget>[
                            new Text(
                              moneyUnitStr,
                              style: TextStyle(color: Colors.white),
                            ),
                            new PopupMenuButton<String>(
                                color: Colors.blueAccent,
                                icon: new Icon(Icons.keyboard_arrow_down),
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuItem<String>>[
                                      new PopupMenuItem<String>(
                                          value: 'USD',
                                          child: new Text(
                                            'USD',
                                            style: new TextStyle(
                                                color: Colors.black26),
                                          )),
                                      new PopupMenuItem<String>(
                                          value: 'CNY',
                                          child: new Text(
                                            'CNY',
                                            style: new TextStyle(
                                                color: Colors.black26),
                                          )),
                                      new PopupMenuItem<String>(
                                          value: 'KRW',
                                          child: new Text(
                                            'KRW',
                                            style: new TextStyle(
                                                color: Colors.black26),
                                          )),
                                      new PopupMenuItem<String>(
                                          value: 'GBP',
                                          child: new Text(
                                            'GBP',
                                            style: new TextStyle(
                                                color: Colors.black26),
                                          )),
                                      new PopupMenuItem<String>(
                                          value: 'JPY',
                                          child: new Text(
                                            'JPY',
                                            style: new TextStyle(
                                                color: Colors.black26),
                                          ))
                                    ],
                                onSelected: (String value) {
                                  setState(() {
                                    moneyUnitStr = value;
                                  });
                                }),
                          ])),
                    ),
                  ]),
                ],
              ),
            );
          }
        },
        itemCount: 2,
        pagination: new SwiperPagination(),
        autoplay: false,
      ),
    );
  }
}
