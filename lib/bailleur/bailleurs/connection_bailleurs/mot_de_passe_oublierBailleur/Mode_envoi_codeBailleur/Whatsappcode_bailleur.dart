import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

import '../../../../../fonction/fonctionCouleur.dart';
import '../newMot_de_passe_bailleur.dart';

class WhatsappcodeBailleur extends StatefulWidget {
  const WhatsappcodeBailleur({super.key});

  @override
  State<WhatsappcodeBailleur> createState() => _WhatsappcodeBailleurState();
}

class _WhatsappcodeBailleurState extends State<WhatsappcodeBailleur> {
  final _pinController = TextEditingController();
  bool _isPressed = false;
  double _scale = 1.0;

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

    // Navigate to NewmotDePasseBailleur page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewmotDePasseBailleur(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Getting screen size
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

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
                padding: EdgeInsets.only(top: screenSize.height * 0.05),
                child: SvgPicture.asset(
                  'assets/images/Z.svg',
                  width: screenSize.width * 0.6,
                  height: screenSize.height * 0.3,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Réinitialisation du code via Whatsapp",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 24 : 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: screenSize.width * 0.85,
                        child: const Text(
                          "Entrez le code de vérification de six chiffres que vous avez reçu par Whatsapp pour compléter la vérification de votre numéro de téléphone.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          if (value.length == 6) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                        defaultPinTheme: PinTheme(
                          width: screenSize.width * 0.13,
                          height: screenSize.height * 0.07,
                          textStyle: TextStyle(fontSize: 22, color: Colors.black),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: screenSize.width * 0.13,
                          height: screenSize.height * 0.07,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.getBlueColor()),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
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
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: AppColors.getBlueColor(),
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Envoyer',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: "Lato-Black",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
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
