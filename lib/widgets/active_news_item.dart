import 'package:flutter/cupertino.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/models/active_news.dart';
import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);

  String formattedDate = DateFormat('MMM d, y').format(dateTime);
  return formattedDate;
}

class ActiveNewsItem extends StatelessWidget {
  final ActiveNews activeNews;
  const ActiveNewsItem({
    Key? key,
    required this.activeNews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/lajmet/${activeNews.id}'),
      child: Container(
        width: 306,
        margin: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: kNews,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: kFontLight.withOpacity(0.5),
              offset: const Offset(0, 2),
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Image.network(
                activeNews.image!,
                fit: BoxFit.cover,
                height: 130,
                width: 130,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  child: Text(
                    activeNews.newsTitle!,
                    style: const TextStyle(
                      color: kFont,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Row(
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
                      formatDateTime(activeNews.dateCreated!),
                      style: const TextStyle(
                        color: kPrimaryDark,
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
