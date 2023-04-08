import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:flutter/material.dart';

class Module {
  Color iconBorder;
  Color iconBg;
  Color iconColor;
  IconData icon;
  String title;
  String description;
  Color moduleBorder;
  Color moduleBg;
  Color buttonColor;
  Color buttonFont;
  String time;
  String lesson;
  String courseId;

  Module(
    this.iconBorder,
    this.iconBg,
    this.iconColor,
    this.icon,
    this.title,
    this.description,
    this.moduleBorder,
    this.moduleBg,
    this.buttonColor,
    this.buttonFont,
    this.time,
    this.lesson,
    this.courseId,
  );

  static List<Module> generateModules() {
    return [
      Module(
        kAccent,
        kAccent,
        Colors.white,
        Icons.play_arrow_rounded,
        'MODULE 1',
        'Introduction to the course contents',
        kPrimaryLight,
        kPrimaryLight,
        kPrimary,
        kPrimaryDark,
        ' 26 mins ',
        ' 1 lesson ',
        '123456',
      ),
      Module(
        kFont.withOpacity(0.1),
        kFont.withOpacity(0.1),
        kFont.withOpacity(0.4),
        Icons.lock,
        'MODULE 2',
        'Catching feelings with the bird',
        kPrimaryLight,
        kPrimaryLight,
        kPrimary,
        kPrimaryDark,
        ' 62 mins ',
        ' 2 lessons ',
        '123456',
      ),
      Module(
        kFont.withOpacity(0.1),
        kFont.withOpacity(0.1),
        kFont.withOpacity(0.4),
        Icons.lock,
        'MODULE 3',
        'Thank you React, next!?',
        kPrimaryLight,
        kPrimaryLight,
        kPrimary,
        kPrimaryDark,
        ' 62 mins ',
        ' 2 lessons ',
        '123456',
      ),
      Module(
        kFont.withOpacity(0.1),
        kFont.withOpacity(0.1),
        kFont.withOpacity(0.4),
        Icons.lock,
        'MODULE 4',
        'Dealing with common FutureBuilder errors',
        kPrimaryLight,
        kPrimaryLight,
        kPrimary,
        kPrimaryDark,
        ' 62 mins ',
        ' 2 lessons ',
        '123456',
      ),
      Module(
        kFont.withOpacity(0.1),
        kFont.withOpacity(0.1),
        kFont.withOpacity(0.4),
        Icons.lock,
        'MODULE 4',
        'Dealing with common FutureBuilder errors',
        kPrimaryLight,
        kPrimaryLight,
        kPrimary,
        kPrimaryDark,
        ' 62 mins ',
        ' 2 lessons ',
        '123456',
      ),
      Module(
        kFont.withOpacity(0.1),
        kFont.withOpacity(0.1),
        kFont.withOpacity(0.4),
        Icons.lock,
        'MODULE 4',
        'Dealing with common FutureBuilder errors',
        kPrimaryLight,
        kPrimaryLight,
        kPrimary,
        kPrimaryDark,
        ' 62 mins ',
        ' 2 lessons ',
        '123456',
      ),
    ];
  }

  // toString method
  @override
  String toString() {
    return 'Module{iconBorder: $iconBorder, iconBg: $iconBg, iconColor: $iconColor, icon: $icon, title: $title, description: $description, moduleBorder: $moduleBorder, moduleBg: $moduleBg, buttonColor: $buttonColor, buttonFont: $buttonFont, time: $time, lesson: $lesson}';
  }

  // method to pick modules by course id
  static List<Module> getModulesByCourseId(String courseId) {
    return generateModules()
        .where((module) => module.courseId == courseId)
        .toList();
  }
}
