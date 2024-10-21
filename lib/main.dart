import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_ges/première_page .dart';
import 'bailleur/bailleurs/connection_bailleurs/mot_de_passeBailleur.dart';
import 'bailleur/bailleurs/inscription_bailleur/inscr_mot_de_passe_bailleur.dart';
import 'bailleur/homeBailleurs/homeBailleur.dart';
import 'bailleur/homeBailleurs/port_recu_retraitBailleur/portefeuilleBailleur/retrait/FloozBailleur/floozBailleur.dart';
import 'bailleur/homeBailleurs/port_recu_retraitBailleur/portefeuilleBailleur/retrait/FloozBailleur/preconnectionFloozBailleur.dart';
import 'bailleur/homeBailleurs/port_recu_retraitBailleur/portefeuilleBailleur/retrait/TmoneyBailleur/preconnectionTmoneyBailleur.dart';
import 'bailleur/homeBailleurs/port_recu_retraitBailleur/portefeuilleBailleur/retrait/TmoneyBailleur/tmoneyBailleur.dart';
import 'bailleur/homeBailleurs/profileBailleur/modifierProfilBailleur/modifierBailleur.dart';
import 'fonction/fonctionCouleur.dart';


void main()  {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Durée de l'animation de sortie du logo
    );

    _animation = Tween<Offset>(
      begin: Offset(0.0, 0.0), // Départ au centre
      end: Offset(0.0, -1.0), // Déplacement vers le haut
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward().whenComplete(() {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => PremierePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // Démarre depuis le bas
            const end = Offset.zero; // Fin en position normale
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end);
            var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

            // Augmenter la durée de la transition pour la rendre plus lente
            return FadeTransition(
              opacity: animation.drive(CurveTween(curve: Curves.easeInOut)),
              child: SlideTransition(position: offsetAnimation, child: child),
            );
          },
          transitionDuration: Duration(seconds: 3), // Durée de la transition vers la nouvelle page
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBlueColor(), // Utilisation de la couleur bleue définie,
      body: Center(
        child: SlideTransition(
          position: _animation,
          child: SvgPicture.asset(
            'assets/images/Z.svg',
            color: Colors.white,
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
