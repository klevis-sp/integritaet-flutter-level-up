import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:integriteti_zgjedhor_app/models/active_news.dart';
import 'package:integriteti_zgjedhor_app/models/news_category.dart';
import 'package:integriteti_zgjedhor_app/widgets/active_news_item.dart';
import 'package:integriteti_zgjedhor_app/widgets/filter_button.dart';

class PerfshihuScreen extends StatefulWidget {
  const PerfshihuScreen({super.key});

  @override
  State<PerfshihuScreen> createState() => _PerfshihuScreenState();

  Future<List<ActiveNews>> _fetchNewsData() async {
    final response =
        await http.get(Uri.parse('https://integritet.optech.al/api/posts/'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)["posts"] as List<dynamic>;
      final lajmetAktive = // filter data by  category_type == "Perfshihu"
          jsonData
              .map((data) => ActiveNews.fromJson(data))
              .where(
                  (newsItem) => newsItem.category!.categoryType == "Perfshihu")
              .toList();
      return lajmetAktive;
    } else {
      if (kDebugMode) {
        print('Error _fetchNewsData: ${response.body}');
      }
      return [];
    }
  }
}

class _PerfshihuScreenState extends State<PerfshihuScreen> {
  List<NewsCategory> _categories = []; // define a list of categories
  List<ActiveNews> _news = []; // define a list of news
  List<NewsCategory> _filteredCategories = [];
  NewsCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // fetch data on initialization
    _fetchData();
  }

  Future<void> _fetchData() async {
    final categories = "Perfshihu";
    final news = await widget._fetchNewsData();

    // update the state with the fetched data
    setState(() {
      _news = news;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('news length: ${_news.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Përfshihu',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: BackButton(
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: _news.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: widget._fetchNewsData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<ActiveNews> activeNews = snapshot.data;

                        return ListView.builder(
                          itemCount: activeNews.length,
                          itemBuilder: (context, index) {
                            // filter the news based on the selected category
                            final newsItem = _news[index];
                            if (_selectedCategory != null &&
                                newsItem.category!.id !=
                                    _selectedCategory!.id) {
                              return Container();
                            }
                            //return ActiveNewsItem(activeNews: newsItem);
                            return InkWell(
                              onTap: () {
                                context.push('/lajmet/${newsItem.id}', extra: {
                                  'newsItem': newsItem,
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  elevation: 1,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(14),
                                          topRight: Radius.circular(14),
                                        ),
                                        child: Image.network(
                                          newsItem.image!,
                                          fit: BoxFit.cover,
                                          height: 200,
                                          width: double.infinity,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons.error);
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const Center(
                                              child:
                                                  CupertinoActivityIndicator(),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          newsItem.newsTitle!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Publikuar më: ',
                                                style: TextStyle(
                                                  color: kFontLight,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                formatDateTime(
                                                    newsItem.datePublished!),
                                                style: const TextStyle(
                                                  color: kPrimaryDark,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                    },
                  ),
                )
              ],
            )
          : const Center(
              child: // show error message if there is no data
                  Text('Nuk ka të dhëna për kategorinë "Perfshihu"',
                      style: TextStyle(color: kFontLight)),
            ),
    );
  }
}
