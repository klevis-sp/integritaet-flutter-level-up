import 'package:integriteti_zgjedhor_app/models/report_report.dart';
import 'package:integriteti_zgjedhor_app/models/shkelesi.dart';
import 'package:integriteti_zgjedhor_app/models/violation_report.dart';

class ShkelesiProfile {
  ShkelesiProfile({
    required this.person,
    required this.violations,
    required this.reports,
  });

  Shkelesi person;
  List<ViolationReport> violations;
  List<Report> reports;

  factory ShkelesiProfile.fromJson(Map<String, dynamic> json) {
    return ShkelesiProfile(
      person: Shkelesi.fromJson(json['person']),
      violations: List<ViolationReport>.from(json['violations'].map((x) => ViolationReport.fromJson(x))),
      reports: List<Report>.from(json['reports'].map((x) => Report.fromJson(x))),
    );
  }

  // empty response factory
  static ShkelesiProfile generateEmptyShkelesiProfile() {
    return ShkelesiProfile(
      person: Shkelesi(
        id: 666,
        profilePicture: "https://integritet.optech.al/media/person_pics/Female-Avatar_KomBrsD.png",
        offenderType: "Zyrtare",
        totalViolationScore: 1890,
        institutionName: "Bashkia e Panjohur",
        institutionId: 666,
        connectedMunicipalityName: "Bashkia e Panjohur",
        connectedMunicipalityId: 1,
        name: "Emer Mbiemer",
        position: "Nuk ka info",
        showFrontend: true,
        gender: "F",
        slug: "emer-mbiemer",
      ),
      violations: [],
      reports: [],
    );
  }
}
