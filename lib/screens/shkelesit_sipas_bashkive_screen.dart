import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/models/bashkia.dart';
import 'package:integriteti_zgjedhor_app/models/shkelesi.dart';
import 'package:integriteti_zgjedhor_app/widgets/filter_button.dart';
import 'package:integriteti_zgjedhor_app/widgets/person_list_item.dart';
import 'package:http/http.dart' as http;

class ShkelesitSipasBashkiveScreen extends StatefulWidget {
  const ShkelesitSipasBashkiveScreen({Key? key}) : super(key: key);

  @override
  _ShkelesitSipasBashkiveState createState() => _ShkelesitSipasBashkiveState();
}

class _ShkelesitSipasBashkiveState extends State<ShkelesitSipasBashkiveScreen> {
  String _selectedBashkia = 'Të gjitha bashkitë';
  final List<String> _listaBashkive = [
    'Të gjitha bashkitë',
  ];

  @override
  void initState() {
    super.initState();

    // Populate bashkia options from API endpoint
    _getBashkiaList().then((bashkiaData) {
      setState(() {
        bashkiaList = bashkiaData;
      });
    });
  }

  List<Bashkia> bashkiaList = []; // empty list of municipalities

  Future<List<Bashkia>> _getBashkiaList() async {
    try {
      final response = await http.get(Uri.parse('https://integritet.optech.al/api/municipality/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Bashkia> bashkiaData = data.map<Bashkia>((json) => Bashkia.fromJson(json)).toList();
        // sort alphabetically by municipality name after substring 8 (Bashkia )
        bashkiaData.sort((a, b) => a.name.substring(8).compareTo(b.name.substring(8)));
        _listaBashkive.addAll(bashkiaData.map((e) => e.name).toList());
        return bashkiaData;
      } else {
        return Bashkia.generateStaticBashkiaList();
      }
    } catch (e) {
      print(e);
      return Bashkia.generateStaticBashkiaList();
    }
  }

  Future<List<Shkelesi>> _fetchData() async {
    final response = await http.get(Uri.parse('https://integritet.optech.al/api/people/list/'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final shkelesit = jsonData.map((data) => Shkelesi.fromJson(data)).toList();

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
        leading: InkWell(
          onTap: () => context.go('/home'),
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Shkelësit sipas bashkive',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        actions: [
          // filter with dropdown to pick a bashkia
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (String value) {
              setState(() {
                _selectedBashkia = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return _listaBashkive.map((String value) {
                return PopupMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _listaBashkive.length,
              itemBuilder: (context, index) {
                return FilterButton(
                  text: _listaBashkive[index],
                  isSelected: _selectedBashkia == _listaBashkive[index],
                  onTap: () => setState(
                    () => _selectedBashkia = _listaBashkive[index],
                  ),
                  icon: bashkiaList.isEmpty
                      ? null
                      : bashkiaList
                          .firstWhere(
                            (bashkia) => bashkia.name == _listaBashkive[index],
                            orElse: () => Bashkia(
                              id: 0,
                              name: 'Të gjitha bashkitë',
                              icon: 'assets/icons/instuticion_kandidat.png',
                              slug: 'te-gjitha-bashkite',
                            ),
                          )
                          .icon,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 1);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _fetchData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Shkelesi> shkelesit = snapshot.data;
                  if (_selectedBashkia != 'Të gjitha bashkitë') {
                    shkelesit =
                        shkelesit.where((shkelesi) => shkelesi.connectedMunicipalityName == _selectedBashkia).toList();
                  }
                  if (shkelesit.isEmpty) {
                    return Scaffold(
                      body: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: _selectedBashkia,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' nuk ka asnjë kandidat/zyrtar në bazën tonë të të dhënave.',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: shkelesit.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PersonListItem(
                        profilePicture: shkelesit[index].profilePicture,
                        name: shkelesit[index].name,
                        offenderType: shkelesit[index].offenderType,
                        position: shkelesit[index].position,
                        municipality: shkelesit[index].connectedMunicipalityName,
                        goToPath: '/shkelesit/${shkelesit[index].slug}',
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Ka ndodhur një gabim',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
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
          ),
        ],
      ),
    );
  }
}
