import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import '../../../../fonction/fonctionCouleur.dart';
import '../inscr_mot_de_passe_bailleur.dart';

class InscrSmscodeBailleur extends StatefulWidget {
  const InscrSmscodeBailleur({super.key});

  @override
  State<InscrSmscodeBailleur> createState() => _InscrSmscodeBailleurState();
}

class _InscrSmscodeBailleurState extends State<InscrSmscodeBailleur> {
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
    // Navigate to InscrMotDePasseBilleur
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InscrMotDePasseBilleur(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(top: 20),
                child: SvgPicture.asset(
                  'assets/images/Z.svg',
                  width: MediaQuery.of(context).size.width * 0.75, // Responsive width
                  height: MediaQuery.of(context).size.height * 0.3, // Responsive height
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
                      const Text(
                        "Code de verification via SMS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(
                        width: 400,
                        child: Text(
                          "Entrez le code de vérification de six chiffres que vous avez reçu par SMS pour compléter la vérification de votre numéro de téléphone.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6, // 6 digits for the SMS code
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
                          width: MediaQuery.of(context).size.width * 0.14, // Responsive width
                          height: MediaQuery.of(context).size.height * 0.07, // Responsive height
                          textStyle: const TextStyle(fontSize: 22, color: Colors.black),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: MediaQuery.of(context).size.width * 0.14, // Responsive width
                          height: MediaQuery.of(context).size.height * 0.07, // Responsive height
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
