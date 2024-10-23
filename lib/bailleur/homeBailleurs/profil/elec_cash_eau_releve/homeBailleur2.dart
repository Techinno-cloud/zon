import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import '../../../../fonction/fonctionCouleur.dart';
import 'accueilBailleur2.dart';
import 'factureBailleur2.dart';
import 'historiqueBailleur2.dart';
import 'locataireBailleur2.dart';
import 'messsageBailleur2.dart';

class Homebailleur2 extends StatefulWidget {
  const Homebailleur2({super.key});

  @override
  State<Homebailleur2> createState() => _Homebailleur2State();
}

class _Homebailleur2State extends State<Homebailleur2> {
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
            Historiquebailleur2(),
            Facturebailleur2(),
            Accueibailleur2(),
            Locatairebailleur2(),
            Messsagebailleur2(),
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
