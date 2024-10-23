import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../fonction/fonctionCouleur.dart';
import '../inscription_bailleur/name_bailleur.dart';
import 'mot_de_passeBailleur.dart';

class NumtelBailleur extends StatefulWidget {
  const NumtelBailleur({super.key});

  @override
  State<NumtelBailleur> createState() => _NumtelBailleurState();
}

class _NumtelBailleurState extends State<NumtelBailleur> {
  bool _isPressed = false;
  double _scale = 1.0;

  void _onButtonPressed() {
    HapticFeedback.lightImpact(); // Haptic feedback
    setState(() {
      _isPressed = true;
      _scale = 0.95;
    });
  }

  void _onButtonReleased() {
    setState(() {
      _isPressed = false;
      _scale = 1.0;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MotDePasseBailleur(), // Navigation vers la page suivante
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.getBlueColor(), // Utilisation de la couleur bleue définie
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Masquer le clavier lorsqu'on tape en dehors
        },
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                child: SvgPicture.asset(
                  'assets/images/Z.svg',
                  width: screenWidth * 0.75, // 75% de la largeur de l'écran
                  height: screenWidth * 0.75, // 75% de la largeur de l'écran
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF6F8FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Entrez votre numéro de téléphone",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.075, // 7.5% de la largeur de l'écran
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Veuillez entrer votre numéro de téléphone pour vous connecter ou pour créer un compte.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: screenWidth * 0.05, // 5% de la largeur de l'écran
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: 'Numéro de téléphone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.getBlueColor(), // Utilisation de la couleur bleue définie
                              width: 2.0,
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
                        ),
                        initialCountryCode: 'TG', // Code du Togo
                        onChanged: (phone) {
                          print(phone.completeNumber); // Affiche le numéro complet
                        },
                        onCountryChanged: (country) {
                          print('Country changed to: ${country.name}');
                        },
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NameBailleur(), // Navigation vers la page NameBailleur
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              "Première connexion ? Appuyez sur Inscription pour créer un compte.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Inscription',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.getBlueColor(),
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.getBlueColor(),
                                fontSize: screenWidth * 0.06, // 6% de la largeur de l'écran
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTapDown: (_) => _onButtonPressed(),
                            onTapUp: (_) => _onButtonReleased(),
                            onTapCancel: () {
                              setState(() {
                                _isPressed = false;
                                _scale = 1.0;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              transform: Matrix4.identity()..scale(_scale),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: AppColors.getBlueColor(),
                                borderRadius: BorderRadius.circular(80), // Bordure arrondie
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Suivant',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: "Lato-Black",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
