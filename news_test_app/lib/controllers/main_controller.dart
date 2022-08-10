import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_test_app/controllers/api_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:news_test_app/models/news_model.dart';
import 'package:sizer/sizer.dart';

class MainController extends GetxController {
  var perTabController = PersistentTabController(initialIndex: 0).obs;
  RxList<NewsModel> newsList = RxList<NewsModel>();
  RxList<NewsModel> favoritesNewsList = RxList<NewsModel>();
  var search_key = "Turkey".obs;

  @override
  Future<void> onReady() async {
    super.onReady();

    ApiController().getNews();

    ApiController().favoritesRead();
  }

  void showDialogUpdateDataNoInternet() {
    Get.defaultDialog(
      backgroundColor: Theme.of(Get.context!).colorScheme.onBackground,
      titleStyle: TextStyle(fontSize: 14.sp),
      middleTextStyle: TextStyle(fontSize: 12.sp),
      barrierDismissible: false,
      title: "Bir hata meydana geldi!",
      onWillPop: () async => false,
      middleText: "İnternet bağlantısı bulunamadı!",
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(Get.context!).colorScheme.secondaryContainer,
          ),
          child: Text(
            "Tekrar dene",
            style: TextStyle(fontSize: 10.sp),
          ),
          onPressed: () {
            Get.back();
            ApiController().getNews();
          },
        )
      ],
      contentPadding: EdgeInsets.all(4.w),
      titlePadding: EdgeInsets.all(4.w),
    );
  }
}
