import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:integriteti_zgjedhor_app/models/active_news.dart';
import 'package:integriteti_zgjedhor_app/widgets/article_app_bar.dart';
import 'package:integriteti_zgjedhor_app/widgets/article_description.dart';
import 'package:integriteti_zgjedhor_app/widgets/categories/article_body.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsArticleScreen extends StatefulWidget {
  const NewsArticleScreen({
    super.key,
    required this.articleId,
  });

  final int articleId;

  @override
  State<NewsArticleScreen> createState() => _NewsArticleScreenState();
}

class _NewsArticleScreenState extends State<NewsArticleScreen> {
  Future<List<ActiveNews>>? _newsFuture;

  Future<List<ActiveNews>> _fetchNewsData() async {
    final response =
        await http.get(Uri.parse('https://integritet.optech.al/api/posts/'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)["posts"] as List<dynamic>;
      final lajmetAktive =
          jsonData.map((data) => ActiveNews.fromJson(data)).toList();
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
    return FutureBuilder(
      future: _fetchNewsData(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ActiveNews>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          final article = snapshot.data!
              .firstWhere((element) => element.id == widget.articleId);
          return Scaffold(
            //appBar: const CourseAppBar(),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                final hasActions =
                    article.youtubeVideo != null && article.body != "";
                print('hasActions articlescreen: $hasActions');
                return [
                  SliverAppBar(
                    expandedHeight: 210,
                    floating: false,
                    pinned: true,
                    flexibleSpace: ArticleAppBar(article: article),
                    title: innerBoxIsScrolled
                        ? SliverAppBarScrolled(
                            articleTitle: article.newsTitle!,
                            hasActions: hasActions,
                          )
                        : null,
                    leading: IconButton(
                      icon:
                          const Icon(CupertinoIcons.back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    elevation: 1,
                    actions: [
                      article.youtubeVideo != null && article.body != ""
                          ? IconButton(
                              icon: const Icon(
                                CupertinoIcons.play_arrow_solid,
                                color: Colors.white,
                              ),
                              onPressed: () => launchUrl(
                                Uri.parse(
                                  article.youtubeVideo!,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ];
              },
              body: ListView(
                shrinkWrap: true,
                children: [
                  ArticleDescription(article: article),
                  ArticleBody(article: article),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class SliverAppBarScrolled extends StatelessWidget {
  const SliverAppBarScrolled({
    super.key,
    required this.articleTitle,
    this.hasActions = false,
  });

  final String articleTitle;
  final bool hasActions;

  @override
  Widget build(BuildContext context) {
    final appBarLength = hasActions ? 30 : 38;
    print('hasActions SliverAppBarScrolled: $hasActions');
    print('appBarLength SliverAppBarScrolled: $appBarLength');

    return Padding(
      padding: const EdgeInsets.only(bottom: 0, left: 0, right: 25),
      child: Text(
        // article.newsTitle! first 36 chars
        '${articleTitle.substring(0, appBarLength)}...',
        style: const TextStyle(
          shadows: [
            Shadow(
              offset: Offset(0, 0),
              blurRadius: 196,
              color: Color.fromARGB(255, 232, 222, 222),
            ),
          ],
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }
}
