import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ChainCard extends StatefulWidget {
  @override
  _ChainCardState createState() => _ChainCardState();
}

class _ChainCardState extends State<ChainCard> {
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
          return SingleChildScrollView(
            child: InkWell(
              onTap: () {},
              child: Column(
                children: <Widget>[],
              ),
            ),
          );
        },
        itemCount: 2,
        pagination: new SwiperPagination(),
        autoplay: false,
      ),
    );
  }
}
