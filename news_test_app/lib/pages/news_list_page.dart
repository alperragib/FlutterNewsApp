import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:news_test_app/controllers/api_controller.dart';
import 'package:news_test_app/views/news_list_view.dart';
import 'package:sizer/sizer.dart';

import '../controllers/main_controller.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  MainController controller = Get.find();
  bool isSearch = false;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (isSearch) {
                          setState(() {
                            isSearch = false;
                          });
                        }
                      },
                    ),
                  ),
                  Flexible(
                    flex: 9,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    if (searchController.text.isNotEmpty) {
                                      searchController.text = "";
                                    }
                                  });
                                },
                              ),
                              hintText: "Search news...",
                              border: InputBorder.none),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (key) {
                            if (key.trim().isNotEmpty) {
                              controller.search_key.value = key.trim();
                              ApiController().getNews();
                              setState(() {
                                isSearch = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Appcent News App",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  Obx(() => Text(
                        '${controller.newsList.value.length} results listed for "${controller.search_key.value}" ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                        ),
                      )),
                ],
              ),
        actions: [
          Visibility(
            visible: !isSearch,
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                size: 18.sp,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (!isSearch) {
                    isSearch = true;
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Obx(
                () => controller.newsList.value.isEmpty
                    ? Center(
                      child: Container(
                          width: 10.w,
                          height: 10.w,
                          margin: EdgeInsets.only(top: 6.w),
                          child: CircularProgressIndicator()),
                    )
                    : ListView.builder(
                        itemCount: controller.newsList.value.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return NewsListView(
                              news: controller.newsList.value[index]);
                        },
                      ),
              ),
              SizedBox(height: 8.w,),
            ],
          ),
        ),
      ),
    );
  }
}
