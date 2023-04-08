import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key, required this.label, required this.detailsPath});

  final String label;
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Administrimi i raportimeve',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 26.0,
                  vertical: 26.0,
                ),
                child: Text(
                  '''
  Raportimet e marra përmes kësaj forme administrohen nga ekspertet e organizates Qëndresa Qytetare, te cilet pasi shqyrtojne rastet, i përcjell ato tek organet kompetente.
              
  Ju po sinjalizoni për shkeljen e Kodit Zgjedhor si shit-blerja e votës, keqpërodrimi i burimeve shteterore dhe krimet zgjedhore.
              
  Keqpërdorimi i burimeve publike është një përdorim i paligjshëm i burimeve zyrtare nga administrata shtetërore ose lokale (njerëzore, materiale ose financiare) në mbështetje të një garuesi të caktuar zgjedhor. Krimi zgjedhor përfshin të gjitha format e shkeljes së kodit penal (seksioni i Krimeve zgjedhore), si shtiblerja e votes, ndikimi per te votuar etj.''',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Column(
                children: [
                  FilledButton(
                    onPressed: () => context.push('/report'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kAppBarBackground),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text('Vazhdo raportimin...'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.push('/home'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all(kAppBarBackground),
                    ),
                    child: const Text('Kthehu ne faqen kryesore'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
