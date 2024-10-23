import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../fonction/fonctionCouleur.dart';
import 'Inscr_Mode_envoi_codeBailleur/inscr_SMScode_bailleur.dart';

class InscrMotDePasseBilleur extends StatefulWidget {
  const InscrMotDePasseBilleur({super.key});

  @override
  State<InscrMotDePasseBilleur> createState() => _InscrMotDePasseBilleurState();
}

class _InscrMotDePasseBilleurState extends State<InscrMotDePasseBilleur> {
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

    // Check if passwords match
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

      // Navigate to the InscrSmscodeBailleur page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InscrSmscodeBailleur(),
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
    return Scaffold(
      backgroundColor: AppColors.getBlueColor(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(
                    'assets/images/Z.svg',
                    width: MediaQuery.of(context).size.width * 0.75, // Adjust width based on screen size
                    height: MediaQuery.of(context).size.height * 0.3, // Adjust height based on screen size
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF6F8FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Connectez-vous",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Veuillez créer un mot de passe pour sécuriser votre compte.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      controller: _passwordController,
                      label: 'Mot de passe',
                      obscureText: _obscurePassword,
                      toggleVisibility: _togglePasswordVisibility,
                    ),
                    const SizedBox(height: 20),
                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      label: 'Confirmer le mot de passe',
                      obscureText: _obscureConfirmPassword,
                      toggleVisibility: _toggleConfirmPasswordVisibility,
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordRequirements(),
                    if (_errorText != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          _errorText!,
                          style: const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    const SizedBox(height: 30),
                    _buildNextButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: AppColors.getBlueColor(),
      decoration: InputDecoration(
        labelText: label,
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

  Widget _buildPasswordRequirements() {
    return Column(
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
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(bool isValid, String text) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
