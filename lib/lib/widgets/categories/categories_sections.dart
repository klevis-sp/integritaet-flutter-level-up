import 'package:flutter/material.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:integriteti_zgjedhor_app/models/category.dart';
import 'package:integriteti_zgjedhor_app/widgets/categories/category_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = Category.generateCategories();
    return Container(
      color: kBackground,
      child: SizedBox(
        height: 162,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryItem(
              icon: categories[index].icon,
              title: categories[index].title,
              subtitle: categories[index].subtitle,
              path: categories[index].path,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 0);
          },
        ),
      ),
    );
  }
}
