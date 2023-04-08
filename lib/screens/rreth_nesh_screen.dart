import 'package:flutter/material.dart';
import 'package:integriteti_zgjedhor_app/widgets/info_box.dart';

class RrethNeshScreen extends StatelessWidget {
  const RrethNeshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rreth nesh',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 100,
            width: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/misioni.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const InfoBox(
                title: 'Informacion rreth këtij projekti',
                subtitle:
                    '''Platforma integritetizgjedhor.al është një nismë e ndërmarrë nga Qëndresa Qytetare, në bashkëpunim me Komitetin Shqiptar të Helsinkit, Institutin e Studimeve Politike dhe Birn Albania, e mbështetur nga Ambasada Britanike në Tiranë.
      
Qëllimi i kësaj paltforme është të nxisë qytetarët shqiptarë të anagzhohen në parandalimin, evidentimin dhe ndëshkimin e parregullsive dhe shkeljeve të kodit zgjedhor nga subjektet zgjedhore dhe të rrisë shkallën e informimit dhe ndërgjegësimit të zyrtarëve publikë në raport me keqpërdorimin e burimeve shtetërore.''',
                secondaryTitle: 'Keni ndonjë pyetje/sugjerim për ne?',
                secondarySubtitle:
                    "Na kontaktoni nëpërmjet email për çdo pyetje/sugjerim që keni dhe ne do t'ju kthejmë përgjigje.",
                buttonText: 'Na kontaktoni nëpërmjet email',
                goToPath: 'email',
              ),
            ),
          )
        ]),
      ),
    );
  }
}
