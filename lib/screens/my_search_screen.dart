import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:integriteti_zgjedhor_app/widgets/info_box.dart';
import 'package:integriteti_zgjedhor_app/widgets/my_app_bar.dart';

class MySearchScreen extends StatefulWidget {
  const MySearchScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MySearchScreen> {
  final _searchController = TextEditingController();
  bool _searchSuccessful = false;
  Map _responseData = {};

  final newTargatRegex = RegExp(r'^[A-Z]{2}[0-9]{3}[A-Z]{2}$');
  final oldTargatRegex = RegExp(r'^[A-Z]{2}[0-9]{4}[A-Z]{1}$');
  final diplomatTargatRegex = RegExp(r'^[A-Z]{2}[0-9]{4}[A-Z]{1}$');

  Future _fetchData() async {
    if (_searchController.text.isEmpty) {
      return {};
    }

    final response = await http.get(Uri.parse(
        'https://integritet.optech.al/api/plates/${_searchController.text}/'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      if (kDebugMode) {
        print('Error _fetchData Targat: ${response.statusCode}');
      }
      return {};
    }
  }

  _submitSearch(value) async {
    if (value.isEmpty) {
      return;
    }

    final data = await _fetchData();
    setState(() {
      _searchSuccessful = true;
      _responseData = data;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'KONTROLLO TARGAT',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 18.0, left: 18.0, right: 18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 18),
                      decoration: BoxDecoration(
                        color: kBackground,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: kFontLight.withOpacity(0.2),
                            offset: const Offset(0, 12),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Kërko targat (psh. AA123BB)',
                          hintStyle: const TextStyle(color: kFontLight),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () =>
                                _submitSearch(_searchController.text),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '*Të dhënat që gjenden në databazën tonë janë të dhëna zyrtare, të marra nga institucionet publike.',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (!_searchSuccessful && !_responseData.isNotEmpty)
                    Column(children: const [
                      SizedBox(height: 16.0),
                      InfoBox(
                        title: 'Çfarë thotë kodi zgjedhor?',
                        subtitle:
                            'Referuar nenit 91 dhe 92 të Kodit Zgjedhor të Republikës së Shqipërisë, automjetet në pronësi të institucioneve shtetërore nuk mund të përdoren për efekt mbështetjeje gjatë fushatës elektorale të subjekteve zgjedhorë.',
                        secondaryTitle: 'Ke hasur një shkelje?',
                        secondarySubtitle:
                            'Nëse ke hasur një shkelje të këtij lloji, raportoje atë nëpërmjet sistemit tonë të raportimit.',
                        buttonText: 'Raporto Shkeljen',
                        goToPath: '/report',
                      )
                    ]),
                ],
              ),
            ),
            if (_searchSuccessful && _responseData.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Rezultatet e kërkimit',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Targa ',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade700,
                              ),
                              children: [
                                TextSpan(
                                  text: '"${_searchController.text}"',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: ' u gjend.'),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 300,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/targa_found.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, bottom: 16.0),
                            child: Text(
                              '''Targa të cilën keni kërkuar, sipas burimeve të Qëndresës Qytetare rezulton të jetë pronë e institucioneve shtetërore.''',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade700,
                                letterSpacing: 1.2,
                                wordSpacing: 1.6,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 0.0,
                              right: 0.0,
                              bottom: 12.0,
                              top: 16.0,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'TARGA:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          _responseData['plate_no'].toString(),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Color.fromARGB(
                                                255, 110, 110, 110),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'INSTITUCIONI:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          _responseData['institution']
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: // based on the length of the institution name
                                                _responseData['institution']
                                                            .toString()
                                                            .length >
                                                        30
                                                    ? 13.0
                                                    : 16.0,
                                            color: const Color.fromARGB(
                                                255, 110, 110, 110),
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: 16.0,
                                top: 16.0),
                            child: Text(
                              '''
Përdor butonin raporto shkeljen për të denoncuar keqpërdorimin e këtij aseti publik!''',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade700,
                                letterSpacing: 1.2,
                                wordSpacing: 1.6,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const InfoBox(
                            title: 'Çfarë thotë kodi zgjedhor?',
                            subtitle:
                                'Referuar nenit 91 dhe 92 të Kodit Zgjedhor të Republikës së Shqipërisë, automjetet në pronësi të institucioneve shtetërore nuk mund të përdoren për efekt mbështetjeje gjatë fushatës elektorale të subjekteve zgjedhorë.',
                            secondaryTitle: 'Ke hasur një shkelje?',
                            secondarySubtitle:
                                'Nëse ke hasur një shkelje të këtij lloji, raportoje atë nëpërmjet sistemit tonë të raportimit.',
                            buttonText: 'Raporto Shkeljen',
                            goToPath: '/report',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (_searchSuccessful && _responseData.isEmpty)
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/targa_no_info.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _searchController.text.isEmpty
                        ? const Text(
                            'Ju lutem vendoni një targë.',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 110, 109, 109),
                            ),
                          )
                        : // _searchController.text regex check format (AA123BB)
                        !newTargatRegex.hasMatch(_searchController.text) &&
                                !oldTargatRegex
                                    .hasMatch(_searchController.text) &&
                                !diplomatTargatRegex
                                    .hasMatch(_searchController.text)
                            ? const Text(
                                'Ju lutem vendoni një targë të vlefshme.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 110, 109, 109),
                                ),
                              )
                            : Text.rich(
                                TextSpan(
                                  text: 'Targa ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey.shade700,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '"${_searchController.text}"',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(text: ' nuk u gjend.'),
                                  ],
                                ),
                              ),
                    const SizedBox(height: 8.0),
                    _searchController.text.isEmpty
                        ? const SizedBox.shrink()
                        : !newTargatRegex.hasMatch(_searchController.text) &&
                                !oldTargatRegex
                                    .hasMatch(_searchController.text) &&
                                !diplomatTargatRegex
                                    .hasMatch(_searchController.text)
                            ? const Text(
                                'Formatet: AA123BB/TR1234A/CD0123A',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 110, 109, 109),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Sipas burimeve të Qëndresës Qytetare kjo targë nuk rezulton të jetë në pronësi të institucioneve publike.',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey.shade700,
                                    letterSpacing: 1.2,
                                    wordSpacing: 1.6,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                    const SizedBox(height: 16.0),
                    const InfoBox(
                      title: 'Çfarë thotë kodi zgjedhor?',
                      subtitle:
                          'Referuar nenit 91 dhe 92 të Kodit Zgjedhor të Republikës së Shqipërisë, automjetet në pronësi të institucioneve shtetërore nuk mund të përdoren për efekt mbështetjeje gjatë fushatës elektorale të subjekteve zgjedhorë.',
                      secondaryTitle: 'Ke hasur një shkelje?',
                      secondarySubtitle:
                          'Nëse ke hasur një shkelje të këtij lloji, raportoje atë nëpërmjet sistemit tonë të raportimit.',
                      buttonText: 'Raporto Shkeljen',
                      goToPath: '/report',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
