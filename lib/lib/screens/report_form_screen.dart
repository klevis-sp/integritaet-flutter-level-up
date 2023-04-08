import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/models/bashkia.dart';
import 'package:integriteti_zgjedhor_app/widgets/my_cupertino_action_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  _ReportFormScreenState createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameSurnameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _bashkiaController = TextEditingController();
  final _fieldShkeljaVezhguar = TextEditingController();
  final _fieldVendiController = TextEditingController();
  final _fieldDataShkeljesController = TextEditingController();
  final _fieldGjiniaController = TextEditingController();
  final _fieldBurimiInformacionitController = TextEditingController();
  final _fieldkryeresiShkeljesController = TextEditingController();
  final _fieldLinkController = TextEditingController();
  final _fieldNrTelController = TextEditingController();
  // file picker variables
  File _pickedFile = File('');
  set _setPickedFile(File file) {
    setState(() {
      _pickedFile = file;
    });
  }

  @override
  void initState() {
    super.initState();
    _fieldGjiniaController.text = 'M';
    _fieldDataShkeljesController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // Populate bashkia options from API endpoint
    _getBashkiaList().then((bashkiaData) {
      setState(() {
        bashkiaList = bashkiaData;
      });
    });
  }

  bool _formSubmitted = false;

  List<Bashkia> bashkiaList = []; // empty list of municipalities

  Future<List<Bashkia>> _getBashkiaList() async {
    try {
      final response = await http.get(Uri.parse('https://integritet.optech.al/api/municipality/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Bashkia> bashkiaData = data.map<Bashkia>((json) => Bashkia.fromJson(json)).toList();
        return bashkiaData;
      } else {
        return Bashkia.generateStaticBashkiaList();
      }
    } catch (e) {
      print(e);
      return Bashkia.generateStaticBashkiaList();
    }
  }

  final List<String> _burimiInformacionitOptions = [
    'Media',
    'Rrjete sociale',
    'Votues',
    'Kandidatet Politike',
    'Terreni',
    'Tjeter'
  ];

  final List<String> _kryeresiShkeljesOptions = [
    'Garues elektoral - parti politike',
    'Garues elektoral - kandidat',
    'Organi i administratës zgjedhore',
    'Nëpunës publik',
    'Zyrtar i zgjedhur (për shembull Anëtar i Këshillit Bashkiak)',
  ];

  _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Perform submit operation here
      print('Form submitted');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://integritet.optech.al/api/reports/create/'),
      );

      request.fields['name'] = _nameSurnameController.text.isEmpty ? ' ' : _nameSurnameController.text;
      request.fields['description'] = _descriptionController.text.isEmpty ? ' ' : _descriptionController.text;

      // find the id of the selected municipality from the list and add it to the request municipality_fl field
      request.fields['municipality_fl'] = _bashkiaController.text.isEmpty
          ? '1'
          : bashkiaList.firstWhere((element) => element.name == _bashkiaController.text).id.toString();

      //_bashkiaController.text.substring(8, _bashkiaController.text.length);
      request.fields['commited_offence'] = _fieldShkeljaVezhguar.text.isEmpty ? ' ' : _fieldShkeljaVezhguar.text;
      request.fields['place_of_offence'] = _fieldVendiController.text.isEmpty ? ' ' : _fieldVendiController.text;
      request.fields['report_date'] = DateFormat('yyy-MM-dd').format(DateTime.parse(_fieldDataShkeljesController.text));
      request.fields['gender'] = _fieldGjiniaController.text.isEmpty ? ' ' : _fieldGjiniaController.text;
      request.fields['information_source'] =
          _fieldBurimiInformacionitController.text.isEmpty ? 'Tjeter' : _fieldBurimiInformacionitController.text;
      request.fields['perpetrator'] = _fieldkryeresiShkeljesController.text.isEmpty
          ? 'Garues elektoral - parti politike'
          : _fieldkryeresiShkeljesController.text;
      request.fields['link_proof'] = _fieldLinkController.text.isEmpty ? ' ' : _fieldLinkController.text;
      request.fields['phone_of_reporter'] = _fieldNrTelController.text.isEmpty ? ' ' : _fieldNrTelController.text;

      if (_pickedFile.path.isNotEmpty) {
        // add the file to the request
        request.headers.addAll({
          'Content-Type': 'multipart/form-data',
        });

        List<int> fileBytes = _pickedFile.readAsBytesSync();
        request.files.add(
          http.MultipartFile(
            'proof',
            http.ByteStream.fromBytes(fileBytes),
            fileBytes.length,
            filename: _pickedFile.path.split('/').last,
          ),
        );
      }

      request.send().then((response) {
        if (response.statusCode == 201) {
          print("response.statusCode: ${response.statusCode}");
          response.stream.bytesToString().then((value) => print("response.body: $value"));
          print('Uploaded!');
          setState(() {
            _formSubmitted = true;
          });
        } else {
          print("response.statusCode: ${response.statusCode}");
          response.stream.bytesToString().then((value) => print("response.body: $value"));
          print('Upload failed');
          setState(() {
            _formSubmitted = true;
          });
        }
      });

      setState(() {
        _formSubmitted = true;
      });
    }
  }

  void _resetForm() {
    setState(() {
      _formSubmitted = false;
    });
  }

  String reportPageInfo =
      'Ju po sinjalizoni për shkeljen e Kodit Zgjedhor si shit-blerja e votës, keqpërdorimi i burimeve shteterore dhe krimet zgjedhore. Për më shumë informacion sesi administrohen këto raportime, ju lutem ';

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;

    // Open the single file
    final file = result.files.first;
    final pickedFile = await saveFilePermanently(file);

    // set the picked file to the global variable
    _setPickedFile = pickedFile;
  }

  Future<File> saveFilePermanently(PlatformFile? file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file?.name}');

    return File(file!.path!).copy(newFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Raporto shkelje',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
      body: _formSubmitted
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Shkelja u raportua me sukses!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _resetForm,
                        child: const Text('Raporto një shkelje tjetër'),
                      ),
                      OutlinedButton(
                        onPressed: () => context.go('/home'),
                        child: const Text(
                          'Kthehu në faqen kryesore',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        Text.rich(
                          TextSpan(
                            text: reportPageInfo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            children: [
                              TextSpan(
                                text: 'klikoni këtu.',
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.push(
                                      '/privacy-policy',
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // emri dhe mbiemri
                        CupertinoTextFormFieldRow(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22.0,
                            vertical: 8.0,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: CupertinoColors.separator,
                                width: 0.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          prefix: const Icon(CupertinoIcons.person),
                          placeholder: 'Emri dhe mbiemri i shkelësit',
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          onChanged: (value) {
                            setState(() {
                              _nameSurnameController.text = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ju lutem shkruani emrin dhe mbiemrin e shkelësit';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // Bashkia
                        GestureDetector(
                          child: Stack(
                            children: [
                              CupertinoTextFormFieldRow(
                                smartDashesType: SmartDashesType.disabled,
                                controller: _bashkiaController,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22.0,
                                  vertical: 8.0,
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: CupertinoColors.separator,
                                      width: 0.0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                prefix: const Icon(Icons.domain),
                                placeholder: 'Bashkia',
                                keyboardType: TextInputType.none,
                                textCapitalization: TextCapitalization.words,
                                autocorrect: false,
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => MyCupertinoActionSheet(
                                      controller: _bashkiaController,
                                      options: bashkiaList.map((bashkia) => bashkia.name).toList(),
                                      sheetTitle: 'Zgjidhni bashkinë',
                                      sheetSubtitle: 'Ju lutem zgjidhni bashkinë ku ka ndodhur shkelja',
                                    ),
                                  );
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Ju lutem zgjidhni bashkinë ku ka ndodhur shkelja';
                                  }
                                  return null;
                                },
                              ),
                              const Positioned(
                                top: 6,
                                right: 26,
                                child: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 26,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => MyCupertinoActionSheet(
                                controller: _bashkiaController,
                                sheetTitle: 'Zgjidhni bashkinë',
                                sheetSubtitle: 'Ju lutem zgjidhni bashkinë ku ka ndodhur shkelja',
                                options: bashkiaList.map((bashkia) => bashkia.name).toList(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // Description field
                        CupertinoTextFormFieldRow(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22.0,
                            vertical: 8.0,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: CupertinoColors.separator,
                                width: 0.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          prefix: const Icon(CupertinoIcons.t_bubble),
                          minLines: 1,
                          maxLines: 5,
                          placeholder: 'Përshkruani shkeljen e vëzhguar',
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          onChanged: (value) {
                            setState(() {
                              _fieldShkeljaVezhguar.text = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Kjo fushë nuk mund të lihet bosh';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // vendi field
                        CupertinoTextFormFieldRow(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22.0,
                            vertical: 8.0,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: CupertinoColors.separator,
                                width: 0.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          prefix: const Icon(CupertinoIcons.placemark),
                          placeholder: 'Vendi ku ka ndodhur shkelja e supozuar',
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          onChanged: (value) {
                            setState(() {
                              _fieldVendiController.text = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Ju lutem vendosni vendin';
                            }

                            return null;
                          },
                        ),

                        // Data e shkeljes
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FastDatePicker(
                            icon: const Icon(CupertinoIcons.calendar),
                            adaptive: true,
                            modalCancelButtonText: 'Anulo',
                            name: 'Data e shkeljes',
                            labelText: 'Data e shkeljes',
                            onChanged: (value) {
                              setState(() {
                                _fieldDataShkeljesController.text = value.toString();
                              });
                            },
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 365),
                            ),
                            lastDate: DateTime.now().add(
                              const Duration(minutes: 30),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FastSegmentedControl(
                            name: 'field_destination',
                            labelText: 'Gjinia',
                            children: const {
                              'F': Text('Femer'),
                              'M': Text('Mashkull'),
                            },
                            enabled: true,
                            initialValue: _fieldGjiniaController.text,
                            onChanged: (value) {
                              setState(() {
                                _fieldGjiniaController.text = value.toString();
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),

                        // burimi i informacionit
                        GestureDetector(
                          child: Stack(
                            children: [
                              CupertinoTextFormFieldRow(
                                controller: _fieldBurimiInformacionitController,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22.0,
                                  vertical: 8.0,
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: CupertinoColors.separator,
                                      width: 0.0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                prefix: const Icon(Icons.newspaper),
                                placeholder: 'Burimi i informacionit',
                                keyboardType: TextInputType.none,
                                textCapitalization: TextCapitalization.words,
                                autocorrect: false,
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => MyCupertinoActionSheet(
                                      controller: _fieldBurimiInformacionitController,
                                      options: _burimiInformacionitOptions,
                                      sheetTitle: 'Burimi i informacionit',
                                      sheetSubtitle:
                                          'Zgjidhni burimin e informacionit që ju ka informuar për shkeljen e vëzhguar',
                                    ),
                                  );
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Ju lutem zgjidhni burimin e informacionit';
                                  }
                                  return null;
                                },
                              ),
                              const Positioned(
                                top: 6,
                                right: 26,
                                child: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 26,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => MyCupertinoActionSheet(
                                controller: _fieldBurimiInformacionitController,
                                options: _burimiInformacionitOptions,
                                sheetTitle: 'Burimi i informacionit',
                                sheetSubtitle:
                                    'Zgjidhni burimin e informacionit që ju ka informuar për shkeljen e vëzhguar',
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // kryerësi i shkeljes field
                        GestureDetector(
                          child: Stack(
                            children: [
                              CupertinoTextFormFieldRow(
                                controller: _fieldkryeresiShkeljesController,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22.0,
                                  vertical: 8.0,
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: CupertinoColors.separator,
                                      width: 0.0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                prefix: const Icon(Icons.person_add_alt_1),
                                placeholder: 'Kryerësi i shkeljes',
                                keyboardType: TextInputType.none,
                                textCapitalization: TextCapitalization.words,
                                autocorrect: false,
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => MyCupertinoActionSheet(
                                      controller: _fieldkryeresiShkeljesController,
                                      options: _kryeresiShkeljesOptions,
                                      sheetTitle: 'Kryerësi i shkeljes',
                                      sheetSubtitle: 'Zgjidhni kryerësin e shkeljes',
                                    ),
                                  );
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Ju lutem zgjidhni kryerësin e shkeljes';
                                  }
                                  return null;
                                },
                              ),
                              const Positioned(
                                top: 6,
                                right: 26,
                                child: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 26,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => MyCupertinoActionSheet(
                                controller: _fieldBurimiInformacionitController,
                                options: _burimiInformacionitOptions,
                                sheetTitle: 'Burimi i informacionit',
                                sheetSubtitle:
                                    'Zgjidhni burimin e informacionit që ju ka informuar për shkeljen e vëzhguar',
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // Link field
                        CupertinoTextFormFieldRow(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22.0,
                            vertical: 8.0,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: CupertinoColors.separator,
                                width: 0.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          prefix: const Icon(CupertinoIcons.link),
                          placeholder: 'Linku i shkeljes (nëse ka)',
                          keyboardType: TextInputType.url,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          onChanged: (value) {
                            setState(() {
                              _fieldLinkController.text = value;
                            });
                          },
                          validator: (value) {
                            // accept empty values
                            if (value!.isEmpty) {
                              return null;
                            }

                            if (!value.startsWith('http')) {
                              return 'Ju lutem vendosni një link të saktë';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // Nr teli field
                        CupertinoTextFormFieldRow(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22.0,
                            vertical: 8.0,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: CupertinoColors.separator,
                                width: 0.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          prefix: const Icon(CupertinoIcons.phone),
                          placeholder: 'Nr juaj i telefonit',
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          onChanged: (value) {
                            setState(() {
                              _fieldNrTelController.text = value;
                            });
                          },
                        ),

                        // OutlinedButton with icon and text
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: OutlinedButton.icon(
                            onPressed: selectFile,
                            icon: const Icon(Icons.file_upload),
                            label: Text(
                              _pickedFile.path.isNotEmpty
                                  ? 'Modifiko provat foto/pdf/dokumente '
                                  : 'Bashkëngjit provat foto/pdf/dokumente',
                            ),
                          ),
                        ),
                        // Text not mandatory on grey background
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 6.0),
                          child: Text(
                            _pickedFile.path.isNotEmpty
                                ? "${_pickedFile.path.split('/').last} u bashkëngjit."
                                : '*Bashkëngjitja e provave nuk është e detyrueshme',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            left: 26.0,
                            right: 26.0,
                            bottom: 6.0,
                            top: 12.0,
                          ),
                          child: Text(
                            "Qendresa Qytetare mban përgjegjësi ligjore sipas ligjit për mbrojtjen e të dhënave personale në lidhje me mbledhjen e informacionit personal të denoncuesve dhe deklaron se ky informacion nuk do t'u shpërndahet palëve të treta.",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submitForm();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              side: MaterialStateProperty.all(
                                const BorderSide(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                              ),
                            ),
                            child: const Text('Dërgo raportimin'),
                          ),
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
