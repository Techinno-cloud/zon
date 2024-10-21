import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Assure-toi d'ajouter intl dans pubspec.yaml
import 'package:url_launcher/url_launcher.dart'; // Assure-toi d'ajouter url_launcher dans pubspec.yaml

class FactureLocataire extends StatefulWidget {
  const FactureLocataire({super.key});

  @override
  State<FactureLocataire> createState() => _FactureLocataireState();
}

class _FactureLocataireState extends State<FactureLocataire> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _moisController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();
  String montantEnLettres = "";
  List<Map<String, dynamic>> _factures = [];
  bool _isExpanded = false;

  void _genererFacture() {
    String nom = _nomController.text;
    String prenom = _prenomController.text;
    String mois = _moisController.text;
    double? montant = double.tryParse(_montantController.text);

    if (nom.isNotEmpty && prenom.isNotEmpty && mois.isNotEmpty && montant != null) {
      setState(() {
        montantEnLettres = _convertirMontantEnLettres(montant);
        _factures.add({
          'nom': nom,
          'prenom': prenom,
          'mois': mois,
          'montant': montant,
          'montantEnLettres': montantEnLettres
        });

        // Réinitialiser les contrôleurs de texte
        _nomController.clear();
        _prenomController.clear();
        _moisController.clear();
        _montantController.clear();
      });

      // Afficher un dialogue avec un aperçu de la facture
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Facture Générée"),
            content: Text(
              "Nom: $nom\n"
                  "Prénom: $prenom\n"
                  "Mois: $mois\n"
                  "Montant: ${NumberFormat.currency(locale: 'fr', symbol: '€').format(montant)}\n"
                  "Montant en lettres: $montantEnLettres",
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Envoyer par WhatsApp"),
                onPressed: () {
                  _envoyerParWhatsApp(nom, prenom, mois, montant);
                },
              ),
              TextButton(
                child: Text("Fermer"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _envoyerParWhatsApp(String nom, String prenom, String mois, double montant) async {
    final String message = "Facture:\n\n"
        "Nom: $nom\n"
        "Prénom: $prenom\n"
        "Mois: $mois\n"
        "Montant: ${NumberFormat.currency(locale: 'fr', symbol: '€').format(montant)}\n"
        "Montant en lettres: $montantEnLettres";

    final url = "https://wa.me/?text=${Uri.encodeComponent(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir WhatsApp.';
    }
  }

  // Fonction pour convertir un montant en lettres (basique)
  String _convertirMontantEnLettres(double montant) {
    // On ne gère que les montants jusqu'à 16 pour l'exemple
    final units = [
      '', 'un', 'deux', 'trois', 'quatre', 'cinq', 'six', 'sept', 'huit', 'neuf', 'dix', 'onze', 'douze', 'treize', 'quatorze', 'quinze', 'seize'
    ];
    if (montant < 17) return units[montant.toInt()];
    // Conversion basique pour montants plus grands
    return "montant élevé"; // Valeur par défaut pour les montants plus grands
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Générer une Facture"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (_isExpanded)
              ExpansionTile(
                title: Text("Ajouter une facture"),
                children: <Widget>[
                  TextField(
                    controller: _nomController,
                    decoration: InputDecoration(labelText: 'Nom'),
                  ),
                  TextField(
                    controller: _prenomController,
                    decoration: InputDecoration(labelText: 'Prénom'),
                  ),
                  TextField(
                    controller: _moisController,
                    decoration: InputDecoration(labelText: 'Mois'),
                  ),
                  TextField(
                    controller: _montantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Montant'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _genererFacture,
                    child: Text("Générer"),
                  ),
                ],
              ),
            SizedBox(height: 20),
            if (_factures.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _factures.length,
                  itemBuilder: (context, index) {
                    final facture = _factures[index];
                    return ListTile(
                      title: Text("${facture['nom']} ${facture['prenom']} - ${facture['mois']}"),
                      subtitle: Text(
                          "Montant: ${NumberFormat.currency(locale: 'fr', symbol: '€').format(facture['montant'])}\n"
                              "Montant en lettres: ${facture['montantEnLettres']}"
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          _afficherDetailsFacture(facture);
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _afficherDetailsFacture(Map<String, dynamic> facture) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Détails de la Facture"),
          content: Text(
            "Nom: ${facture['nom']}\n"
                "Prénom: ${facture['prenom']}\n"
                "Mois: ${facture['mois']}\n"
                "Montant: ${NumberFormat.currency(locale: 'fr', symbol: '€').format(facture['montant'])}\n"
                "Montant en lettres: ${facture['montantEnLettres']}",
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Fermer"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
