class Report {
  Report({
    required this.name,
    required this.municipalityFl,
    required this.reportDate,
    required this.proof,
    required this.linkProof,
    required this.informationSource,
    required this.perpetrator,
    required this.gender,
    required this.commitedOffence,
    required this.placeOfOffence,
    required this.phoneOfReporter,
    required this.proofFile,
  });

  String name;
  int municipalityFl;
  String reportDate;
  String informationSource;
  String perpetrator;
  String gender;
  String commitedOffence;
  String placeOfOffence;
  String? proof;
  String? linkProof;
  String? phoneOfReporter;
  String? proofFile;

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      name: json['name'],
      municipalityFl: json['municipality_fl'],
      reportDate: json['report_date'],
      informationSource: json['information_source'],
      perpetrator: json['perpetrator'],
      gender: json['gender'],
      commitedOffence: json['commited_offence'],
      placeOfOffence: json['place_of_offence'],
      proof: json['proof'],
      linkProof: json['link_proof'],
      phoneOfReporter: json['phone_of_reporter'],
      proofFile: json['proof_file'],
    );
  }
}
