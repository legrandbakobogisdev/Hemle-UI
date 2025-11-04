import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/features/splashscreen/presentation/screens/carousel_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hemle/features/auth/presentation/screens/loginAccount_screen.dart';
import 'package:hemle/features/auth/presentation/screens/biometric_screen.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {

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
        // Utilisation de pushAndRemoveUntil pour une navigation propre
        if (isBiometricsEnabled) {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => BiometricScreen()),
            (route) => false, // Supprime toutes les routes précédentes
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => CarouselScreen()),
            (route) => false, // Supprime toutes les routes précédentes
          );
        }
      }
    } catch (e) {
      // Fallback vers le login en cas d'erreur
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => LoginaccountScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(radius: 16),
            // SizedBox(height: 16),
            // Text('Chargement...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}