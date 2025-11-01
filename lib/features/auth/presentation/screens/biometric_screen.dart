import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';
import 'package:hemle/features/auth/presentation/screens/biometric_subScreen/faceId_screen.dart';
import 'package:hemle/features/auth/presentation/screens/biometric_subScreen/touchId_screen.dart';
import 'package:hemle/features/auth/presentation/screens/loginAccount_screen.dart';
import 'package:hemle/features/splashscreen/presentation/widgets/language_selector.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  // Clé pour forcer le rebuild du LanguageSelector
  final GlobalKey languageKey = GlobalKey();

  void onLanguageChanged() {
    // Forcer le rebuild de tout l'écran
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        actions: [
          LanguageSelector(
            key: languageKey,
            onLanguageChanged: onLanguageChanged,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSizes.screenHeight(context) / 5),

            CustomText(
              label: 'auth.biometric.title'.tr(),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),

            SizedBox(height: 10),

            CustomText(
              label: 'auth.biometric.desc'.tr(),
              fontSize: 16,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),

            Column(
              spacing: 10,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => TouchidScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    height: 81,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Color(0xFFE1E4E8)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 4,
                        children: [
                          Image.asset('assets/images/7.png'),
                          CustomText(label: 'Touch ID'),
                        ],
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => FaceidScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    height: 81,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Color(0xFFE1E4E8)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 4,
                        children: [
                          Image.asset('assets/images/8.png'),
                          CustomText(label: 'Face ID'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/9.png'),
                  CupertinoButton(
                    sizeStyle: CupertinoButtonSize.small,
                    child: CustomText(
                      label: 'global.usepass'.tr(),
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginaccountScreen(),
                        ),
                      );
                    },
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
