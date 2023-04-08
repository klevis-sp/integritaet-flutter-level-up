import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:integriteti_zgjedhor_app/widgets/active_news.dart';
import 'package:integriteti_zgjedhor_app/widgets/categories/categories_sections.dart';
import 'package:integriteti_zgjedhor_app/widgets/category_title.dart';
import 'package:integriteti_zgjedhor_app/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //EmojiText(),
            const SizedBox(height: 6),
            Center(
              child: Container(
                height: 90,
                width: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/misioni.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            //const SearchInput(onSubmit: null),
            const SizedBox(height: 16),
            const CategoryTitle(
              categoryTitle: 'Kategoritë',
              actionName: "Të gjitha",
              goToPath: '/more',
            ),
            const CategoriesSection(),
            //const CategoryTitle(lT: 'Kontrollo', rT: 'Më shumë'),
            //FeatureCourses(),
            const CategoryTitle(
              categoryTitle: 'Lajmet',
              actionName: 'Më shumë',
              goToPath: '/lajmet',
            ),
            const ActiveNewses(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kReportButton,
          ),
          child: FloatingActionButton.extended(
            onPressed: () {
              context.push('/report');
            },
            backgroundColor: kReportButton,
            isExtended: true,
            tooltip: 'Raporto një shkelje',
            enableFeedback: true,
            icon: const Icon(
              Icons.report,
              color: Colors.white,
              size: 30,
            ),
            label: const Text(
              'Raporto një shkelje',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
