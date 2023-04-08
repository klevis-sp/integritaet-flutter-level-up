import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:flutter/material.dart';

class ProgressHeader extends StatelessWidget {
  const ProgressHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text(
          ' Course Progress',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(children: const [
          // icons for grid and list view
          Icon(
            Icons.list,
            color: kAccent,
          ),
          SizedBox(
            width: 8,
          ),
          Icon(
            Icons.grid_view,
            color: Colors.grey,
          ),
        ])
      ]),
    );
  }
}
