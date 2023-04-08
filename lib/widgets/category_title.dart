import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({
    super.key,
    required this.categoryTitle,
    required this.actionName,
    required this.goToPath,
  });

  final String categoryTitle;
  final String actionName;
  final String goToPath;

  @override
  Widget build(BuildContext context) {
    // Category title with left text and right button
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            categoryTitle,
            style: const TextStyle(
                color: kFont, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () => context.push(goToPath),
            child: Row(children: [
              Text(
                actionName,
                style: const TextStyle(
                    color: kFontLight,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(width: 5),
              const Icon(
                CupertinoIcons.arrow_right,
                color: kFontLight,
                size: 18,
              ),
            ]),
          ),
          // Arrow icon
        ],
      ),
    );
  }
}
