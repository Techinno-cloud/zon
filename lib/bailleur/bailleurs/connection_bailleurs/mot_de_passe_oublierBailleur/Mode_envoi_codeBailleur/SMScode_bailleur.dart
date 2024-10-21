import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import '../../../../../fonction/fonctionCouleur.dart';
import '../newMot_de_passe_bailleur.dart';

class SMScodeBailleur extends StatefulWidget {
  const SMScodeBailleur({super.key});

  @override
  State<SMScodeBailleur> createState() => _SMScodeBailleurState();
}

class _SMScodeBailleurState extends State<SMScodeBailleur> {
  bool _isPressed = false;
  double _scale = 1.0;
  final _pinController = TextEditingController();

  void _onButtonPressed() {
    HapticFeedback.lightImpact();
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

    // Navigate to the next page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewmotDePasseBailleur(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Récupération des dimensions de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.getBlueColor(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02), // Proportionnel au height
                child: SvgPicture.asset(
                  'assets/images/Z.svg',
                  width: screenWidth * 0.7, // 70% de la largeur de l'écran
                  height: screenHeight * 0.3, // 30% de la hauteur de l'écran
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
                padding: EdgeInsets.all(screenWidth * 0.04), // Padding basé sur la largeur
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Reinisialisation du code via SMS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.08, // Taille du texte proportionnelle
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: Text(
                          "Entrez le code de vérification de six chiffres que vous avez reçu par SMS pour compléter la vérification de votre numéro de téléphone.",
                          style: TextStyle(
                            fontSize: screenWidth * 0.05, // Taille du texte proportionnelle
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02), // Espacement proportionnel
                      Pinput(
                        length: 6,
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          if (value.length == 6) {
                            FocusScope.of(context).unfocus(); // Dismiss the keyboard
                          }
                        },
                        defaultPinTheme: PinTheme(
                          width: screenWidth * 0.13, // Proportionnel à l'écran
                          height: screenHeight * 0.08,
                          textStyle: TextStyle(fontSize: screenWidth * 0.05, color: Colors.black),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: screenWidth * 0.13,
                          height: screenHeight * 0.08,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.getBlueColor()),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTapDown: (_) => _onButtonPressed(),
                            onTapUp: (_) => _onButtonReleased(),
                            onTapCancel: () => setState(() {
                              _isPressed = false;
                              _scale = 1.0;
                            }),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              transform: Matrix4.identity()..scale(_scale),
                              padding: EdgeInsets.all(screenWidth * 0.04),
                              decoration: BoxDecoration(
                                color: AppColors.getBlueColor(),
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Envoyer',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.06,
                                      fontFamily: "Lato-Black",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
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
