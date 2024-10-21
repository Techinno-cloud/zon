import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../fonction/fonctionCouleur.dart';
import '../inscription_bailleur/name_bailleur.dart';
import 'Inscr_Mode_envoi_codeBailleur/inscr_SMScode_bailleur.dart';
import 'Inscr_Mode_envoi_codeBailleur/inscr_Whatsappcode_bailleur.dart';

class InscriptionNumTelBailleur extends StatefulWidget {
  const InscriptionNumTelBailleur({super.key});

  @override
  State<InscriptionNumTelBailleur> createState() => _InscriptionNumTelBailleurState();
}

class _InscriptionNumTelBailleurState extends State<InscriptionNumTelBailleur> {
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
    _showModeEnvoiPopup();
  }

  void _showModeEnvoiPopup() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildModeEnvoiPopup(context);
      },
    );
  }

  Widget _buildModeEnvoiPopup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Choisissez l'option pour recevoir",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const Text("le code de vérification pour continuer l'inscription"),
          const SizedBox(height: 16),
          const Text("Sélectionner une méthode", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.sms),
            title: const Text("Continuer via SMS"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InscrSmscodeBailleur(),
                ),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/whatsapp.svg',
              width: 24,
              height: 24,
            ),
            title: const Text("Continuer via WhatsApp"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InscrWhatsappcodeBailleur(),
                ),
              );
            },
          ),
        ],
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: SvgPicture.asset(
                    'assets/images/Z.svg',
                    width: width * 0.75, // 75% de la largeur de l'écran
                    height: height * 0.35, // 35% de la hauteur de l'écran
                    color: Colors.white,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Entrez votre numéro de téléphone",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Veuillez entrer votre numéro de téléphone pour vous connecter ou pour créer un compte.",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          IntlPhoneField(
                            decoration: InputDecoration(
                              labelText: 'Numéro de téléphone',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.getBlueColor(),
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
                            initialCountryCode: 'TG',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                            onCountryChanged: (country) {
                              print('Country changed to: ${country.name}');
                            },
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
                                  duration: Duration(milliseconds: 100),
                                  transform: Matrix4.identity()..scale(_scale),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: AppColors.getBlueColor(),
                                    borderRadius: BorderRadius.circular(80),
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
            );
          },
        ),
      ),
    );
  }
}
