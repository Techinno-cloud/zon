import 'package:flutter/material.dart';

class FonctionPubbailleur extends StatelessWidget {
  // Déclarez une instance de Game directement dans la classe
  final Game game = Game(
    'nom de la pub',
    "description",
    [
      'assets/images/ori2.jpg',
      'assets/images/ori3.jpg',
      'assets/images/ori4.jpg',
    ],
  );

   FonctionPubbailleur({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130, // Ajustez la hauteur si nécessaire
      padding: const EdgeInsets.symmetric(horizontal: 10), // Ajustez le padding
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => SizedBox(
          width: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              game.images[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: game.images.length,
      ),
    );
  }
}


class Game {
  String nom;
  String description;
  List<String> images;

  Game(
      this.nom,
      this.description,
      this.images,
      );
}
