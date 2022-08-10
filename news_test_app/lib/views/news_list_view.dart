import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_test_app/pages/news_details_page.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../models/news_model.dart';

class NewsListView extends StatelessWidget {
  final NewsModel news;

  const NewsListView({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 0.5)),
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          Get.to(() => NewsDetailsPage(news: news));
        },
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                news.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 4.w,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      news.desc,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  Expanded(
                    flex: 4,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: news.image_url,
                      placeholder: (context, url) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 7.w, horizontal: 14.w),
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Icon(
                          Icons.image,
                          size: 20.w,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.w,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat("HH:mm dd/MM/yyyy").format(news.date),
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300,
                      fontSize: 10.sp,
                      color: Colors.grey.withOpacity(0.9)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
