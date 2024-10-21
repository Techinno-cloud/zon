import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../fonction/fonctionCouleur.dart';
import '../connection_bailleurs/mot_de_passe_oublierBailleur/Mode_envoi_codeBailleur/Whatsappcode_bailleur.dart';
import '../connection_bailleurs/numTel_bailleur.dart';
import 'Inscr_Mode_envoi_codeBailleur/inscr_SMScode_bailleur.dart';
import 'Inscr_Mode_envoi_codeBailleur/inscr_Whatsappcode_bailleur.dart';
import 'inscr_mot_de_passe_bailleur.dart';
import 'inscr_numTel_bailleur.dart'; // Importez la page cible

class NameBailleur extends StatefulWidget {
  const NameBailleur({super.key});

  @override
  State<NameBailleur> createState() => _NameBailleurState();
}

class _NameBailleurState extends State<NameBailleur> {
  final _formKey = GlobalKey<FormState>();
  final speakerNameController = TextEditingController();
  final confNameController = TextEditingController();
  String _gender = 'Male'; // Sexe par défaut
  bool _isPressed = false;
  double _scale = 1.0;

  @override
  void dispose() {
    speakerNameController.dispose();
    confNameController.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    setState(() {
      _isPressed = true;
      _scale = 0.95; // Réduction de l'échelle lors de l'appui
    });
  }

  void _onButtonReleased() {
    setState(() {
      _isPressed = false;
      _scale = 1.0; // Rétablissement de l'échelle
    });

    if (_formKey.currentState!.validate()) {
      final confName = confNameController.text;
      final speakerName = speakerNameController.text;

      FocusScope.of(context).unfocus(); // Cacher le clavier lorsqu'on appuie

      // Rediriger vers la page insc_numtelBailleur()
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InscriptionNumTelBailleur()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir les dimensions de l'écran
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: AppColors.getBlueColor(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Cacher le clavier en tapant à l'extérieur
        },
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05), // Padding en haut basé sur la hauteur de l'écran
                child: SvgPicture.asset(
                  'assets/images/Z.svg',
                  width: screenWidth * 0.75, // Largeur responsive
                  height: screenHeight * 0.3, // Hauteur responsive
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
                padding: EdgeInsets.all(screenWidth * 0.05), // Padding responsive
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Connectez-vous",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.075, // Taille de police responsive
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02), // Espacement responsive
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.02), // Marges responsives
                          child: Text(
                            "Merci d'indiquer le nom et le prénom du bailleur dans les champs ci-dessous.",
                            style: TextStyle(
                              fontSize: screenWidth * 0.05, // Taille de police responsive
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Nom du bailleur",
                              hintText: "Entrez le nom du bailleur",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.getBlueColor()), // Couleur de la bordure
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.getBlueColor()), // Couleur de la bordure lorsqu'il n'est pas focalisé
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.getBlueColor()), // Couleur de la bordure lorsqu'il est focalisé
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vous devez compléter le texte";
                              }
                              return null;
                            },
                            controller: confNameController,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Prénom du bailleur",
                              hintText: "Prénom du bailleur",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.getBlueColor()), // Couleur de la bordure
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.getBlueColor()), // Couleur de la bordure lorsqu'il n'est pas focalisé
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.getBlueColor()), // Couleur de la bordure lorsqu'il est focalisé
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vous devez compléter le texte";
                              }
                              return null;
                            },
                            controller: speakerNameController,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const Text(
                          "Sexe",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Masculin'),
                                value: 'Male',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!; // Mettre à jour le sexe sélectionné
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Féminin'),
                                value: 'Female',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!; // Mettre à jour le sexe sélectionné
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: SizedBox(
                            width: double.infinity,
                            child: GestureDetector(
                              onTapDown: (_) => _onButtonPressed(), // Appui sur le bouton
                              onTapUp: (_) => _onButtonReleased(), // Relâchement du bouton
                              onTapCancel: () => setState(() {
                                _isPressed = false;
                                _scale = 1.0; // Rétablir l'échelle en cas d'annulation
                              }),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                transform: Matrix4.identity()..scale(_scale), // Animation de l'échelle
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
            ),
          ],
        ),
      ),
    );
  }
}
