import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'fonctionCouleur.dart'; // Import du package SVG

class Cartemoney extends StatefulWidget {
  final double solde; // Montant à afficher

  const Cartemoney({super.key, this.solde = 0}); // Constructeur avec solde par défaut

  @override
  _CartemoneyState createState() => _CartemoneyState();
}

class _CartemoneyState extends State<Cartemoney> {
  bool _isVisible = false; // État pour gérer la visibilité du montant

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8), // Espaces
      child: Container(
        height: 180, // Hauteur du container
        width: double.infinity, // Largeur maximale
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/carte.jpg"), // Remplacez par le chemin de votre image
            fit: BoxFit.cover, // Ajuste l'image pour couvrir tout le container
          ),
          border: Border.all(color: Colors.blue, width: 2), // Bordure sympa
          borderRadius: BorderRadius.circular(15), // Coins arrondis
        ),
        child: Column( // Ajoutez un Column pour empiler le contenu
          crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
          children: [
            Align(
              alignment: Alignment.topRight, // Position initiale en haut à droite
              child: Container(
                margin: const EdgeInsets.only(right: 24), // Pousse l'image vers la gauche
                child: SvgPicture.asset(
                  'assets/images/Z.svg',
                  color: Colors.white,
                  width: 200, // Largeur de l'image
                  height: 50, // Hauteur de l'image
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14), // Pousse le texte vers la droite de 10 pixels
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
                children: [
                  // Espace entre l'image et le texte
                  const Text(
                    'Solde disponible', // Montant affiché
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5), // Espace entre le montant et le texte masqué
                  Text(
                    _isVisible ? '${widget.solde} FCFA' : '**** ****', // Montant ou masqué
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight, // Alignement en bas à droite
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14), // Padding autour du Row
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pour espacer les éléments
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10), // Padding pour le texte
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
                        children: [
                          const Text(
                            'DERNIERE ACTUALISATION', // Texte à afficher
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Oxanium', // Ajoutez la police ici
                            ),
                          ),
                          Text(
                            "12/13/43  23:21:08",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              fontFamily: 'Oxanium', // Ajoutez la police ici
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isVisible ? Icons.visibility_off : Icons.visibility, // Icône selon l'état
                        color: Colors.white,
                      ),
                      iconSize: 20.0,
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible; // Inverser l'état de visibilité
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
