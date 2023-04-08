class NewsCategory {
  NewsCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.numArticles,
    required this.background,
    required this.dateCreated,
    required this.showFrontend,
    required this.categoryType,
  });

  int id;
  String name;
  String slug;
  String icon;
  int numArticles;
  String background;
  String dateCreated;
  bool showFrontend;
  String categoryType;

  factory NewsCategory.fromJson(Map<String, dynamic> json) {
    return NewsCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      icon: json['icon'] as String,
      numArticles: json['num_articles'] as int,
      background: json['background'] as String,
      dateCreated: json['date_created'] as String,
      showFrontend: json['show_frontend'] as bool,
      categoryType: json['category_type'] as String,
    );
  }
}
