import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:integriteti_zgjedhor_app/models/active_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleBody extends StatelessWidget {
  const ArticleBody({
    super.key,
    required this.article,
  });

  final ActiveNews article;

  @override
  Widget build(BuildContext context) {
    final String htmlDynamic = article.body!;
    //get moduleList whose courseId is courseId
    return
        // single child scroll view that parses HTML and displays it
        // if no article, show no modules gif and text
        htmlDynamic != ""
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Html(
                  data: htmlDynamic,
                  onLinkTap: (url, _, __, ___) {
                    if (url != null) {
                      launchUrl(Uri.parse(url));
                    }
                  },
                ),
              )
            : Column(
                children: [
                  // Container(
                  //   width: 126,
                  //   height: 126,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     image: const DecorationImage(
                  //       image: AssetImage('assets/images/no_modules.jpg'),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 126),
                  const Text('Ky lajm është i vlefshëm vetëm si video!',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 126,
                    decoration: BoxDecoration(
                      color: kReportButton,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Row(
                        // Icon with Text
                        children: [
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          InkWell(
                            onTap: () => launchUrl(Uri.parse(article.youtubeVideo!)),
                            child: const Text(
                              'Shiko videon',
                              style: TextStyle(
                                color: kPrimaryLight,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
  }
}
