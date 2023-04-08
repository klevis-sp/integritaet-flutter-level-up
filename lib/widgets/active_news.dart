import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:integriteti_zgjedhor_app/models/active_news.dart';
import 'package:integriteti_zgjedhor_app/widgets/active_news_item.dart';
import 'package:http/http.dart' as http;

class ActiveNewses extends StatefulWidget {
  const ActiveNewses({super.key});

  @override
  State<ActiveNewses> createState() => _ActiveNewsesState();
}

class _ActiveNewsesState extends State<ActiveNewses> {
  Future<List<ActiveNews>>? _newsFuture;

  Future<List<ActiveNews>> _fetchNewsData() async {
    final response =
        await http.get(Uri.parse('https://integritet.optech.al/api/posts/'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)["posts"] as List<dynamic>;
      final lajmetAktive = // first 3 items of the list
          jsonData
              .map((data) => ActiveNews.fromJson(data))
              .where((element) => element.category!.categoryType != "Perfshihu")
              .toList()
              .take(3)
              .toList();
      return lajmetAktive;
    } else {
      if (kDebugMode) {
        print('Error _fetchNewsData: ${response.body}');
      }
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _newsFuture = _fetchNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ActiveNews>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else {
          final activeNewsList = snapshot.data!;
          return SizedBox(
            height: 170,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: activeNewsList.length,
              itemBuilder: (context, index) {
                return ActiveNewsItem(activeNews: activeNewsList[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 2);
              },
            ),
          );
        }
      },
    );
  }
}
