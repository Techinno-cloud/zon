import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

import '../../../../fonction/fonctionCouleur.dart';
import '../inscr_mot_de_passe_bailleur.dart';

class InscrWhatsappcodeBailleur extends StatefulWidget {
  const InscrWhatsappcodeBailleur({super.key});

  @override
  State<InscrWhatsappcodeBailleur> createState() => _InscrWhatsappcodeBailleurState();
}

class _InscrWhatsappcodeBailleurState extends State<InscrWhatsappcodeBailleur> {
  final TextEditingController _pinController = TextEditingController();

  bool _isPressed = false;
  double _scale = 1.0;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

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
        builder: (context) => const InscrMotDePasseBilleur(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                padding: EdgeInsets.only(top: screenHeight * 0.05), // Top padding
                child: SvgPicture.asset(
                  'assets/images/Z.svg',
                  width: screenWidth * 0.75, // Adjusted width
                  height: screenWidth * 0.75, // Adjusted height
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
                        "Code de verification via Whatsapp",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.08, // Responsive font size
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: screenWidth * 0.9, // Responsive width
                        child: Text(
                          "Entrez le code de vérification de six chiffres que vous avez reçu par Whatsapp pour compléter la vérification de votre numéro de téléphone.",
                          style: TextStyle(
                            fontSize: screenWidth * 0.05, // Responsive font size
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6,  // The length of the code
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          if (value.length == 6) {
                            FocusScope.of(context).unfocus(); // Dismiss the keyboard
                          }
                        },
                        onCompleted: (pin) {
                          // Handle the completed pin code here
                        },
                        defaultPinTheme: PinTheme(
                          width: screenWidth * 0.14, // Responsive width
                          height: screenWidth * 0.14, // Responsive height
                          textStyle: TextStyle(fontSize: screenWidth * 0.06, color: Colors.black),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: screenWidth * 0.14, // Responsive width
                          height: screenWidth * 0.14, // Responsive height
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
                                children: [
                                  Text(
                                    'Envoyer',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.06, // Responsive font size
                                      fontFamily: "Lato-Black",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
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
