import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../fonction/fonctionCouleur.dart';


class Historiquebailleur4 extends StatefulWidget {
  const Historiquebailleur4({super.key});

  @override
  State<Historiquebailleur4> createState() => _Historiquebailleur4State();
}

class _Historiquebailleur4State extends State<Historiquebailleur4> {
  @override
  Widget build(BuildContext context) {
    // Obtenir la largeur et la hauteur de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.getBlueColor(), // Couleur de l'AppBar en bleu
        title: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.01), // Déplacer le texte vers le bas
          child: const Text("Historique"), // Titre de l'AppBar
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.005), // Espacement horizontal
        child: ListView(
          children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Espacement vertical entre les cartes
              child: ListTile(
                leading: const Icon(Icons.history), // Icône de gauche
                title: const Text("Historique des factures"), // Titre de la carte
                subtitle: const Text("Détails de l'historique"), // Sous-titre de la carte
                trailing: const Icon(Icons.more_vert), // Icône de droite
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Espacement vertical entre les cartes
              child: ListTile(
                leading: const Icon(Icons.history), // Icône de gauche
                title: const Text("Historique des reçus"), // Titre de la carte
                subtitle: const Text("Détails de l'historique"), // Sous-titre de la carte
                trailing: const Icon(Icons.more_vert), // Icône de droite
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Espacement vertical entre les cartes
              child: ListTile(
                leading: const Icon(Icons.history), // Icône de gauche
                title: const Text("Historique des retraits"), // Titre de la carte
                subtitle: const Text("Détails de l'historique"), // Sous-titre de la carte
                trailing: const Icon(Icons.more_vert), // Icône de droite
              ),
            ),
          ],
        ),
      ),
    );
  }
}
