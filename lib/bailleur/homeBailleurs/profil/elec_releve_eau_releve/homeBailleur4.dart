import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import '../../../../fonction/fonctionCouleur.dart';
import '../elec_cash_Eau_cash/factureBailleur1.dart';
import 'accueilBailleur4.dart';
import 'factureBailleur4.dart';
import 'historiqueBailleur4.dart';
import 'locataireBailleur4.dart';
import 'messsageBailleur4.dart';

class Homebailleur4 extends StatefulWidget {
  const Homebailleur4({super.key});

  @override
  State<Homebailleur4> createState() => _Homebailleur4State();
}

class _Homebailleur4State extends State<Homebailleur4> {
  int _selectedIndex = 2; // Index de l'onglet sélectionné
  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(_selectedIndex);
  }

  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int? index) {
    setState(() {
      _selectedIndex = index ?? 0;
      _navigationController.value = _selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBlueColor(), // Couleur d'arrière-plan
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF6F8FF), // Couleur de fond de la page
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: [
            Historiquebailleur4(),
            Facturebailleur4(),
            Accueibailleur4(),
            Locatairebailleur4(),
            Messsagebailleur4(),
          ][_selectedIndex],
        ),
      ),
      bottomNavigationBar: CircularBottomNavigation(
        [
          TabItem(Icons.history, "Historique", AppColors.getBlueColor()),
          TabItem(Icons.receipt, "Facture", AppColors.getBlueColor()),
          TabItem(Icons.home, "Accueil", AppColors.getBlueColor()),
          TabItem(Icons.people, "Locataire", AppColors.getBlueColor()),
          TabItem(Icons.message, "Message", AppColors.getBlueColor()),
        ],
        controller: _navigationController,
        selectedCallback: _onItemTapped,
        barHeight: 60,
        circleSize: 60,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
