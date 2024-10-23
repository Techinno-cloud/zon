import 'package:flutter/material.dart';
import 'fonctionCouleur.dart'; // Assurez-vous que le chemin d'importation est correct

class FonctionButtonbailleur extends StatelessWidget {
  const FonctionButtonbailleur({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Aligne les boutons avec un espace autour
        children: [
          _buildButton(Icons.exit_to_app, 'Retrait'),
          _buildButton(Icons.group, 'Ajouter'),
          _buildButton(Icons.house, 'Chambre'),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 2),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.getBlueColor(),
              ),
              // Vérifiez si l'icône est Icons.group pour ajouter l'icône "+"
              if (icon == Icons.group)
                Positioned(
                  left: 8, // Ajustez cette valeur pour la position horizontale
                  top: 0,  // Ajustez cette valeur pour la position verticale
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black, // Couleur de fond pour le +
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add, // Icône +
                      size: 16, // Taille de l'icône +
                      color: Colors.white, // Couleur de l'icône +
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
