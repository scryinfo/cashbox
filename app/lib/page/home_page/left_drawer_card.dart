import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../res/resources.dart';

class LeftDrawerCard extends StatefulWidget {
  @override
  _LeftDrawerCardState createState() => _LeftDrawerCardState();
}

class _LeftDrawerCardState extends State<LeftDrawerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "left drawer card",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
