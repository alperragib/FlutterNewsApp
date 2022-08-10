import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_test_app/controllers/api_controller.dart';
import 'package:news_test_app/models/news_model.dart';
import 'package:news_test_app/pages/news_source_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../controllers/main_controller.dart';

class NewsDetailsPage extends StatefulWidget {
  final NewsModel news;

  const NewsDetailsPage({Key? key, required this.news}) : super(key: key);

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Details Page"),
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
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.share,
              size: 18.sp,
              color: Colors.white,
            ),
            onPressed: () {
              Share.share("${widget.news.title}\n${widget.news.source_url}");
            },
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.solidHeart,
              size: 18.sp,
              color: Colors.white,
            ),
            onPressed: () {
              ApiController().favoritesAddRemoveNews(context, widget.news);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 4.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.news.image_url,
                  errorWidget: (context, url, error) {
                    return Icon(
                      Icons.image,
                      size: 20.w,
                    );
                  },
                ),
                SizedBox(
                  height: 4.w,
                ),
                Text(
                  widget.news.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(
                  height: 4.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.solidNewspaper),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      widget.news.source_name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    FaIcon(FontAwesomeIcons.calendar),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      DateFormat("dd.MM.yyyy").format(widget.news.date),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.w,
                ),
                Text(
                  widget.news.content,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(
                  height: 4.w,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.to(() => NewsSourcePage(
                            news: widget.news,
                          ));
                    },
                    child: Text(
                      "News Source",
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
