class Category {
  Category({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.path,
  });

  String id;
  String title;
  String subtitle;
  String icon;
  String path;

  // generate list of Categories
  static List<Category> generateCategories() {
    return [
      Category(
        id: 'ctg1',
        title: 'Kontrollo Targat',
        subtitle: '26 raportime',
        icon: 'assets/icons/targat.png',
        path: '/targat',
      ),
      Category(
        id: 'ctg2',
        title: 'Shkelësit',
        subtitle: '6 zyrtarë',
        icon: 'assets/icons/kandidatet.png',
        path: '/shkelesit',
      ),
      Category(
        id: 'ctg4',
        title: 'Përfshihu',
        subtitle: 'Shiko infografikë',
        icon: 'assets/icons/perfshihu.png',
        path: '/perfshihu',
      ),
      Category(
        id: 'ctg3',
        title: 'Bashkitë',
        subtitle: '62 bashki',
        icon: 'assets/icons/harta.png',
        path: '/bashkite',
      ),

      Category(
        id: 'ctg5',
        title: 'Rreth Nesh',
        subtitle: 'Qëllimi i platformës',
        icon: 'assets/icons/rrethnesh.png',
        path: '/rreth-nesh',
      ),
      // Category(
      //   id: 'ctg6',
      //   title: 'Informacion',
      //   subtitle: 'rreth platformës',
      //   icon: 'assets/icons/kodizgjedhor.png',
      //   path: '/info',
      // ),
    ];
  }
}
