import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_test_app/models/news_model.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsSourcePage extends StatefulWidget {
  final NewsModel news;

  const NewsSourcePage({Key? key, required this.news}) : super(key: key);

  @override
  State<NewsSourcePage> createState() => _NewsSourcePageState();
}

class _NewsSourcePageState extends State<NewsSourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Source Page"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: widget.news.source_url,
        ),
      ),
    );
  }
}
