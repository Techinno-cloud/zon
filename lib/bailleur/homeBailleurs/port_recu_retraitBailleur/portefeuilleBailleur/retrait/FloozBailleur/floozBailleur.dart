import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Ajouté pour les inputFormatters
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../fonction/fonctionCouleur.dart';
import '../../../../homeBailleur.dart'; // Import pour la gestion des couleurs

class Floozbailleur extends StatefulWidget {
  const Floozbailleur({super.key});

  @override
  State<Floozbailleur> createState() => _FloozbailleurState();
}

class _FloozbailleurState extends State<Floozbailleur> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.getBlueColor(),
        title: Text("Moov-money", style: TextStyle(color: Colors.white, fontSize: 24)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homebailleur()),
            ); // Retourne à la page Homebailleur
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(screenWidth: screenWidth),
            const SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Padding dynamique
              child: TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Montant de retrait',
                  prefixIcon: Icon(
                    Icons.money, // Icône de la devise
                    color: AppColors.getBlueColor(),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.getBlueColor(),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppColors.getBlueColor(),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppColors.getBlueColor(),
                      width: 2.0,
                    ),
                  ),
                  suffixText: 'XOF', // Texte de la devise
                  suffixStyle: TextStyle(
                    color: AppColors.getBlueColor(),
                    fontSize: 20,
                  ),
                ),
                keyboardType: TextInputType.number, // Clavier numérique
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Autorise uniquement les chiffres
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Action à effectuer lors du retrait
                String phoneNumber = _phoneController.text;
                String amount = _amountController.text;
                print('Retirer $amount au numéro: $phoneNumber');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.getBlueColor(), // Définit la couleur de fond du bouton
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 12), // Ajuste la taille du bouton
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Ajoute des coins arrondis
                ),
              ),
              child: Text(
                'Retirer',
                style: TextStyle(
                  fontSize: 20, // Taille de police dynamique
                  color: Colors.white, // Assure que le texte reste lisible avec un fond bleu
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final double screenWidth;

  const HeaderSection({Key? key, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          // Positionne l'image SVG à une certaine distance du haut pour qu'elle soit plus bas
          Positioned(
            top: 140,
            right: 8, // Ajustez cette valeur pour déplacer l'image plus bas
            child: SvgPicture.asset(
              'assets/images/retrait.svg',
              fit: BoxFit.cover,
              width: screenWidth, // Assure que l'image prend toute la largeur
              height: 200, // Hauteur de l'image
            ),
          ),
          // Positionne un texte en bas à gauche du conteneur
          Positioned(
            left: 0, // Assure que le texte commence à partir du bord gauche
            right: 0, // Assure que le texte s'étend jusqu'au bord droit
            bottom: 0, // Ajuste cette valeur pour déplacer le texte vers le bas
            child: Center(
              child: Text(
                'Saisissez le montant de votre retrait.', // Ajoutez un texte ici si nécessaire
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
