import 'dart:convert';

class Bashkia {
  Bashkia({
    required this.id,
    required this.icon,
    required this.name,
    required this.slug,
  });

  int id;
  String icon;
  String name;
  String slug;

  // generate list of Categories
  static List<Bashkia> generateStaticBashkiaList() {
    return [
      Bashkia(
        id: 1,
        icon:
            'https://integritet.optech.al/media/municipality_icons/bashkia-durres.png',
        name: 'Bashkia Durres',
        slug: 'bashkia-durres',
      ),
      Bashkia(
        id: 2,
        icon:
            'https://integritet.optech.al/media/municipality_icons/bashkia_berat_Kvogxsg.png',
        name: 'Bashkia Berat',
        slug: 'bashkia-berat',
      ),
      Bashkia(
        id: 3,
        icon:
            'https://integritet.optech.al/media/municipality_icons/bashkia_fier.png',
        name: 'Bashkia Fier',
        slug: 'bashkia-fier',
      ),
      Bashkia(
        id: 4,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Roskovec.svg.png',
        name: 'Bashkia Roskovec',
        slug: 'bashkia-roskovec',
      ),
      Bashkia(
        id: 6,
        icon:
            'https://integritet.optech.al/media/municipality_icons/bashkia_belsh.webp',
        name: 'Bashkia Belsh',
        slug: 'bashkia-belsh',
      ),
      Bashkia(
        id: 7,
        icon:
            'https://integritet.optech.al/media/municipality_icons/bashkia_bulqize.png',
        name: 'Bashkia Bulqizë',
        slug: 'bashkia-bulqize',
      ),
      Bashkia(
        id: 8,
        icon:
            'https://integritet.optech.al/media/municipality_icons/bashkia_burrel.png',
        name: 'Bashkia Burrel',
        slug: 'bashkia-burrel',
      ),
      Bashkia(
        id: 9,
        icon:
            'https://integritet.optech.al/media/municipality_icons/bashkia_delvine.png',
        name: 'Bashkia Delvine',
        slug: 'bashkia-delvine',
      ),
      Bashkia(
        id: 10,
        icon:
            'https://integritet.optech.al/media/municipality_icons/bashkia_devoll.png',
        name: 'Bashkia Devoll',
        slug: 'bashkia-devoll',
      ),
      Bashkia(
        id: 11,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Dibër.svg.png',
        name: 'Bashkia Dibër',
        slug: 'bashkia-diber',
      ),
      Bashkia(
        id: 12,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Divjakë.svg.png',
        name: 'Bashkia Divjakë',
        slug: 'bashkia-divjake',
      ),
      Bashkia(
        id: 13,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Dropull.svg.png',
        name: 'Bashkia Dropull',
        slug: 'bashkia-dropull',
      ),
      Bashkia(
        id: 14,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Elbasan.svg.png',
        name: 'Bashkia Elbasan',
        slug: 'bashkia-elbasan',
      ),
      Bashkia(
        id: 15,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Finiq.svg.png',
        name: 'Bashkia Finiq',
        slug: 'bashkia-finiq',
      ),
      Bashkia(
        id: 16,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Fushë-Arrëz.svg.png',
        name: 'Bashkia Fushë-Arrëz',
        slug: 'bashkia-fushe-arrez',
      ),
      Bashkia(
        id: 17,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Gjirokastër.svg.png',
        name: 'Bashkia Gjirokastër',
        slug: 'bashkia-gjirokaster',
      ),
      Bashkia(
        id: 18,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Gramsh.svg.png',
        name: 'Bashkia Gramsh',
        slug: 'bashkia-gramsh',
      ),
      Bashkia(
        id: 19,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Has.svg.png',
        name: 'Bashkia Has',
        slug: 'bashkia-has',
      ),
      Bashkia(
        id: 20,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Himarë.svg_1.png',
        name: 'Bashkia Himarë',
        slug: 'bashkia-himare',
      ),
      Bashkia(
        id: 21,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Kamëz.svg.png',
        name: 'Bashkia Kamëz',
        slug: 'bashkia-kamez',
      ),
      Bashkia(
        id: 22,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Kavajë.svg.png',
        name: 'Bashkia Kavajë',
        slug: 'bashkia-kavaje',
      ),
      Bashkia(
        id: 23,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Këlcyrë.svg.png',
        name: 'Bashkia Këlcyrë',
        slug: 'bashkia-kelcyre',
      ),
      Bashkia(
        id: 24,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Klos.svg.png',
        name: 'Bashkia Klos',
        slug: 'bashkia-klos',
      ),
      Bashkia(
        id: 25,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Kolonjë.svg.png',
        name: 'Bashkia Kolonjë',
        slug: 'bashkia-kolonje',
      ),
      Bashkia(
        id: 26,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Konispol.svg.png',
        name: 'Bashkia Konispol',
        slug: 'bashkia-konispol',
      ),
      Bashkia(
        id: 27,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Korçë.svg.png',
        name: 'Bashkia Korçë',
        slug: 'bashkia-korce',
      ),
      Bashkia(
        id: 28,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Krujë.svg.png',
        name: 'Bashkia Krujë',
        slug: 'bashkia-kruje',
      ),
      Bashkia(
        id: 29,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Kuçovë.svg.png',
        name: 'Bashkia Kuçovë',
        slug: 'bashkia-kucove',
      ),
      Bashkia(
        id: 30,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Kukës.svg.png',
        name: 'Bashkia Kukës',
        slug: 'bashkia-kukes',
      ),
      Bashkia(
        id: 31,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Kurbin.svg.png',
        name: 'Bashkia Kurbin',
        slug: 'bashkia-kurbin',
      ),
      Bashkia(
        id: 32,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Lezhë.svg.png',
        name: 'Bashkia Lezhë',
        slug: 'bashkia-lezhe',
      ),
      Bashkia(
        id: 33,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Libohovë.svg.png',
        name: 'Bashkia Libohovë',
        slug: 'bashkia-libohove',
      ),
      Bashkia(
        id: 34,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Librazhd.svg.png',
        name: 'Bashkia Librazhd',
        slug: 'bashkia-librazhd',
      ),
      Bashkia(
        id: 35,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Lushnjë.svg.png',
        name: 'Bashkia Lushnjë',
        slug: 'bashkia-lushnje',
      ),
      Bashkia(
        id: 36,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Malësi_e_Madhe.svg.png',
        name: 'Bashkia Malësi e Madhe',
        slug: 'bashkia-malesi-e-madhe',
      ),
      Bashkia(
        id: 37,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Maliq.svg.png',
        name: 'Bashkia Maliq',
        slug: 'bashkia-maliq',
      ),
      Bashkia(
        id: 38,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Mallakastër.svg.png',
        name: 'Bashkia Mallakastër',
        slug: 'bashkia-mallakaster',
      ),
      Bashkia(
        id: 39,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Mat.svg_1.png',
        name: 'Bashkia Mat',
        slug: 'bashkia-mat',
      ),
      Bashkia(
        id: 40,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Memaliaj.svg.png',
        name: 'Bashkia Memaliaj',
        slug: 'bashkia-memaliaj',
      ),
      Bashkia(
        id: 41,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Mirditë.svg.png',
        name: 'Bashkia Mirditë',
        slug: 'bashkia-mirdite',
      ),
      Bashkia(
        id: 42,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Patos.svg.png',
        name: 'Bashkia Patos',
        slug: 'bashkia-patos',
      ),
      Bashkia(
        id: 43,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Peqin.svg_Y42SaaU.png',
        name: 'Bashkia Peqin',
        slug: 'bashkia-peqin',
      ),
      Bashkia(
        id: 44,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Përmet.svg.png',
        name: 'Bashkia Përmet',
        slug: 'bashkia-permet',
      ),
      Bashkia(
        id: 45,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Pogradec.svg_WeqegX.png',
        name: 'Bashkia Pogradec',
        slug: 'bashkia-pogradec',
      ),
      Bashkia(
        id: 46,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Poliçan.svg_1.png',
        name: 'Bashkia Poliçan',
        slug: 'bashkia-polican',
      ),
      Bashkia(
        id: 47,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Prrenjas.svg.png',
        name: 'Bashkia Prrenjas',
        slug: 'bashkia-prrenjas',
      ),
      Bashkia(
        id: 48,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Pukë.svg.png',
        name: 'Bashkia Pukë',
        slug: 'bashkia-puke',
      ),
      Bashkia(
        id: 49,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Pustec.svg.png',
        name: 'Bashkia Pustec',
        slug: 'bashkia-pustec',
      ),
      Bashkia(
        id: 50,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Rrogozhinë.svg.png',
        name: 'Bashkia Rrogozhinë',
        slug: 'bashkia-rrogozhine',
      ),
      Bashkia(
        id: 51,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Sarandë.svg.png',
        name: 'Bashkia Sarandë',
        slug: 'bashkia-sarande',
      ),
      Bashkia(
        id: 52,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Selenicë.svg_7weWVlY.png',
        name: 'Bashkia Selenicë',
        slug: 'bashkia-selenice',
      ),
      Bashkia(
        id: 53,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Shijak.svg.png',
        name: 'Bashkia Shijak',
        slug: 'bashkia-shijak',
      ),
      Bashkia(
        id: 54,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Shkodër.svg.png',
        name: 'Bashkia Shkodër',
        slug: 'bashkia-shkoder',
      ),
      Bashkia(
        id: 55,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Skrapar.svg.png',
        name: 'Bashkia Skrapar',
        slug: 'bashkia-skrapar',
      ),
      Bashkia(
        id: 56,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Tepelenë.svg.png',
        name: 'Bashkia Tepelenë',
        slug: 'bashkia-tepelene',
      ),
      Bashkia(
        id: 57,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Tiranë.svg_1.png',
        name: 'Bashkia Tiranë',
        slug: 'bashkia-tirane',
      ),
      Bashkia(
        id: 58,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Tropojë.svg.png',
        name: 'Bashkia Tropojë',
        slug: 'bashkia-tropoje',
      ),
      Bashkia(
        id: 59,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Ura_Vajgurore.svg.png',
        name: 'Bashkia Ura Vajgurore',
        slug: 'bashkia-ura-vajgurore',
      ),
      Bashkia(
        id: 60,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Vau_i_Dejës.svg.png',
        name: 'Bashkia Vau i Dejës',
        slug: 'bashkia-vau-i-dejes',
      ),
      Bashkia(
        id: 61,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Vlorë.svg.png',
        name: 'Bashkia Vlorë',
        slug: 'bashkia-vlore',
      ),
      Bashkia(
        id: 62,
        icon:
            'https://integritet.optech.al/media/municipality_icons/Stema_e_Bashkisë_Vorë.svg.png',
        name: 'Bashkia Vorë',
        slug: 'bashkia-vore',
      ),
    ];
  }

  static fromJson(json) {
    return Bashkia(
      id: json['id'],
      icon: utf8.decode(json['icon'].toString().codeUnits),
      name: utf8.decode(json['name'].toString().codeUnits),
      slug: json['slug'],
    );
  }
}
