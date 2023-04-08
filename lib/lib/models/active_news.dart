import 'dart:convert';
import 'package:integriteti_zgjedhor_app/models/news_category.dart';

class ActiveNews {
  int? id;
  NewsCategory? category;
  String? newsTitle;
  String? slug;
  String? image;
  String? body;
  String? datePublished;
  String? dateCreated;
  String? dateUpdated;
  String? status;
  String? youtubeVideo;
  bool? showHomepage;

  ActiveNews({
    this.id,
    this.category,
    this.newsTitle,
    this.slug,
    this.image,
    this.body,
    this.datePublished,
    this.dateCreated,
    this.dateUpdated,
    this.status,
    this.youtubeVideo,
    this.showHomepage,
  });

  factory ActiveNews.fromJson(Map<String, dynamic> json) {
    return ActiveNews(
      id: json['id'] as int,
      category: json['category'] != null
          ? NewsCategory.fromJson(json['category'])
          : null,
      newsTitle: utf8.decode(json['title'].toString().codeUnits),
      body: json['body'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
      datePublished: json['date_published'] as String,
      dateCreated: json['date_created'] as String,
      dateUpdated: json['date_updated'] as String,
      status: json['status'] as String,
      youtubeVideo: json['youtube_video'] != null
          ? json['youtube_video'] as String
          : null,
      showHomepage: json['show_homepage'] as bool,
    );
  }

  // generate list of active courses
  static List<ActiveNews> generateActiveNews() {
    return [
      ActiveNews(
        id: 11234,
        category: NewsCategory(
          id: 1,
          name: 'Video',
          slug: 'video',
          icon: 'fa fa-video-camera',
          numArticles: 5,
          background: 'bg-primary',
          dateCreated: "2023-03-13T10:37:45.472962Z",
          showFrontend: true,
          categoryType: 'Video',
        ),
        newsTitle:
            'Zgjedhjet e 14 majit/ Partitë një javë kohë për regjistrimin e koalicioneve në KQZ',
        body: '''
<p>P&euml;rdorimi i shtetit p&euml;r fushat&euml; elektorale - Burimet shtet&euml;rore n&euml; funksion t&euml; fushat&euml;s elektorale - Betejat e deritanishme dhe pritshm&euml;rit&euml; p&euml;r 14 majin - Zgjidhjet ligjore dhe politike</p>\r\n\r\n<p>T&euml; ftuar:</p>\r\n\r\n<p>Z. Rigels Xhemollari, &ldquo;Q&euml;ndresa Qytetare&rdquo;</p>\r\n\r\n<p>Znj. Antuela Male, KRIIK</p>\r\n\r\n<p>Z. Altin Kaziaj, P&euml;rfaq&euml;sues ligjor i PL n&euml; KQZ</p>\r\n\r\n<p>Z. Dhimit&euml;r Zguro, Jurist (SKYPE)</p>''',
        slug: "perdorimi-i-burimeve-shtetare-ne-fushate-elektorale",
        image:
            "https://integritet.optech.al/media/person_pics/Female-Avatar_KomBrsD.png",
        datePublished: "2021-04-27T10:37:45.472962Z",
        dateCreated: "2021-04-27T10:37:45.472962Z",
        dateUpdated: "2021-04-27T10:37:45.472962Z",
        status: "published",
        youtubeVideo: "https://www.youtube.com/watch?v=IYvD9oBCuJI",
        showHomepage: true,
      ),
      ActiveNews(
        id: 5324,
        category: NewsCategory(
          id: 2,
          name: 'Video',
          slug: 'video',
          icon: 'fa fa-video-camera',
          numArticles: 5,
          background: 'bg-primary',
          dateCreated: "2023-03-13T10:37:45.472962Z",
          showFrontend: true,
          categoryType: 'Video',
        ),
        newsTitle: 'Përdorimi i burimeve shtetërore në fushatë elektorale',
        body: '''
<p>P&euml;rdorimi i shtetit p&euml;r fushat&euml; elektorale - Burimet shtet&euml;rore n&euml; funksion t&euml; fushat&euml;s elektorale - Betejat e deritanishme dhe pritshm&euml;rit&euml; p&euml;r 14 majin - Zgjidhjet ligjore dhe politike</p>\r\n\r\n<p>T&euml; ftuar:</p>\r\n\r\n<p>Z. Rigels Xhemollari, &ldquo;Q&euml;ndresa Qytetare&rdquo;</p>\r\n\r\n<p>Znj. Antuela Male, KRIIK</p>\r\n\r\n<p>Z. Altin Kaziaj, P&euml;rfaq&euml;sues ligjor i PL n&euml; KQZ</p>\r\n\r\n<p>Z. Dhimit&euml;r Zguro, Jurist (SKYPE)</p>''',
        slug: "perdorimi-i-burimeve-shtetare-ne-fushate-elektorale",
        image:
            "https://integritet.optech.al/media/person_pics/Female-Avatar_KomBrsD.png",
        datePublished: "2021-04-27T10:37:45.472962Z",
        dateCreated: "2021-04-27T10:37:45.472962Z",
        dateUpdated: "2021-04-27T10:37:45.472962Z",
        status: "published",
        youtubeVideo: "https://www.youtube.com/watch?v=IYvD9oBCuJI",
        showHomepage: true,
      ),
    ];
  }

  // generate getActiveNewsById method
  static ActiveNews getActiveNewsById(int id) {
    return generateActiveNews().firstWhere((news) => news.id == id);
  }
}
