import 'dart:ui';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:integriteti_zgjedhor_app/models/active_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ArticleAppBar({
    super.key,
    required this.article,
  });

  final ActiveNews article;

  @override
  Size get preferredSize => const Size.fromHeight(280);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          article.image!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      // make sure we apply clip it properly
                      child: constraints.maxHeight < 120
                          ? BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // video positioned button
          if (article.youtubeVideo != null && article.body != "")
            Positioned(
              bottom: 6,
              right: 6,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: constraints.maxHeight > 190 ? 1 : 0,
                child: Container(
                  height: 40,
                  width: 80,
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
                          onTap: () =>
                              launchUrl(Uri.parse(article.youtubeVideo!)),
                          child: const Text(
                            'Video',
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
              ),
            ),
          // Positioned(
          //   top: 68,
          //   left: 10,
          //   child: Container(
          //     height: 40,
          //     width: 40,
          //     decoration: BoxDecoration(
          //       color: kAppBarBackground.withOpacity(0.8),
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 68,
          //   right: 10,
          //   child: Container(
          //     height: 40,
          //     width: 40,
          //     decoration: BoxDecoration(
          //       color: kReportButton.withOpacity(0.8),
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     child: InkWell(
          //       onTap: () {
          //         // context.go('/');
          //       },
          //       child: const Padding(
          //         padding: EdgeInsets.only(left: 0.0),
          //         child: Icon(
          //           '2' == '2'
          //               ? CupertinoIcons.share
          //               : CupertinoIcons.share_solid,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      );
    });
  }
}
