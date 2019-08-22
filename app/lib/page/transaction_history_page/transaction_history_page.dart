import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/page/eee_page/chain_card.dart';
import 'package:app/page/eee_page/middle_func_card.dart';
import 'package:app/page/eee_page/digit_list_card.dart';
import '../../res/resources.dart';
import '../eee_page/left_drawer_card.dart';

class TransactionHistoryPage extends StatefulWidget {
  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("transaction"),
    );
  }
}
