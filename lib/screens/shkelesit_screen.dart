import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';
import 'package:integriteti_zgjedhor_app/models/shkelesi.dart';
import 'package:http/http.dart' as http;
import 'package:integriteti_zgjedhor_app/widgets/filter_button.dart';
import 'package:integriteti_zgjedhor_app/widgets/person_list_item.dart';

class ShkelesitScreen extends StatefulWidget {
  const ShkelesitScreen({Key? key}) : super(key: key);

  @override
  _ShkelesitState createState() => _ShkelesitState();
}

class _ShkelesitState extends State<ShkelesitScreen> {
  String _selectedOffenderType = 'Të gjithë';
  // https://integritet.optech.al/api/people/list/ => [{},{},{}]

  Future<List<Shkelesi>> _fetchData() async {
    final response = await http
        .get(Uri.parse('https://integritet.optech.al/api/people/list/'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final shkelesit =
          jsonData.map((data) => Shkelesi.fromJson(data)).toList();
      return shkelesit;
    } else {
      print('Error: ${response.statusCode}');
      return Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Të gjithë zyrtarët dhe kandidatët',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        actions: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0, right: 20),
                padding: const EdgeInsets.only(right: 3),
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
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 6, top: 3, bottom: 3),
                  child: Image(
                    image: AssetImage('assets/app_icon/icon.png'),
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilterButton(
                text: "Të gjithë",
                isSelected: _selectedOffenderType == "Të gjithë",
                onTap: () => setState(
                  () => _selectedOffenderType = 'Të gjithë',
                ),
              ),
              FilterButton(
                text: "Zyrtar/e",
                isSelected: _selectedOffenderType == "Zyrtar/e",
                onTap: () => setState(
                  () => _selectedOffenderType = 'Zyrtar/e',
                ),
              ),
              FilterButton(
                text: "Kandidat/e",
                isSelected: _selectedOffenderType == "Kandidat/e",
                onTap: () => setState(
                  () => _selectedOffenderType = 'Kandidat/e',
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: _fetchData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<dynamic> shkelesit = snapshot.data;

                  if (_selectedOffenderType != 'Të gjithë') {
                    shkelesit = shkelesit
                        .where(
                          // (shkelesi) => shkelesi.offenderType?.includes(_selectedOffenderType) ?? false,
                          // _selectedOffenderType first 4 letters are the same as offenderType first 4 letters
                          (shkelesi) =>
                              shkelesi.offenderType?.substring(0, 4) ==
                              _selectedOffenderType.substring(0, 4),
                        )
                        .toList();
                  }
                  return shkelesit.isNotEmpty
                      ? ListView.builder(
                          itemCount: shkelesit.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PersonListItem(
                              profilePicture: shkelesit[index].profilePicture,
                              name: shkelesit[index].name,
                              offenderType: shkelesit[index].offenderType,
                              position: shkelesit[index].position,
                              municipality:
                                  shkelesit[index].connectedMunicipalityName,
                              goToPath: '/shkelesit/${shkelesit[index].slug}',
                            );
                          },
                        )
                      : const Center(
                          child: Text('Për këtë kategori nuk ka të dhëna.'),
                        );
                } else {
                  return const Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
