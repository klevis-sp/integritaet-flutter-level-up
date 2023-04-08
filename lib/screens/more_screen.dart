import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:integriteti_zgjedhor_app/widgets/more_list_item.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => context.go('/home'),
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Më shumë',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        //elevation: 1,
        // backgroundColor: kAppBar,
        actions: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0, right: 20),
                padding: const EdgeInsets.only(right: 3),
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
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 6, top: 3, bottom: 3),
                  child: Image(
                    image: AssetImage('assets/app_icon/icon.png'),
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/misioni.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                MoreListItem(
                  icon: CupertinoIcons.car_detailed,
                  title: 'Kontrollo targat',
                  onTap: () => context.push('/targat'),
                ),
                MoreListItem(
                  icon: CupertinoIcons.person_2_fill,
                  title: 'Lista e shkelësve',
                  onTap: () => context.push('/shkelesit'),
                ),
                MoreListItem(
                  icon: CupertinoIcons.map_fill,
                  title: 'Harta e shkeljeve',
                  onTap: () => context.push('/harta'),
                ),
                // MoreListItem(
                //   icon: CupertinoIcons.add_circled,
                //   title: 'Përfshihu',
                //   onTap: () => context.push('/perfshihu'),
                // ),
                MoreListItem(
                  icon: CupertinoIcons.news_solid,
                  title: 'Lajmet',
                  onTap: () => context.push('/lajmet'),
                ),
                MoreListItem(
                  icon: CupertinoIcons.info_circle_fill,
                  title: 'Rreth nesh',
                  onTap: () => context.push('/rreth-nesh'),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Text(
            '© 2023 - Qëndresa Qytetare ',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 5),
          const Text(
            'WE LOVE AND DO OUR BEST FOR OUR COUNTRY AND OUR FELLOW CITIZENS',
            style: TextStyle(color: Colors.grey, fontSize: 8),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
