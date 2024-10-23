import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_ges/locataire/locataires/connection_locataire/numTel_locataire.dart';
import 'bailleur/bailleurs/connection_bailleurs/numTel_bailleur.dart';
import 'fonction/fonctionCouleur.dart'; // Assurez-vous d'importer votre fichier AppColors

class PremierePage extends StatefulWidget {
  const PremierePage({super.key});

  @override
  State<PremierePage> createState() => _PremierePageState();
}

class _PremierePageState extends State<PremierePage> {
  bool _isPremierePage = false;
  bool _isPressedLocataire = false;
  double _scaleBailleur = 1.0;
  double _scaleLocataire = 1.0;

  void _onBailleurButtonPressedNumtelBailleur() {
    setState(() {
      _isPremierePage = true;
      _scaleBailleur = 0.95;
    });
  }

  void _onBailleurButtonReleasedNumtelBailleur() {
    setState(() {
      _isPremierePage = false;
      _scaleBailleur = 1.0;
    });
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const NumtelBailleur(),
      ),
    );
  }

  void _onBailleurButtonPressedNumtelLocataire() {
    setState(() {
      _isPremierePage = true;
      _scaleBailleur = 0.95;
    });
  }

  void _onBailleurButtonReleasedNumtelLocataire() {
    setState(() {
      _isPremierePage = false;
      _scaleBailleur = 1.0;
    });
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const NumtelLocataire(),
      ),
    );
  }

  void _onLocataireButtonPressed() {
    setState(() {
      _isPressedLocataire = true;
      _scaleLocataire = 0.95;
    });
  }

  void _onLocataireButtonReleased() {
    setState(() {
      _isPressedLocataire = false;
      _scaleLocataire = 1.0;
    });
    print('Locataire button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBlueColor(), // Utilisation de la couleur bleue définie
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: SvgPicture.asset(
                'assets/images/Z.svg',
                width: 300,
                height: 300,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Connectez-vous",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "En tant que bailleur pour gérer vos propriétés, ou en tant que locataire pour suivre votre location.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTapDown: (_) => _onBailleurButtonPressedNumtelBailleur(),
                        onTapUp: (_) => _onBailleurButtonReleasedNumtelBailleur(),
                        onTapCancel: () => setState(() {
                          _isPremierePage = false;
                          _scaleBailleur = 1.0;
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          transform: Matrix4.identity()..scale(_scaleBailleur),
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: AppColors.getBlueColor(), // Utilisation de la couleur bleue définie
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: const Text(
                            'Bailleur',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Lato-Black",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTapDown: (_) => _onBailleurButtonPressedNumtelLocataire(),
                        onTapUp: (_) => _onBailleurButtonReleasedNumtelLocataire(),
                        onTapCancel: () => setState(() {
                          _isPressedLocataire = false;
                          _scaleLocataire = 1.0;
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          transform: Matrix4.identity()..scale(_scaleLocataire),
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: AppColors.getBlueColor(), // Utilisation de la couleur bleue définie
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: const Text(
                            'Locataire',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Lato-Black",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
