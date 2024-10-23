import 'package:flutter/material.dart';
class Notificationbailleur extends StatefulWidget {
  const Notificationbailleur({super.key});

  @override
  State<Notificationbailleur> createState() => _NotificationbailleurState();
}

class _NotificationbailleurState extends State<Notificationbailleur> {
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
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.005), // Marges adaptatives
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCard("Historique des factures", "Détails de l'historique", Icons.notifications),
                  SizedBox(height: screenSize.height * 0.002), // Espacement dynamique entre les cartes
                  _buildCard("Historique des reçus", "Détails de l'historique", Icons.notifications),
                  SizedBox(height: screenSize.height * 0.002),
                  _buildCard("Historique des retraits", "Détails de l'historique", Icons.notifications),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, IconData icon) {
    return Card(
      elevation: 4, // Élévation pour l'ombre
      child: ListTile(
        leading: Icon(icon, size: 40), // Icône de gauche
        title: Text(title, style: const TextStyle(fontSize: 18)), // Titre de la carte
        subtitle: Text(subtitle), // Sous-titre de la carte
        trailing: const Icon(Icons.more_vert), // Icône de droite
      ),
    );
  }
}
