import 'package:flutter/material.dart';
import '../../../fonction/fonctionCouleur.dart';
import 'modifierProfilBailleur/modifierBailleur.dart';

class DrawerPage extends StatelessWidget {
  final VoidCallback onClose;

  const DrawerPage({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    final screenHeight = MediaQuery.of(context).size.height; // Hauteur de l'écran

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.getBlueColor(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Beaugard A.",
                        style: TextStyle(
                          fontSize: screenWidth * 0.06, // 6% de la largeur de l'écran
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'id = ey3hgtrg4e',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.05, // 5% de la largeur de l'écran
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifierBailleur()), // Remplacez par la page souhaitée
                    );
                  },
                  child: const Icon(
                    Icons.edit,
                    size: 24,
                    color: Color(0xBB5C0A25),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              _createDrawerItem(
                icon: Icons.language,
                text: 'Langues',
                onTap: onClose,
              ),
              _createDrawerItem(
                icon: Icons.notifications,
                text: 'Notifications/Alertes',
                onTap: onClose,
              ),
              _createDrawerItem(
                icon: Icons.lock_outline,
                text: 'Modifier le mot de passe',
                onTap: onClose,
              ),
              _createDrawerItem(
                icon: Icons.sim_card,
                text: 'Modifier le compte de retrait',
                onTap: onClose,
              ),
              _createDrawerItem(
                icon: Icons.logout,
                text: 'Déconnexion',
                onTap: onClose,
                iconColor: Colors.red,
              ),
              _createDrawerItem(
                icon: Icons.person_remove_alt_1_outlined,
                text: 'Supprimer le compte',
                onTap: onClose,
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.1), // Espace au bas
          Center(
            child: Text(
              'Politique de confidentialité',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.getBlueColor(),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.getBlueColor(),
                decorationThickness: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _createDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text),
      onTap: onTap,
    );
  }
}
