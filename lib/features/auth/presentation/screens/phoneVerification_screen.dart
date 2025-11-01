import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/splashscreen/presentation/widgets/language_selector.dart';
import 'package:pinput/pinput.dart';

class PhoneverificationScreen extends StatefulWidget {
  final Map<String, String?> userData;

  const PhoneverificationScreen({super.key, required this.userData});

  @override
  State<PhoneverificationScreen> createState() =>
      _PhoneverificationScreenState();
}

class _PhoneverificationScreenState extends State<PhoneverificationScreen> {
  // Clé pour forcer le rebuild du LanguageSelector
  final GlobalKey languageKey = GlobalKey();

  final TextEditingController pinController = TextEditingController();
  final FocusNode pinFocusNode = FocusNode();
  int _countdown = 30;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _countdown = 30;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendCode() {
    if (_canResend) {
      // Simuler l'envoi du code
      _sendVerificationCode();
      _startCountdown();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('auth.verifyphone.code_sent'.tr()),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _sendVerificationCode() {
    // Ici vous implémenteriez l'appel API pour envoyer le code de vérification
    // Par exemple :
    // await AuthService.sendVerificationCode(widget.userData['phone']!);
    // print('Sending verification code to: ${widget.userData['phone']}');
  }

  void _verifyCode() {
    if (pinController.text.length == 6) {
      // Ici vous implémenteriez la vérification du code
      // Par exemple :
      // bool isValid = await AuthService.verifyCode(pinController.text);
      
      // Simulation de vérification réussie
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('auth.verifyphone.verification_success'.tr()),
          backgroundColor: Colors.green,
        ),
      );

      // Naviguer vers l'écran suivant
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextScreen()));
    }
  }

  void onLanguageChanged() {
    setState(() {});
  }

  String _maskPhoneNumber(String phone) {
    if (phone.length < 6) return phone;
    final start = phone.substring(0, 5);
    final end = phone.substring(phone.length - 2);
    return '$start******$end';
  }

  @override
  Widget build(BuildContext context) {
    final maskedPhone = _maskPhoneNumber(widget.userData['phone'] ?? '');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: CustomText(
          label: 'global.back'.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          LanguageSelector(
            key: languageKey,
            onLanguageChanged: onLanguageChanged,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              label: 'auth.verifyphone.title'.tr(),
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),

            const SizedBox(height: 25),

            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                CustomText(
                  label: 'auth.verifyphone.desc'.tr(),
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
                CustomText(
                  label: maskedPhone,
                  fontSize: 16,
                ),
              ],
            ),

            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label: 'auth.verifyphone.verifypin'.tr(),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 8),
                
                Pinput(
                  length: 6,
                  keyboardType: TextInputType.number,
                  controller: pinController,
                  focusNode: pinFocusNode,
                  errorTextStyle: TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.error,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                   fontStyle: FontStyle.italic
                  ),
                  validator: (value) {
                    if(value != '123456'){
                      return 'auth.verifyphone.invalidcode'.tr();
                    }
                    return null;
                  
                    
                  },
                  
                  onChanged: (value) {
                    setState(() {});
                  },
                  // onCompleted: (value) {
                  //   _verifyCode();
                  // },
                ),

                const SizedBox(height: 8),
                
                GestureDetector(
                  onTap: _canResend ? _resendCode : null,
                  child: Wrap(
                    children: [
                      CustomText(
                        label: _canResend ? 'auth.verifyphone.resend'.tr()  : 'auth.verifyphone.resendcode'.tr(),
                        fontSize: 12,
                        color: _canResend ? AppColors.primary : AppColors.textSecondary,
                        decoration: _canResend ? TextDecoration.underline : null,
                        decorationColor: AppColors.primary,
                      ),


                      if(!_canResend)
                      CustomText(
                        label: ' $_countdown',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _canResend ? AppColors.primary : AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            CustomButton(
              fullWidth: true,
              isDisabled: pinController.text.length != 6,
              onPressed: pinController.text.length == 6 ? _verifyCode : null,
              label: 'global.verify'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}