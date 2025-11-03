import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hemle/features/auth/presentation/screens/loginAccount_screen.dart';
import 'package:hemle/features/auth/presentation/screens/biometric_screen.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  bool _isLoading = true;
  late Widget _targetScreen;

  @override
  void initState() {
    super.initState();
    _determineRoute();
  }

  Future<void> _determineRoute() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool isBiometricsEnabled = prefs.getBool('biometrics_enabled') ?? false;
      
      if (mounted) {
        setState(() {
          _targetScreen = isBiometricsEnabled 
              ? _buildScreenWithWillPopScope(BiometricScreen())
              : _buildScreenWithWillPopScope(LoginaccountScreen());
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _targetScreen = _buildScreenWithWillPopScope(LoginaccountScreen());
          _isLoading = false;
        });
      }
    }
  }

  // Fonction pour envelopper un écran avec blocage du retour
  Widget _buildScreenWithWillPopScope(Widget screen) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: screen,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(radius: 16),
              SizedBox(height: 16),
              Text('Chargement...', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    return _targetScreen;
  }
}