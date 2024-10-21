import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:free_ges/bailleur/homeBailleurs/factureBailleur.dart';
import 'package:free_ges/locataire/home_locataires/accueillLocataire.dart';
import 'package:free_ges/locataire/home_locataires/factureLocataire.dart';
import 'package:free_ges/locataire/home_locataires/messageLocataire.dart';
import 'package:free_ges/locataire/home_locataires/payeLocataire.dart';

import '../../fonction/fonctionCouleur.dart';

class HomeLocatair extends StatefulWidget {
  const HomeLocatair({super.key});

  @override
  State<HomeLocatair> createState() => _HomeLocatairState();
}

class _HomeLocatairState extends State<HomeLocatair> {
  int _selectedIndex = 2;
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
      body: [
        Accueilllocataire(),
        FactureLocataire(),
        Payelocataire(),
        Messsagelocataire(),
      ][_selectedIndex],
      bottomNavigationBar: CircularBottomNavigation(
        [
          TabItem(Icons.home, "Accueil", AppColors.getBlueColor()),
          TabItem(Icons.receipt, "Facture", AppColors.getBlueColor()),
          TabItem(Icons.money, "Paie", AppColors.getBlueColor()),
          TabItem(Icons.message, "Message", AppColors.getBlueColor(),),
        ],
        controller: _navigationController,
        selectedCallback: _onItemTapped,
        barHeight: 60,
        circleSize: 60,
        animationDuration: Duration(milliseconds: 300),

      ),
    );
  }
}
