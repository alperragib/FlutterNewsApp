import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/main_controller.dart';

import '../views/news_list_view.dart';

class FavoriteNewsPage extends StatefulWidget {
  const FavoriteNewsPage({Key? key}) : super(key: key);

  @override
  State<FavoriteNewsPage> createState() => _FavoriteNewsPageState();
}

class _FavoriteNewsPageState extends State<FavoriteNewsPage> {
  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Obx(
                () => controller.favoritesNewsList.value.isEmpty
                    ? Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 6.w),
                            child:
                                Text("You have no news added to favorites.")),
                      )
                    : ListView.builder(
                        itemCount: controller.favoritesNewsList.value.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return NewsListView(
                              news: controller.favoritesNewsList.value[index]);
                        },
                      ),
              ),
              SizedBox(
                height: 8.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
