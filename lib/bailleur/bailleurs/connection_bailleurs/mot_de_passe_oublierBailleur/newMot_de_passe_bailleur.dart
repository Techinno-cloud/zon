import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../fonction/fonctionCouleur.dart';
import '../../../homeBailleurs/homeBailleur.dart';

class NewmotDePasseBailleur extends StatefulWidget {
  const NewmotDePasseBailleur({super.key});

  @override
  State<NewmotDePasseBailleur> createState() => _NewmotDePasseBailleurState();
}

class _NewmotDePasseBailleurState extends State<NewmotDePasseBailleur> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _isPressed = false;
  double _scale = 1.0;
  String? _errorText;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _onButtonPressed() {
    setState(() {
      _isPressed = true;
      _scale = 0.95;
    });
  }

  void _onButtonReleased() {
    setState(() {
      _isPressed = false;
      _scale = 1.0;
    });

    // Vérification si les mots de passe correspondent
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorText = 'Les mots de passe ne correspondent pas.';
      });
    } else if (!_isPasswordValid(_passwordController.text)) {
      setState(() {
        _errorText = 'Le mot de passe ne répond pas aux exigences de sécurité.';
      });
    } else {
      setState(() {
        _errorText = null;
      });

      // Naviguer vers la page Homebailleur
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Homebailleur(),
        ),
      );
    }
  }

  bool _isPasswordValid(String password) {
    final hasDigit = RegExp(r'\d').hasMatch(password);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    final hasSpecialChar = RegExp(r'[!@#()$%^&*+={}\[\]|\\:;,.<>?]').hasMatch(password);
    final isLengthValid = password.length >= 8 && password.length <= 20;

    return hasDigit && hasLowerCase && hasUpperCase && hasSpecialChar && isLengthValid;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.05; // 5% of screen width

    return Scaffold(
      backgroundColor: AppColors.getBlueColor(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: padding),
                child: SvgPicture.asset(
                  'assets/images/Z.svg',
                  width: screenSize.width * 0.75, // 75% of screen width
                  height: screenSize.width * 0.75, // 75% of screen width
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF6F8FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(padding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Définissez votre nouveau mot de passe",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Créez un nouveau mot de passe suite à l'oubli de l'ancien.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPasswordField(_passwordController, 'Mot de passe', _obscurePassword, _togglePasswordVisibility),
                      const SizedBox(height: 20),
                      _buildPasswordField(_confirmPasswordController, 'Confirmer le mot de passe', _obscureConfirmPassword, _toggleConfirmPasswordVisibility),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPasswordRequirement(
                            _isPasswordValid(_passwordController.text) && RegExp(r'\d').hasMatch(_passwordController.text),
                            '• Au moins un chiffre [0-9]',
                          ),
                          _buildPasswordRequirement(
                            _isPasswordValid(_passwordController.text) && RegExp(r'[a-z]').hasMatch(_passwordController.text),
                            '• Au moins un caractère minuscule [a-z]',
                          ),
                          _buildPasswordRequirement(
                            _isPasswordValid(_passwordController.text) && RegExp(r'[A-Z]').hasMatch(_passwordController.text),
                            '• Au moins un caractère majuscule [A-Z]',
                          ),
                          _buildPasswordRequirement(
                            _isPasswordValid(_passwordController.text) && RegExp(r'[!@#()$%^&*+={}\[\]|\\:;,.<>?]').hasMatch(_passwordController.text),
                            '• Au moins un caractère spécial comme @ ( ) ! #',
                          ),
                          _buildPasswordRequirement(
                            _isPasswordValid(_passwordController.text),
                            '• Au minimum 8 caractères et au maximum 20 caractères',
                          ),
                        ],
                      ),
                      if (_errorText != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            _errorText!,
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.all(padding),
                        child: SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTapDown: (_) => _onButtonPressed(),
                            onTapUp: (_) => _onButtonReleased(),
                            onTapCancel: () {
                              setState(() {
                                _isPressed = false;
                                _scale = 1.0;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              transform: Matrix4.identity()..scale(_scale),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: AppColors.getBlueColor(),
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Suivant',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: "Lato-Black",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String labelText, bool obscureText, VoidCallback toggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: AppColors.getBlueColor(),
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColors.getBlueColor()),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColors.getBlueColor()),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColors.getBlueColor(), width: 2.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(bool isValid, String requirement) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.clear,
          color: isValid ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(requirement),
      ],
    );
  }
}
