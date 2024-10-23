import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../../../fonction/fonctionCouleur.dart';
import '../../../../profil/elec_cash_Eau_cash/homeBailleur1.dart';

class Preconnectionfloozbailleur extends StatefulWidget {
  const Preconnectionfloozbailleur({super.key});

  @override
  State<Preconnectionfloozbailleur> createState() => _PreconnectionfloozbailleurState();
}

class _PreconnectionfloozbailleurState extends State<Preconnectionfloozbailleur> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isPasswordVisible1 = false;
  bool _isPasswordVisible2 = false;

  @override
  void initState() {
    super.initState();

    _phoneController.addListener(_updateButtonState);
    _passwordController1.addListener(_updateButtonState);
    _passwordController2.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController1.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _isValidPhoneNumber(_phoneController.text) &&
          _passwordController1.text.isNotEmpty &&
          _passwordController2.text.isNotEmpty &&
          _passwordController1.text == _passwordController2.text;
    });
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length == 8;
  }

  void _validatePhoneNumber() {
    print("Numéro validé : ${_phoneController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homebailleur1()),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16), // Utilisation de paddings responsives
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Veuillez entrer le numéro de téléphone sur"
                          " lequel vous souhaitez recevoir vos retraits."
                          " Ce numéro est fixe et ne pourra être modifié que"
                          " dans les paramètres de votre compte.",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        IntlPhoneField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Numéro de téléphone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.getBlueColor(),
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: AppColors.getBlueColor(),
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: AppColors.getBlueColor(),
                                width: 2.0,
                              ),
                            ),
                          ),
                          initialCountryCode: 'TG',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            print('Country changed to: ${country.name}');
                          },
                        ),
                        const SizedBox(height: 20),

                        // Champ de mot de passe 1
                        TextFormField(
                          controller: _passwordController1,
                          obscureText: !_isPasswordVisible1,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.getBlueColor(),
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible1 ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.getBlueColor(),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible1 = !_isPasswordVisible1;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Champ de mot de passe 2
                        TextFormField(
                          controller: _passwordController2,
                          obscureText: !_isPasswordVisible2,
                          decoration: InputDecoration(
                            labelText: 'Confirmer le mot de passe',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.getBlueColor(),
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible2 ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.getBlueColor(),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible2 = !_isPasswordVisible2;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _isButtonEnabled ? _validatePhoneNumber : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isButtonEnabled ? AppColors.getBlueColor() : Colors.grey,
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Valider',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4, // Utilisation d'une taille relative
      decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(
          image: AssetImage('assets/images/Moov-Money.webp'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            bottom: 30,
            child: Text(
              '', // Ajoutez un texte ici si nécessaire
              style: TextStyle(
                color: Colors.white,
                fontSize: 43,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
