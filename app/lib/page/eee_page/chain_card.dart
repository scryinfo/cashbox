import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../res/resources.dart';

class ChainCard extends StatefulWidget {
  @override
  _ChainCardState createState() => _ChainCardState();
}

class _ChainCardState extends State<ChainCard>
    with AutomaticKeepAliveClientMixin {
  String moneyUnitStr = "USD";
  List<String> moneyUnitList = ["USD", "CNY", "KRW", "GBP", "JPY"];
  List<String> chainTypeList = ["BTC", "ETH", "EEE"];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(77.5),
      height: ScreenUtil().setHeight(42.75),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: Container(
              width: ScreenUtil().setWidth(77.5),
              height: ScreenUtil().setHeight(42.75),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg_card.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                children: <Widget>[
                  new Column(children: [
                    GestureDetector(
                      onTap: () {
                        print("money unit is click~~~");
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(10),
                              top: ScreenUtil().setWidth(7)),
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
                    Gaps.scaleVGap(5),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(10)),
                                child: GestureDetector(
                                  onTap: () {
                                    print("clicked qr_code.png~~~");
                                  },
                                  child: Image.asset(
                                      "assets/images/ic_card_qrcode.png"),
                                ))),
                        Container(
                          alignment: Alignment.bottomLeft,
                          constraints: BoxConstraints(
                            maxWidth: ScreenUtil().setWidth(20.5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(1.5),
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  print("clicked address~~~");
                                },
                                child: Text(
                                  "0x566666666666666666666666666666666666666666666666",
                                  textAlign: TextAlign.start,
                                  style:
                                      TextStyle(color: Colors.lightBlueAccent),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                        ),
                        Container(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(12.5),
                                  bottom: ScreenUtil().setWidth(0)),
                              child: Text(
                                chainTypeList[index],
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Color.fromRGBO(255, 255, 255, 0.1),
                                ),
                              )),
                        ),
                      ],
                    )
                  ]),
                ],
              ),
            ),
          );
        },
        itemCount: chainTypeList.length,
        pagination: new SwiperPagination(
            builder: SwiperPagination(
          builder: SwiperPagination.dots,
        )),
        autoplay: false,
      ),
    );
  }
}
