import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    this.controller,
    required this.onSubmit,
  });

  final TextEditingController? controller;
  final onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child:
          // Search input with a search icon on the right
          Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 18),
        decoration: BoxDecoration(
          color: kBackground,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: kFontLight.withOpacity(0.2),
              offset: const Offset(0, 12),
              blurRadius: 16,
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onSubmitted: (value) => onSubmit,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: GestureDetector(
              onTap: () => onSubmit,
              child: const Icon(
                CupertinoIcons.search,
                color: kFont,
              ),
            ),
            hintText: 'Kërko shkelës, zyrtarë ose targa',
            hintStyle: const TextStyle(color: kFontLight),
          ),
        ),
      ),
    );
  }
}
