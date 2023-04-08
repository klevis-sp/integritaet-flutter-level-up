import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCupertinoActionSheet extends StatefulWidget {
  const MyCupertinoActionSheet({
    super.key,
    required this.controller,
    required this.options,
    required this.sheetTitle,
    required this.sheetSubtitle,
  });

  final TextEditingController controller;
  final List<String> options;
  final String sheetTitle;
  final String sheetSubtitle;

  @override
  State<MyCupertinoActionSheet> createState() => _MyCupertinoActionSheetState();
}

class _MyCupertinoActionSheetState extends State<MyCupertinoActionSheet> {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        widget.sheetTitle,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      message: Text(
        widget.sheetSubtitle,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: widget.options
          .map(
            (element) => CupertinoActionSheetAction(
              child: Text(
                element,
              ),
              onPressed: () {
                setState(() {
                  widget.controller.text = element;
                });
                Navigator.pop(context);
              },
            ),
          )
          .toList(),
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
