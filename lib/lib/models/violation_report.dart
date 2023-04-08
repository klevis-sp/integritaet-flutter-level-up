class ViolationReport {
  ViolationReport({
    required this.id,
    required this.shortDescription,
    required this.commitedOn,
    required this.proof,
    required this.linkProof,
    required this.picture,
    required this.createdOn,
    required this.showFrontend,
    required this.violationType,
    required this.violationTotal,
    required this.slug,
    required this.person,
  });

  int id;
  String shortDescription;
  String commitedOn;
  String? proof;
  String? linkProof;
  String picture;
  String createdOn;
  bool showFrontend;
  List violationType;
  int violationTotal;
  String slug;
  int person;

  factory ViolationReport.fromJson(Map<String, dynamic> json) {
    return ViolationReport(
      id: json['id'],
      shortDescription: json['short_description'] as String,
      commitedOn: json['commited_on'] as String,
      proof: json['proof'] as String?,
      linkProof: json['link_proof'],
      picture: json['picture'] as String,
      createdOn: json['created_on'] as String,
      showFrontend: json['show_frontend'] as bool,
      violationType: json['violation_type'] as List,
      violationTotal: json['violation_total'] as int,
      slug: json['slug'] as String,
      person: json['person'] as int,
    );
  }

  // empty response factory

  // generate list of active courses
  static List<ViolationReport> generateFakeShkelesit() {
    return [
      ViolationReport(
        id: 6,
        shortDescription: 'shortDescription',
        commitedOn: 'committedOn',
        proof: 'proof',
        linkProof: 'linkProof',
        picture: 'picture',
        createdOn: 'createdOn',
        showFrontend: true,
        violationType: ['violationType'],
        violationTotal: 10,
        slug: 'slug',
        person: 1,
      ),
      ViolationReport(
        id: 8,
        shortDescription: 'shortDescription',
        commitedOn: 'committedOn',
        proof: 'proof',
        linkProof: 'linkProof',
        picture: 'picture',
        createdOn: 'createdOn',
        showFrontend: true,
        violationType: ['violationType'],
        violationTotal: 10,
        slug: 'slug',
        person: 2,
      )
    ];
  }

  // generate getActiveCourseById method
  static ViolationReport getViolationBySlug(String slug) {
    return generateFakeShkelesit().firstWhere((viol) => viol.slug == slug);
  }
}
