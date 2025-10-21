// ignore_for_file: unused_local_variable

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';
import 'package:hemle/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:hemle/features/auth/presentation/widgets/phone_field.dart';
import 'package:hemle/features/splashscreen/presentation/widgets/language_selector.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ForgotpassScreen extends StatefulWidget {
  const ForgotpassScreen({super.key});

  @override
  State<ForgotpassScreen> createState() => _ForgotpassScreenState();
}

class _ForgotpassScreenState extends State<ForgotpassScreen> {
  // Clé pour forcer le rebuild du LanguageSelector
  final GlobalKey languageKey = GlobalKey();

  void onLanguageChanged() {
    // Forcer le rebuild de tout l'écran
    setState(() {});
  }

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _countryCode = '+237';
  bool isvalid = false;
  String optionChoose = 'SMS';

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    final isPhoneValid = _phoneController.text.trim().isNotEmpty;
    final isEmailValid =
        _emailController.text.trim().isNotEmpty &&
        RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        ).hasMatch(_emailController.text.trim());

    if (isPhoneValid) {
      return isPhoneValid;
    }

    if (isEmailValid) {
      return isEmailValid;
    }

    return false;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _isFormValid) {
      // Toutes les validations sont passées
      _forgotPassAccount();
    }
  }

  void _forgotPassAccount() {
    // Combiner le code pays avec le numéro de téléphone
    final fullPhoneNumber = '$_countryCode${_phoneController.text.trim()}';

    final userData = {
      'phone': fullPhoneNumber,
      'email': _emailController.text.trim(),
    };

    // Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneverificationScreen(userData: userData)));
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.create.phone_validation_error'.tr();
    }

    // Validation basique du numéro de téléphone
    final phoneRegex = RegExp(r'^[0-9]{9,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'auth.create.phone_validation_error'.tr();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: AppSizes.screenHeight(context) / 10),
            
                      CustomText(
                        label: 'auth.forgot.title'.tr(),
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
            
                      SizedBox(height: 10),
            
                      CustomText(
                        label: 'auth.forgot.desc'.tr(),
                        fontSize: 16,
                        textAlign: TextAlign.center,
                      ),
            
                      SizedBox(height: 20),
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              setState(() {
                                optionChoose = 'SMS';
                              });
                            },
                            child: Container(
                              width: 159,
                              height: 56,
                              decoration: BoxDecoration(
                                color: optionChoose == 'SMS'
                                    ? Color(0xFFDEEBFF)
                                    : Color(0xFFF7F8FA),
                                border: Border.all(
                                  width: 1,
                                  color: optionChoose == 'SMS'
                                      ? Color(0xFF0065FF)
                                      : Color(0xFFE1E4E8),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Row(
                                  spacing: 8,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/11.png',
                                      color: optionChoose == 'SMS'
                                          ? Color(0xFF0065FF)
                                          : null,
                                    ),
                                    CustomText(
                                      label: 'SMS',
                                      fontSize: 15,
                                      color: optionChoose == 'SMS'
                                          ? Color(0xFF0065FF)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
            
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              setState(() {
                                optionChoose = 'Email';
                              });
                            },
                            child: Container(
                              width: 159,
                              height: 56,
                              decoration: BoxDecoration(
                                color: optionChoose == 'Email'
                                    ? Color(0xFFDEEBFF)
                                    : Color(0xFFF7F8FA),
                                border: Border.all(
                                  width: 1,
                                  color: optionChoose == 'Email'
                                      ? Color(0xFF0065FF)
                                      : Color(0xFFE1E4E8),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Row(
                                  spacing: 8,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/12.png',
                                      color: optionChoose == 'Email'
                                          ? Color(0xFF0065FF)
                                          : Colors.black54,
                                    ),
                                    CustomText(
                                      label: 'Email',
                                      fontSize: 15,
                                      color: optionChoose == 'Email'
                                          ? Color(0xFF0065FF)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
            
                      SizedBox(height: 20),
            
                      if (optionChoose == 'SMS')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            CustomText(
                              label: 'auth.create.phone_number'.tr(),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
            
                            PhoneField(
                              onCountryChanged: _onCountryChanged,
                              phoneController: _phoneController,
                              validator: _validatePhoneNumber,
                            ),
                          ],
                        ),
                      if (optionChoose == 'Email')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            CustomText(
                              label: 'auth.create.email'.tr(),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
            
                            CustomTextField(
                              controller: _emailController,
                              type: TextFieldType.email,
                              onChanged: (value) => setState(() {}),
                              hintText: 'auth.create.enter_email'.tr(),
                            ),
                          ],
                        ),
            
                    ],
                  ),
                ),
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.background
              ),
            child: Column(
              children: [
                CustomButton(
                        label: 'global.sendinstruction'.tr(),
                        fullWidth: true,
                        isDisabled: !_isFormValid,
                        onPressed: _submitForm,
                      ),
            
                      SizedBox(height: 20),
            
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              IconsaxPlusLinear.arrow_left,
                              color: AppColors.primary,
                            ),
                            CupertinoButton(
                              sizeStyle: CupertinoButtonSize.small,
                              child: CustomText(
                                label: 'global.backto'.tr(
                                  args: ['global.login'.tr()],
                                ),
                                color: AppColors.primary,
                                fontSize: 16,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onCountryChanged(CountryCode countryCode) {
    setState(() {
      _countryCode = countryCode.dialCode!;
    });
  }
}
