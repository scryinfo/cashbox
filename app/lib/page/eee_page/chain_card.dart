import 'package:app/routers/fluro_navigator.dart';
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
  List<String> chainTypeList = ["EEE"]; //"BTC", "ETH",

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
              alignment: Alignment.centerLeft,
              width: ScreenUtil().setWidth(40),
              height: ScreenUtil().setHeight(42.75),
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(8.5),
                  top: ScreenUtil().setHeight(10)),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg_card.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _drawMoneyUnitWidget(),
                  Gaps.scaleVGap(10),
                  _drawAddressWidget(index),
                ],
              ),
            ),
          );
        },
        itemCount: chainTypeList.length,
        pagination: new SwiperPagination(
          builder: SwiperPagination(
            builder: SwiperPagination.rect, //切页面图标
          ),
        ),
        autoplay: false,
      ),
    );
  }

  Widget _drawMoneyUnitWidget() {
    return Container(
      height: ScreenUtil().setHeight(7),
      child: GestureDetector(
        onTap: () {
          print("money unit is click~~~");
        },
        child: Container(
          height: ScreenUtil().setHeight(7),
          alignment: Alignment.center,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(7),
                  width: ScreenUtil().setWidth(30),
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    moneyUnitStr + " 1234567",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gaps.scaleHGap(1),
                Container(
                  height: ScreenUtil().setHeight(7),
                  child: new PopupMenuButton<String>(
                      color: Colors.black12,
                      icon: Icon(Icons.keyboard_arrow_down),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuItem<String>>[
                            new PopupMenuItem<String>(
                                value: 'USD',
                                child: new Text(
                                  'USD',
                                  style: new TextStyle(color: Colors.white),
                                )),
                            new PopupMenuItem<String>(
                                value: 'CNY',
                                child: new Text(
                                  'CNY',
                                  style: new TextStyle(color: Colors.white),
                                )),
                            new PopupMenuItem<String>(
                                value: 'KRW',
                                child: new Text(
                                  'KRW',
                                  style: new TextStyle(color: Colors.white),
                                )),
                            new PopupMenuItem<String>(
                                value: 'GBP',
                                child: new Text(
                                  'GBP',
                                  style: new TextStyle(color: Colors.white),
                                )),
                            new PopupMenuItem<String>(
                                value: 'JPY',
                                child: new Text(
                                  'JPY',
                                  style: new TextStyle(color: Colors.white),
                                ))
                          ],
                      onSelected: (String value) {
                        setState(() {
                          moneyUnitStr = value;
                        });
                      }),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _drawAddressWidget(index) {
    return Container(
        child: new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          child: GestureDetector(
            onTap: () {
              _navigatorToAddressPage("testWalletName", "testTitle",
                  "testAddress0x666655554444333322221111000099998888777");
            },
            child: Image.asset("assets/images/ic_card_qrcode.png"),
          ),
        ),
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
                _navigatorToAddressPage("testWalletName", "testTitle",
                    "testAddress0x666655554444333322221111000099998888777");
              },
              child: Text(
                "0x566666666666666666666666666666666666666666666666",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.lightBlueAccent),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
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
            ),
          ),
        ),
      ],
    ));
  }

  void _navigatorToAddressPage(
      String walletName, String title, String content) {
    String walletName = "mockWalletName";
    String target = "addresspage?walletName=" +
        walletName +
        "&title=" +
        title +
        "&content=" +
        content;
    NavigatorUtils.push(
      context,
      target,
    );
  }
}
