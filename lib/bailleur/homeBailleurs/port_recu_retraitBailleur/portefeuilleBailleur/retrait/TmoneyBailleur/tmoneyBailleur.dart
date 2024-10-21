import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../fonction/fonctionCouleur.dart';
import '../../../../homeBailleur.dart';

class Tmoneybailleur extends StatefulWidget {
  const Tmoneybailleur({super.key});

  @override
  State<Tmoneybailleur> createState() => _TmoneybailleurState();
}

class _TmoneybailleurState extends State<Tmoneybailleur> {
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.getBlueColor(),
        title: Text("Tmoney", style: TextStyle(color: Colors.white, fontSize: 24)),
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
            HeaderSection(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Aligne les enfants sur toute la largeur
                children: [
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Montant de retrait',
                      prefixIcon: Icon(
                        Icons.money,
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
                      suffixText: 'XOF',
                      suffixStyle: TextStyle(
                        color: AppColors.getBlueColor(),
                        fontSize: 20,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
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
                      backgroundColor: AppColors.getBlueColor(),
                      padding: const EdgeInsets.symmetric(vertical: 12), // Ajuste la taille du bouton
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Retirer',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4, // Utilisation de la hauteur de l'écran
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 100, // Ajuste cette valeur pour positionner l'image
            right: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/images/retrait.svg',
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16, // Ajuste cette valeur pour positionner le texte
            child: Center(
              child: Text(
                'Saisissez le montant de votre retrait.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
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
