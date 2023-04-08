import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:integriteti_zgjedhor_app/models/shkelesi_profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.slug});

  final String? slug;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  Future<ShkelesiProfile> _fetchShkelesProfile(String slug) async {
    final response = await http.get(Uri.parse('https://integritet.optech.al/api/people/single/${widget.slug}/'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final shkelesiProfile = ShkelesiProfile.fromJson(jsonData);
      return shkelesiProfile;
    } else {
      if (kDebugMode) {
        print('Error _fetchShkelesProfile: ${response.body}');
      }
      return ShkelesiProfile.generateEmptyShkelesiProfile();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("ProfileScreen: ${widget.slug}");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profili',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _fetchShkelesProfile(widget.slug!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // filter the list of shkelesit by slug and get the first item
            final shkelesi = snapshot.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(shkelesi.person.profilePicture),
                          ),
                          Text(
                            '${shkelesi.person.name}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${shkelesi.person.offenderType}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${shkelesi.person.connectedMunicipalityName}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${shkelesi.person.position}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: DChartBar(
                          data: [
                            {
                              'id': 'Bar',
                              'data': [
                                {'domain': 'Denoncime', 'measure': shkelesi.reports.length},
                                {'domain': 'Shkelje', 'measure': shkelesi.violations.length},
                              ],
                            },
                          ],
                          domainLabelPaddingToAxisLine: 26,
                          axisLineTick: 2,
                          axisLinePointTick: 2,
                          axisLinePointWidth: 6,
                          axisLineColor: kFont,
                          measureLabelPaddingToAxisLine: 16,
                          barColor: (barData, index, id) => kFont,
                          showBarValue: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18.0,
                        right: 18.0,
                        top: 18.0,
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: shkelesi.person.gender == 'M' ? 'Për zyrtarin ' : 'Për zyrtaren ',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: shkelesi.person.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const TextSpan(
                              text: ' në bashkinë ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: shkelesi.person.connectedMunicipalityName.substring(8),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const TextSpan(
                              text: ', KQZ ka konstatuar ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: '${shkelesi.violations.length} shkelje',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const TextSpan(
                              text: ' ndërsa në platformën Integriteti Zgjedhor kanë mbërritur ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: shkelesi.reports.length > 1
                                  ? '${shkelesi.reports.length} denoncime.'
                                  : '${shkelesi.reports.length} denoncim.',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    // horizontal line
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 0.0),
                      child: Divider(
                        color: Colors.grey.shade200,
                        thickness: 1.6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18.0,
                        right: 18.0,
                        bottom: 6.0,
                      ),
                      child: Text(
                        "*Shkeljet konstatohen nga Komisioni Qendror i Zgjedhjeve dhe publikohen në listën e mëposhtme. Denoncimet kryen nga ekipi i vëzhguesve zgjedhorë të akredituar të Qëndresës Qytetare.",
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 6.0),
                      child: shkelesi.violations[0].proof == null
                          ? const SizedBox.shrink()
                          : Html(
                              data: shkelesi.violations[0].proof,
                              onLinkTap: (url, _, __, ___) {
                                if (url != null) {
                                  launchUrl(Uri.parse(url));
                                }
                              },
                            ),
                      //InfoBox(
                      //  title: 'Lista e Shkeljeve:',
                      //  text: 'Raportim i veprimtarisë publike, përtej afatit ligjor të parashikuar nga Kodi Zgjedhor.',
                      //),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}

class InfoBox extends StatefulWidget {
  const InfoBox({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String title;
  final String text;

  @override
  State<InfoBox> createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> {
  final Uri _url = Uri.parse(
      'https://kqz.gov.al/document/vendim-nr-9-date-27-02-2023-per-pranimin-per-shqyrtim-te-kerkeses-se-komisionerit-shteteror-te-zgjedhjeve-nr-06-date-17-02-2023/');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 242, 227, 228),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Divider(
            color: Colors.grey.shade200,
            thickness: 1.6,
          ),
          const SizedBox(height: 8),
          const Text(
            'Më shumë detaje:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              text: 'Linku i vendimit të KQZ: ',
              style: const TextStyle(
                color: kFont,
                fontWeight: FontWeight.normal,
                fontSize: 14.0,
              ),
              children: [
                TextSpan(
                    text:
                        'https://kqz.gov.al/document/vendim-nr-9-date-27-02-2023-per-pranimin-per-shqyrtim-te-kerkeses-se-komisionerit-shteteror-te-zgjedhjeve-nr-06-date-17-02-2023/ ',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.red,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(_url);
                      }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
