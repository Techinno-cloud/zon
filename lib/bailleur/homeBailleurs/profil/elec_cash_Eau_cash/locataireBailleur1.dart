import 'package:flutter/material.dart';

import '../../../../fonction/fonctionCouleur.dart';


class Locatairebailleur1 extends StatefulWidget {
  const Locatairebailleur1({super.key});

  @override
  State<Locatairebailleur1> createState() => _Locatairebailleur1State();
}

class _Locatairebailleur1State extends State<Locatairebailleur1> {
  bool isElectricityManaged = false;
  bool isWaterManaged = false;
  double electricityPrice = 0.0;
  double waterPrice = 0.0;

  // Liste pour stocker les types de chambres et leurs prix
  List<Map<String, dynamic>> roomList = [];
  Map<String, double> roomPrices = {};

  // Liste des types de chambres disponibles
  final List<String> availableRoomTypes = ['Pièce', 'Chambre salon', 'Deux chambres salon'];
  // Liste pour stocker les types de chambres sélectionnés
  List<String> selectedRoomTypes = [];
  // Dictionnaire pour stocker les prix des chambres
  Map<String, double> currentRoomPrices = {};

  @override
  Widget build(BuildContext context) {
    // Obtenir la largeur et la hauteur de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des locataires"),
        backgroundColor: AppColors.getBlueColor(),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: const Text("Informations sur la maison"),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Section électricité
                              CheckboxListTile(
                                title: const Text("Gestion des factures d'électricité"),
                                value: isElectricityManaged,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isElectricityManaged = value ?? false;
                                  });
                                },
                              ),
                              if (isElectricityManaged)
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      labelText: 'Prix par impulsion (en FCFA)',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      electricityPrice = double.tryParse(value) ?? 0.0;
                                    },
                                  ),
                                ),
                              // Section eau
                              CheckboxListTile(
                                title: const Text("Gestion des factures d'eau"),
                                value: isWaterManaged,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isWaterManaged = value ?? false;
                                  });
                                },
                              ),
                              if (isWaterManaged)
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      labelText: 'Prix par mètre cube ou prix fixe (en FCFA)',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      waterPrice = double.tryParse(value) ?? 0.0;
                                    },
                                  ),
                                ),
                              // Section types de chambres
                              const Text("Types de chambres :"),
                              ...availableRoomTypes.map((type) {
                                return CheckboxListTile(
                                  title: Text(type),
                                  value: selectedRoomTypes.contains(type),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value ?? false) {
                                        selectedRoomTypes.add(type);
                                        currentRoomPrices[type] = 0.0; // Initialiser le prix
                                      } else {
                                        selectedRoomTypes.remove(type);
                                        currentRoomPrices.remove(type);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                              ...selectedRoomTypes.map((type) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Prix pour $type (en FCFA)',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        currentRoomPrices[type] = double.tryParse(value) ?? 0.0;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text("Annuler"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text("Enregistrer"),
                            onPressed: () {
                              setState(() {
                                if (selectedRoomTypes.isNotEmpty) {
                                  roomList.add({
                                    'electricityPrice': electricityPrice,
                                    'waterPrice': waterPrice,
                                    'rooms': {
                                      'types': selectedRoomTypes,
                                      'prices': currentRoomPrices,
                                    },
                                  });
                                }
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Ajout de padding pour l'adaptabilité
        child: ListView(
          children: roomList.map((entry) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Espacement vertical entre les cartes
              child: ListTile(
                title: Text("Maison avec : ${entry['rooms']['types'].join(', ')}"),
                subtitle: Text(
                  "Électricité : ${entry['electricityPrice']} FCFA/impulsion\n"
                  "Eau : ${entry['waterPrice']} FCFA/mètre cube\n"
                  "Prix des chambres : ${entry['rooms']['prices'].entries.map((e) => '${e.key}: ${e.value} FCFA').join(', ')}",
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
