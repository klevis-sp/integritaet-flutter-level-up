import 'dart:convert';

import 'package:flutter/foundation.dart';

class Shkelesi {
  Shkelesi({
    required this.id,
    required this.profilePicture,
    required this.offenderType,
    required this.totalViolationScore,
    required this.institutionName,
    required this.institutionId,
    required this.connectedMunicipalityName,
    required this.connectedMunicipalityId,
    required this.name,
    required this.position,
    required this.showFrontend,
    required this.gender,
    required this.slug,
  });

  int id;
  String profilePicture;
  String offenderType;
  int totalViolationScore;
  String institutionName;
  int institutionId;
  String connectedMunicipalityName;
  int connectedMunicipalityId;
  String name;
  String position;
  bool showFrontend;
  String gender;
  String slug;

  factory Shkelesi.fromJson(Map<String, dynamic> json) {
    return Shkelesi(
      id: json['id'] as int,
      profilePicture: json['profile_picture'] as String,
      offenderType: utf8.decode(json['offender_type'].toString().codeUnits),
      totalViolationScore: json['total_violation_score'] as int,
      institutionName:
          utf8.decode(json['institution_name'].toString().codeUnits),
      institutionId: json['institution_id'] as int,
      connectedMunicipalityName:
          utf8.decode(json['connected_municipality_name'].toString().codeUnits),
      connectedMunicipalityId: json['connected_municipality_id'] as int,
      name: json['name'] as String,
      position: utf8.decode(json['position'].toString().codeUnits),
      showFrontend: json['show_frontend'] as bool,
      gender: json['gender'] as String,
      slug: json['slug'] as String,
    );
  }

  // generate list of active courses
  static List<Shkelesi> generateFakeShkelesit() {
    return [
      Shkelesi(
        id: 6,
        profilePicture:
            "https://integritet.optech.al/media/person_pics/Female-Avatar_KomBrsD.png",
        offenderType: "Zyrtare",
        totalViolationScore: 10,
        institutionName: "Bashkia Durres",
        institutionId: 1,
        connectedMunicipalityName: "Bashkia Durres",
        connectedMunicipalityId: 1,
        name: "Dhurata Gjoka",
        position: "Drejtoreshë e Burimeve Njerëzore",
        showFrontend: true,
        gender: "F",
        slug: "dhurata-gjoka",
      ),
      Shkelesi(
        id: 6,
        profilePicture:
            "https://integritet.optech.al/media/person_pics/Female-Avatar_KomBrsD.png",
        offenderType: "Zyrtare",
        totalViolationScore: 10,
        institutionName: "Bashkia Durres",
        institutionId: 1,
        connectedMunicipalityName: "Bashkia Durres",
        connectedMunicipalityId: 1,
        name: "Delina Hoxha",
        position: "Drejtoreshë e Burimeve Njerëzore",
        showFrontend: true,
        gender: "F",
        slug: "delina-hoxha",
      ),
      Shkelesi(
        id: 6,
        profilePicture:
            "https://integritet.optech.al/media/person_pics/Female-Avatar_KomBrsD.png",
        offenderType: "Zyrtare",
        totalViolationScore: 10,
        institutionName: "Bashkia Durres",
        institutionId: 1,
        connectedMunicipalityName: "Bashkia Durres",
        connectedMunicipalityId: 1,
        name: "Martin Dodi",
        position: "Drejtoreshë e Burimeve Njerëzore",
        showFrontend: true,
        gender: "F",
        slug: "martin-dodi",
      ),
    ];
  }

  // generate getActiveCourseById method
  static Shkelesi getShkelesBySlug(String slug) {
    if (kDebugMode) {
      print('getShkelesBySlug: $slug');
    }
    return generateFakeShkelesit()
        .firstWhere((shkeles) => shkeles.slug == slug);
  }
}
