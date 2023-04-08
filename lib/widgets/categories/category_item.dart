import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.path,
  });

  final String title;
  final String subtitle;
  final String icon;
  final String path;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(widget.path),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 12.0,
          right: 6.0,
          left: 16.0,
        ),
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: kBackground,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: kFontLight.withOpacity(0.5),
                offset: const Offset(0, 2),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 76,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage(widget.icon),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          color: kFont,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: kFontLight,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
