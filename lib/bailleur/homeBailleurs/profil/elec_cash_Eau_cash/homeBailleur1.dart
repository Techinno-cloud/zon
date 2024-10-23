import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:free_ges/bailleur/homeBailleurs/profil/elec_cash_Eau_cash/accueilBailleur1.dart';
import 'package:free_ges/bailleur/homeBailleurs/profil/elec_cash_Eau_cash/historiqueBailleur1.dart';
import 'package:free_ges/bailleur/homeBailleurs/profil/elec_cash_Eau_cash/locataireBailleur1.dart';
import 'package:free_ges/bailleur/homeBailleurs/profil/elec_cash_Eau_cash/messsageBailleur1.dart';
import '../../../../fonction/fonctionCouleur.dart';
import '../elec_cash_Eau_cash/factureBailleur1.dart';

class Homebailleur1 extends StatefulWidget {
  const Homebailleur1({super.key});

  @override
  State<Homebailleur1> createState() => _Homebailleur1State();
}

class _Homebailleur1State extends State<Homebailleur1> {
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
              topLeft: Radius.circular(200),
              topRight: Radius.circular(20),
            ),
          ),
          child: [
            Historiquebailleur1(),
            Facturebailleur1(),
            Accueibailleur1(),
            Locatairebailleur1(),
            Messsagebailleur1(),
          ][_selectedIndex],
        ),
      ),
      bottomNavigationBar: CircularBottomNavigation(
        [
          TabItem(Icons.history, "Historique", AppColors.getBlueColor(),),
          TabItem(Icons.receipt, "Facture", AppColors.getBlueColor()),
          TabItem(Icons.home, "Accueil", AppColors.getBlueColor()),
          TabItem(Icons.people, "Locataire", AppColors.getBlueColor()),
          TabItem(Icons.message, "Message", AppColors.getBlueColor()),
        ],
        controller: _navigationController,
        selectedCallback: _onItemTapped,
        barHeight: 40, // Ajuster la hauteur de la barre de navigation
        circleSize: 40, // Ajuster la taille des cercles
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
