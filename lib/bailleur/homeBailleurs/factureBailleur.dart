import 'package:flutter/material.dart';

import '../../fonction/fonctionCouleur.dart';

class Facturebailleur extends StatefulWidget {
  const Facturebailleur({super.key});

  @override
  State<Facturebailleur> createState() => _FacturebailleurState();
}

class _FacturebailleurState extends State<Facturebailleur> {
  @override
  Widget build(BuildContext context) {
    // Obtenir la largeur et la hauteur de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.getBlueColor(), // Couleur de l'AppBar en bleu
        title: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.01), // Déplacer les textes vers le bas
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Scroll horizontal
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pour aligner "Historique" et "Générer une nouvelle"
              children: [
                TextButton.icon(
                  onPressed: () {
                    // Action pour le bouton "Générer une nouvelle"
                  },
                  label: Text(
                    'Générer une nouvelle',
                    style: TextStyle(
                      color: Colors.white, // Texte en blanc
                      fontSize: screenWidth * 0.05, // Taille du texte proportionnelle à la largeur de l'écran
                    ),
                  ),
                  icon: const Icon(
                    Icons.add, // Icône de plus
                    color: Colors.white,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    alignment: Alignment.centerLeft, // Alignement du texte et icône
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center( // Centre le contenu dans le corps de l'écran
        child: Container(
          width: screenWidth * 0.9, // Largeur de 90% de l'écran
          height: screenHeight * 0.7, // Hauteur de 70% de l'écran
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Bordure grise
            borderRadius: BorderRadius.circular(12), // Coins arrondis
          ),
          child: const Placeholder(), // Placeholder pour le contenu
        ),
      ),
    );
  }
}
