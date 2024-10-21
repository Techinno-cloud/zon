import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:free_ges/bailleur/homeBailleurs/factureBailleur.dart';
import '../../fonction/fonctionCouleur.dart';
import 'accueilBailleur.dart';
import 'historiqueBailleur.dart';
import 'locataireBailleur.dart';
import 'messsageBailleur.dart';

class Homebailleur extends StatefulWidget {
  const Homebailleur({super.key});

  @override
  State<Homebailleur> createState() => _HomebailleurState();
}

class _HomebailleurState extends State<Homebailleur> {
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
            Historiquebailleur(),
            Facturebailleur(),
            Accueibailleur(),
            Locatairebailleur(),
            Messsagebailleur(),
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
