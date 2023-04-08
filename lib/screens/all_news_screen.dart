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

class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({super.key});

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();

  Future<List<ActiveNews>> _fetchNewsData() async {
    final response =
        await http.get(Uri.parse('https://integritet.optech.al/api/posts/'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)["posts"] as List<dynamic>;
      final lajmetAktive = jsonData
          .map((data) => ActiveNews.fromJson(data))
          .where((newsItem) => newsItem.category!.categoryType != "Perfshihu")
          .toList();
      return lajmetAktive;
    } else {
      if (kDebugMode) {
        print('Error _fetchNewsData: ${response.body}');
      }
      return [];
    }
  }

// fetch categories data
  Future<List<NewsCategory>> _fetchCategoriesData() async {
    final response =
        await http.get(Uri.parse('https://integritet.optech.al/api/posts/'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)["categories"] as List<dynamic>;
      final kategorite = jsonData
          .map((data) => NewsCategory.fromJson(data))
          .where((element) => element.categoryType != "Perfshihu")
          .toList();
      return kategorite;
    } else {
      if (kDebugMode) {
        print('Error: ${response.body}');
      }
      return [];
    }
  }
}

class _AllNewsScreenState extends State<AllNewsScreen> {
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
    final categories = await widget._fetchCategoriesData();
    final news = await widget._fetchNewsData();

    // filter categories with news items
    final filteredCategories = categories.where((category) {
      return news.any((newsItem) => newsItem.category!.id == category.id);
    }).toList();

    // update the state with the fetched data
    setState(() {
      _categories = categories;
      _news = news;
      _filteredCategories = filteredCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Të gjitha lajmet',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        leading: BackButton(
          onPressed: () {
            context.go('/home');
          },
        ),
        actions: [
          PopupMenuButton<NewsCategory>(
            itemBuilder: (context) {
              return _categories
                  .map((category) => PopupMenuItem(
                        value: category,
                        child: Text(category.name),
                      ))
                  .toList();
            },
            onSelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: _news.isNotEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return FilterButton(
                        text: _categories[index].name,
                        isSelected:
                            _selectedCategory?.id == _categories[index].id,
                        onTap: () {
                          setState(() {
                            _selectedCategory = _categories[index];
                          });
                        },
                        value: _categories[index].numArticles,
                        icon: _categories[index].icon,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 5);
                    },
                  ),
                ),
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
              child: CupertinoActivityIndicator(),
            ),
    );
  }
}
