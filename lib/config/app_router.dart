import 'package:integriteti_zgjedhor_app/screens/all_news_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/harta_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/screens/more_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/my_search_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/news_article_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/perfshihu_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/profile_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/report_form_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/root_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/rreth_nesh_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/scaffold_with_bottom_nav.dart';
import 'package:integriteti_zgjedhor_app/screens/shkelesit_screen.dart';
import 'package:integriteti_zgjedhor_app/screens/shkelesit_sipas_bashkive_screen.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// the one and only GoRouter instance
final GoRouter goRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithBottomNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/targat',
          builder: (context, state) => const MySearchScreen(),
        ),
        GoRoute(
          path: '/shkelesit',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ShkelesitScreen(),
          ),
          routes: [
            GoRoute(
              path: ':slug',
              builder: (context, state) {
                final slug = state.params['slug'];
                return ProfileScreen(slug: slug);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/bashkite',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ShkelesitSipasBashkiveScreen(),
          ),
        ),
        GoRoute(
          path: '/perfshihu',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PerfshihuScreen(),
          ),
        ),
        GoRoute(
          path: '/more',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: MoreScreen(),
          ),
        ),
        GoRoute(
          path: '/harta',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HartaScreen(),
          ),
        ),
        GoRoute(
          path: '/report',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ReportFormScreen(),
          ),
        ),
        GoRoute(
          path: '/rreth-nesh',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: RrethNeshScreen(),
          ),
        ),
        GoRoute(
          path: '/lajmet',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AllNewsScreen(),
          ),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final String articleId = state.params['id']!;
                return NewsArticleScreen(
                  articleId: int.parse(articleId),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/privacy-policy',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: RootScreen(
              label: 'PRIVACY POLICY',
              detailsPath: '/privacy-policy/details',
            ),
          ),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Kjo faqe nuk ekziston akoma. ',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              //Text(state.error.toString()),
              OutlinedButton(
                onPressed: () => goRouter.go('/home'),
                child: const Text(
                  'Kthehu ne faqen kryesore.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);
