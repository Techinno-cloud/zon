import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../fonction/facture_contratBailleur.dart';
import '../../../../fonction/fonctionCouleur.dart';
import '../../../../fonction/fonction_buttonBailleur.dart';
import '../../../../fonction/fonction_carteBailleur.dart';
import '../../../../fonction/fonction_pubBailleur.dart';

class Accueibailleur1 extends StatefulWidget {
  const Accueibailleur1({super.key});

  @override
  State<Accueibailleur1> createState() => _Accueibailleur1State();
}

class _Accueibailleur1State extends State<Accueibailleur1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.getBlueColor(),
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bienvenue", style: TextStyle(fontSize: 10)),
                Text("AMEDOME k.", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Action à exécuter lorsque l'icône de notification est pressée
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 10), // Optionnel : espace en haut
          Center(child: Cartemoney()),
          SizedBox(height: 17), // Espace entre les widgets
          Center(child: FonctionButtonbailleur()),
          SizedBox(height: 04), // Espace entre les widgets
          Center(child: FactureContratbailleur()),
          SizedBox(height: 04), // Espace entre les widgets
          Center(child: FonctionPubbailleur()),
        ],
      ),
    );
  }
}

