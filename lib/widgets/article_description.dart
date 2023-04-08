import 'package:flutter/cupertino.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:integriteti_zgjedhor_app/models/active_news.dart';
import 'package:integriteti_zgjedhor_app/widgets/active_news_item.dart';

class ArticleDescription extends StatelessWidget {
  const ArticleDescription({
    super.key,
    required this.article,
  });

  final ActiveNews article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          // Author name and avatar and course duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Author avatar
              Row(
                children: [
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://integritet.optech.al/media/article_pics/miremengjes-shqiperi.jpeg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  // Author name and course duration
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 6,
                      ),
                      // Author name
                      Text(
                        "Integriteti Zgjedhor",
                        //'Flutter Team',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                // clock icon
                const Icon(
                  CupertinoIcons.calendar,
                  color: kFontLight,
                  size: 12,
                ),
                const SizedBox(
                  width: 4,
                ),
                // Course duration
                Text(
                  formatDateTime(article.datePublished!),
                  //'06 hours 30 minutes',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: kFontLight,
                  ),
                ),
              ])
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          // Course title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  article.newsTitle!,
                  //'Flutter for Beginners',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
