import 'package:flutter/material.dart';
import '../../../../fonction/fonctionCouleur.dart';
import '../compteBailleur.dart'; // Assurez-vous que ce chemin est correct

class ModifierBailleur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Désactiver la bannière de débogage
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.getBlueColor(),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DrawerPage(onClose: () {})),
              );
            },
          ),

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05), // Espacement dynamique
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(
                                    Icons.person,
                                    size: 110,
                                    color: Colors.grey,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    child: Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05), // Espacement dynamique
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 80),
                          Text(
                            'Kevin AMEDOME',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Enregistré le 17 déc. 2022',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Informations utilisateur
                ProfileInfoItem(
                  icon: Icons.flag,
                  label: 'Pays',
                  value: 'Togo',
                  isErrorIcon: true,
                ),
                SizedBox(height: 10),

                ProfileInfoItem(
                  icon: Icons.person,
                  label: 'Prénom*',
                  value: 'Kevin',
                ),
                SizedBox(height: 10),
                ProfileInfoItem(
                  icon: Icons.person,
                  label: 'Nom de famille',
                  value: 'AMEDOME',
                ),
                SizedBox(height: 10),
                ProfileInfoItem(
                  icon: Icons.email,
                  label: 'Email',
                  value: 'amedomekevin4@gmail.com',
                ),
                SizedBox(height: 10),
                ProfileInfoItem(
                  icon: Icons.male,
                  label: 'Sexe',
                  value: 'Homme',
                ),

                SizedBox(height: 60),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Enregistrer les modifications',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isErrorIcon;

  ProfileInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.isErrorIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          if (isErrorIcon)
            IconButton(
              icon: Icon(Icons.error, color: Colors.red),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          '+228 93658651',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Enregistré le 17 déc. 2022',
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Vous pouvez modifier votre numéro de téléphone en utilisant le bouton d\'édition.',
                          style: TextStyle(color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
