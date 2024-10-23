import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'fonctionCouleur.dart';

class FactureContratbailleur extends StatefulWidget {
  final double solde; // Montant à afficher

  const FactureContratbailleur({super.key, this.solde = 0}); // Constructeur avec solde par défaut

  @override
  _FactureContratbailleurState createState() => _FactureContratbailleurState();
}

class _FactureContratbailleurState extends State<FactureContratbailleur> {
  bool _isVisible = false; // État pour gérer la visibilité du montant

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20), // Espaces autour du conteneur
      child: Container(
        width: 350, // Largeur du conteneur
        height: 100, // Hauteur du conteneur
        decoration: BoxDecoration(
          color: Colors.white70, // Couleur de fond
          borderRadius: BorderRadius.circular(15), // Bordure arrondie
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Couleur de l'ombre
              spreadRadius: 2, // Expansion de l'ombre
              blurRadius: 10, // Flou de l'ombre
              offset: Offset(0, 4), // Décalage de l'ombre
            ),
          ],
        ),
        child: Stack(
          children: [
            Center( // Centrer les éléments à l'intérieur du conteneur
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFactureColumn(),
                  const SizedBox(width: 0),
                  _buildContratColumn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer la colonne des factures
  Widget _buildFactureColumn() {
    return _buildInfoColumn(
        "Facture",
        _buildInfoRow("Payées:", "03",  AppColors.getBlueColor()), // "03" en bleu
        _buildInfoRow("Impayées:", "01", Colors.red) // "01" en rouge
    );
  }

  // Fonction pour créer la colonne des contrats
  Widget _buildContratColumn() {
    return _buildInfoColumn(
        "Contrat",
        _buildInfoRow("Actifs:", "02",  AppColors.getBlueColor()), // "02" en bleu
        _buildInfoRow("Inactifs:", "07", Colors.red) // "07" en rouge
    );
  }

  // Méthode pour créer une colonne d'informations avec des lignes spécifiques
  Widget _buildInfoColumn(String title, Widget row1, Widget row2) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 8),
        row1,
        const SizedBox(height: 4),
        row2,
      ],
    );
  }

  // Méthode pour créer une ligne avec texte et valeur colorée
  Widget _buildInfoRow(String label, String value, Color valueColor) {
    return Row(
      children: [
        Text(label,
        style: TextStyle(
          fontSize: 14
        ),
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(color: valueColor), // Couleur dynamique pour la valeur
        ),
      ],
    );
  }
}
