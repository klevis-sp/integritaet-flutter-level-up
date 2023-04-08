import 'package:flutter/material.dart';

class MoreListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MoreListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
            width: 0.2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: ListTile(
          leading: Icon(icon, size: 20),
          title: Text(title, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          onTap: onTap,
        ),
      ),
    );
  }
}
