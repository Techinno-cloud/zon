import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_ges/locataire/home_locataires/homeLocataire.dart';
import 'package:free_ges/locataire/locataires/connection_locataire/mot_de_passe_oublierLocataire/Mode_envoi_codeLocataire/SMScode_locataire.dart';
import 'package:free_ges/locataire/locataires/inscripton_locataire/Inscr_mot_de_passe_locataire/insc_Whatsappcode_locataire.dart';

import '../../../fonction/fonctionCouleur.dart';



class MotDePasseLocataire extends StatefulWidget {
  const MotDePasseLocataire({super.key});

  @override
  State<MotDePasseLocataire> createState() => _MotDePasseLocataireState();
}

class _MotDePasseLocataireState extends State<MotDePasseLocataire> {
  final TextEditingController _controller = TextEditingController();
  bool _isPressed = false;
  double _scale = 1.0;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_formatText);
  }

  @override
  void dispose() {
    _controller.removeListener(_formatText);
    _controller.dispose();
    super.dispose();
  }

  void _formatText() {
    String text = _controller.text.replaceAll(' ', '');
    if (text.length > 6) {
      text = text.substring(0, 6);
    }
    if (text.length > 3) {
      text = text.replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]} ');
    }
    _controller.value = _controller.value.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeLocatair(),
      ),
    );
  }

  void _showForgotPasswordPopup() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildForgotPasswordPopup(context);
      },
    );
  }

  Widget _buildForgotPasswordPopup(BuildContext context) {
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
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Text("le code de vérification pour réinitialiser le mot de passe"),
          SizedBox(height: 16),
          Text("Sélectionner une méthode", style: TextStyle(fontSize: 16)),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(Icons.sms),
            title: Text("Continuer via SMS"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SMScodeLocataire(),
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
            title: Text("Continuer via Whatsapp"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InscrWhatsappcodeLocataire(),
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
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Saisissez votre mot de passe",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 400,
                        child: Text(
                          "Saisissez votre mot de passe afin de vous connecter à votre compte.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _controller,
                        obscureText: _obscureText,
                        cursorColor: AppColors.getBlueColor(),
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColors.getBlueColor(),),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColors.getBlueColor(),),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColors.getBlueColor(), width: 2.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _showForgotPasswordPopup,
                        child: const Text(
                          "j'ai oublié mon mot de passe",
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
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
