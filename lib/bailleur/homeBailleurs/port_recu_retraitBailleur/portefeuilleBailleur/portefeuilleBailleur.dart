import 'package:flutter/material.dart';
import 'package:free_ges/bailleur/homeBailleurs/port_recu_retraitBailleur/portefeuilleBailleur/retrait/FloozBailleur/preconnectionFloozBailleur.dart';
import 'package:free_ges/bailleur/homeBailleurs/port_recu_retraitBailleur/portefeuilleBailleur/retrait/TmoneyBailleur/preconnectionTmoneyBailleur.dart';
import '../../../../fonction/fonctionCouleur.dart';

class PortefeuilleBailleur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtention des dimensions de l'écran
    final screenSize = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(20),
        right: Radius.circular(20),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Faites vos retraits via Tmoney ou Flooz',
            style: TextStyle(fontSize: 22),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05), // Marges adaptatives
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Option Tmoney
                  _PaymentOptionCard(
                    iconPath: 'assets/images/T.png',
                    label: 'Tmoney',
                    iconWidth: screenSize.width * 0.25,
                    iconHeight: screenSize.width * 0.2,
                    page: PreconnectionTmoneyBailleur(),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  // Option Flooz
                  _PaymentOptionCard(
                    iconPath: 'assets/images/Moov-Money.webp',
                    label: 'Moov-money',
                    iconWidth: screenSize.width * 0.25,
                    iconHeight: screenSize.width * 0.2,
                    page: Preconnectionfloozbailleur(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentOptionCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final double iconWidth;
  final double iconHeight;
  final Widget page;

  const _PaymentOptionCard({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.iconWidth,
    required this.iconHeight,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.0), // Espacement vertical
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icône du moyen de paiement
            Image.asset(iconPath, width: iconWidth, height: iconHeight),
            const SizedBox(width: 16),
            // Détails de l'option de paiement
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Bouton Retrait
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.getBlueColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
              child: const Text(
                "Retrait",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
