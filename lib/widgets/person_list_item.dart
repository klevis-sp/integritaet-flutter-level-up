import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';

class PersonListItem extends StatelessWidget {
  const PersonListItem({
    super.key,
    required this.profilePicture,
    required this.name,
    required this.offenderType,
    required this.position,
    required this.municipality,
    required this.goToPath,
  });

  final String profilePicture;
  final String name;
  final String offenderType;
  final String position;
  final String municipality;
  final String goToPath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(goToPath),
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 20, bottom: 10, right: 16),
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
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 68,
              height: 98,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(profilePicture),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    offenderType,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    position,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  Text(
                    municipality,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 0),
            // icon Button with text to tell user to go to offender detail page
            TextButton(
              onPressed: () => context.push(goToPath),
              child: Row(
                children: const [
                  Text(
                    '',
                    style: TextStyle(
                      color: kAppBarBackground,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: kAppBarBackground,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
