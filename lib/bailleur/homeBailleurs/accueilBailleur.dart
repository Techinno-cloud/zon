import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_ges/bailleur/homeBailleurs/port_recu_retraitBailleur/notificationBailleur/NotificationBailleur.dart';
import 'package:free_ges/bailleur/homeBailleurs/port_recu_retraitBailleur/portefeuilleBailleur/portefeuilleBailleur.dart';
import 'package:free_ges/bailleur/homeBailleurs/port_recu_retraitBailleur/recuBailleur/recuBailleur.dart';
import 'package:free_ges/bailleur/homeBailleurs/profileBailleur/compteBailleur.dart';
import '../../fonction/fonctionCouleur.dart';

class Accueibailleur extends StatefulWidget {
  const Accueibailleur({super.key});

  @override
  State<Accueibailleur> createState() => _AccueibailleurState();
}

class _AccueibailleurState extends State<Accueibailleur> {
  int _selectedIconIndex = 0; // Suivi de l'icône sélectionnée
  bool _isDrawerOpen = false; // Suivi de l'état du Drawer

  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 10),
              _buildInfoCard(screenSize), // Passer la taille de l'écran
              const SizedBox(height: 20),
              _buildIconRow(),
              const SizedBox(height: 20),
              Expanded(child: _buildSelectedPage()), // Utiliser Expanded
            ],
          ),
          if (_isDrawerOpen) _buildDrawer(), // Afficher le Drawer si ouvert
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 77,
          decoration: BoxDecoration(
            color: AppColors.getBlueColor(),
          ),
          child: Column(
            children: [
              const SizedBox(height: 14),
              Row(
                children: [
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDrawerOpen = true; // Ouvrir le Drawer
                      });
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Beaugard A.",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 43,
          right: 16,
          child: Text(
            "10 400 XOF",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(Size screenSize) {
    return Container(
      height: screenSize.height * 0.2, // Utiliser un pourcentage de la hauteur de l'écran
      width: screenSize.width * 0.9, // Utiliser un pourcentage de la largeur de l'écran
      margin: const EdgeInsets.symmetric(horizontal: 16), // Marge horizontale
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: -5,
            blurRadius: 10,
            offset: const Offset(-4, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: SvgPicture.asset(
                  'assets/images/Z.svg',
                  fit: BoxFit.cover,
                  color: const Color(0xFFF0F0F5FF),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoColumn("Facture", "Payees: 03", "Impayees: 01"),
              const SizedBox(width: 70),
              _buildInfoColumn("Contrat", "Actifs: 02", "Inactifs: 07"),
            ],
          ),
        ],
      ),
    );
  }

  static Column _buildInfoColumn(String title, String subtitle1, String subtitle2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle1,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle2,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIconButton(Icons.account_balance_wallet, "Portefeuille", 0),
        _buildIconButton(Icons.receipt_long, "Reçu", 1),
        _buildIconButton(Icons.notifications, "Notification", 2),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, String label, int index) {
    final isSelected = _selectedIconIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIconIndex = index; // Mettre à jour l'index sélectionné
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[100] : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isSelected
                  ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
                  : [],
              border: Border.all(
                color: AppColors.getBlueColor(),
                width: 2,
              ),
            ),
            child: Icon(icon, size: 40, color: AppColors.getBlueColor()),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedPage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: _getSelectedPage(), // Afficher la page sélectionnée
    );
  }

  Widget _getSelectedPage() {
    switch (_selectedIconIndex) {
      case 0:
        return PortefeuilleBailleur(); // Afficher le portefeuille
      case 1:
        return const RecuBailleur(); // Afficher le reçu
      case 2:
        return const Notificationbailleur(); // Afficher les notifications
      default:
        return Container(); // Valeur par défaut
    }
  }

  Widget _buildDrawer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isDrawerOpen = false; // Fermer le Drawer
        });
      },
      child: Container(
        color: Colors.black.withOpacity(0.5), // Fond semi-transparent
        child: Align(
          alignment: Alignment.centerLeft,
          child: DrawerPage(
            onClose: () {
              setState(() {
                _isDrawerOpen = false; // Fermer le Drawer
              });
            },
          ),
        ),
      ),
    );
  }
}
