import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/news_model.dart';
import 'main_controller.dart';

class ApiController extends GetConnect {
  MainController controller = Get.find();

  Future<void> getNews() async {
    controller.newsList.value = RxList<NewsModel>();

    return get(
            'https://newsapi.org/v2/everything?q=${controller.search_key.value}&page=1&apiKey=3deb5eec53f14d3a96ef02327ccac334')
        .then((response) {
      if (response.isOk) {
        var jsonData = json.decode(json.encode(response.body));

        if (jsonData['status'] == "ok") {
          var jsonArticles = jsonData['articles'] as List;
          if (jsonArticles.isNotEmpty) {
            for (int i = 0; i < jsonArticles.length; i++) {
              controller.newsList.value.add(NewsModel(
                jsonArticles[i]['title'].toString(),
                jsonArticles[i]['description'].toString(),
                jsonArticles[i]['content'].toString(),
                jsonArticles[i]['urlToImage'].toString(),
                jsonArticles[i]['source']['name'].toString(),
                jsonArticles[i]['url'].toString(),
                DateTime.parse(jsonArticles[i]['publishedAt'].toString()),
              ));
            }
          }
        }
      } else {
        controller.showDialogUpdateDataNoInternet();
      }
    });
  }

  Future<Database> favoritesDB() async {
    String path = join(await getDatabasesPath(), "favorites.sqlite");

    if (await databaseExists(path)) {
    } else {
      ByteData data =
      await rootBundle.load("lib/assets/database/favorites.sqlite");
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path);
  }

  Future<void> favoritesRead() async {
    Database db = await favoritesDB();

    controller.favoritesNewsList.value.clear();

    List<Map> newsList =
    await db.rawQuery("SELECT * FROM favorite_news ORDER BY title ASC");

    for (var item in newsList) {
      String title = item['title'].toString();
      String desc = item['desc'].toString();
      String content = item['content'].toString();
      String image_url = item['image_url'].toString();
      String source_name = item['source_name'].toString();
      String source_url = item['source_url'].toString();
      String date = item['date'].toString();

      controller.favoritesNewsList.value.add(NewsModel(title, desc, content, image_url,
          source_name, source_url, DateTime.parse(date)));
    }
  }

  Future<void> favoritesAddNews(BuildContext context, NewsModel news) async {
    Database db = await favoritesDB();
    bool isSaved = false;
    List<Map> newsList =
    await db.rawQuery("SELECT * FROM favorite_news ORDER BY title ASC");
    for (var item in newsList) {
      String title = item['title'].toString();
      String desc = item['desc'].toString();
      String content = item['content'].toString();
      String image_url = item['image_url'].toString();
      String source_name = item['source_name'].toString();
      String source_url = item['source_url'].toString();
      String date = item['date'].toString();

      if (title == news.title &&
          desc == news.desc &&
          content == news.content &&
          image_url == news.image_url &&
          source_name == news.source_name &&
          source_url == news.source_url &&
          DateTime.parse(date) == news.date) {
        isSaved = true;
        break;
      }
    }

    if (isSaved) {
      await db.rawDelete(
          'DELETE FROM favorite_news WHERE title = "${news.title}" AND desc = "${news.desc}" AND content = "${news.content}" AND image_url = "${news.image_url}" AND source_name = "${news.source_name}" AND source_url = "${news.source_url}" AND date = "${DateFormat('yyyy-MM-dd HH:mm:ss').format(news.date)}"');


      await favoritesRead();
      Get.snackbar(
          "Appcent News", "This news has been removed from favourites.",
          colorText: Colors.black,
          backgroundColor: Colors.white.withOpacity(0.5));
    } else {
      var info = Map<String, dynamic>();

      info["title"] = news.title;
      info["desc"] = news.desc;
      info["content"] = news.content;
      info["image_url"] = news.image_url;
      info["source_name"] = news.source_name;
      info["source_url"] = news.source_url;
      info["date"] = DateFormat('yyyy-MM-dd HH:mm:ss').format(news.date);

      await db.insert("favorite_news", info);
      await favoritesRead();

      Get.snackbar("Appcent News", "This news has been added to favourites.",
          colorText: Colors.black,
          backgroundColor: Colors.white.withOpacity(0.5));
    }
  }
}
