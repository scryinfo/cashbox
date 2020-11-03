import 'package:app/generated/i18n.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:html/dom.dart' as dom;

class PrivacyStatementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        centerTitle: translate('privacy_protocol_title'),
        backgroundColor: Colors.transparent,
      ),
      body: _buildPrivacyProtocolHtml(),
    );
  }

  Widget _buildPrivacyProtocolHtml() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
      ),
      child: SingleChildScrollView(
        child: Html(
          data: translate('privacy_protocol'),
          padding: EdgeInsets.all(8.0),
          defaultTextStyle: TextStyle(fontFamily: 'serif', color: Colors.white70),
          linkStyle: const TextStyle(
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
