import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/splashscreen/presentation/screens/carousel_screen.dart';
import 'package:hemle/features/splashscreen/presentation/widgets/language_selector.dart';

class SplashscreenScreen extends StatefulWidget {
  const SplashscreenScreen({super.key});

  @override
  State<SplashscreenScreen> createState() => _SplashscreenScreenState();
}

class _SplashscreenScreenState extends State<SplashscreenScreen> {
  // Clé pour forcer le rebuild du LanguageSelector
  final GlobalKey _languageKey = GlobalKey();

  void _onLanguageChanged() {
    // Forcer le rebuild de tout l'écran
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          LanguageSelector(
            key: _languageKey,
            onLanguageChanged: _onLanguageChanged,
          ),
          const SizedBox(width: 16)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 60),
                  SizedBox(height: 20),
                  CustomText(
                    label: "HEMLE",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ],
              ),
            ),
            CustomButton(
              fullWidth: true, 
              label: 'global.continuer'.tr(), 
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => CarouselScreen(),));
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}