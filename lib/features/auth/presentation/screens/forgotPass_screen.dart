// ignore_for_file: unused_local_variable

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_footer.dart';
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
  bool _isPhoneValid = false;
  bool _isEmailValid = false;
  String optionChoose = 'SMS';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Écouter les changements des contrôleurs
    _phoneController.addListener(_updateValidation);
    _emailController.addListener(_updateValidation);
  }

  void _updateValidation() {
    setState(() {
      _isPhoneValid = _validatePhoneNumber(_phoneController.text) == null;
      _isEmailValid = _validateEmail(_emailController.text) == null;
    });
  }

  @override
  void dispose() {
    _phoneController.removeListener(_updateValidation);
    _emailController.removeListener(_updateValidation);
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    if (optionChoose == 'SMS') {
      return _isPhoneValid && _phoneController.text.isNotEmpty;
    } else {
      return _isEmailValid && _emailController.text.isNotEmpty;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _isFormValid) {
      // Toutes les validations sont passées
      _forgotPassAccount();
    }
  }

  void _forgotPassAccount() {
    if (optionChoose == 'SMS') {
      // Combiner le code pays avec le numéro de téléphone
      final fullPhoneNumber = '$_countryCode${_phoneController.text.trim()}';
      
      final userData = {
        'phone': fullPhoneNumber,
        'type': 'SMS',
      };
      
      // Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneverificationScreen(userData: userData)));
    } else {
      final userData = {
        'email': _emailController.text.trim(),
        'type': 'Email',
      };
      
      // Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneverificationScreen(userData: userData)));
    }
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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.create.email_validation_error'.tr();
    }

    // Validation de l'email
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'auth.create.email_validation_error'.tr();
    }

    return null;
  }

  void _clearFields() {
    if (optionChoose == 'SMS') {
      _emailController.clear();
    } else {
      _phoneController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                shrinkWrap: true,
                children: [ Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  optionChoose = 'SMS';
                                  _clearFields();
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
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/11.png',
                                        color: optionChoose == 'SMS'
                                            ? Color(0xFF0065FF)
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
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
                
                            const SizedBox(width: 8),
                
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  optionChoose = 'Email';
                                  _clearFields();
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
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/12.png',
                                        color: optionChoose == 'Email'
                                            ? Color(0xFF0065FF)
                                            : Colors.black54,
                                      ),
                                      const SizedBox(width: 8),
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
                            children: [
                              CustomText(
                                label: 'auth.create.phone_number'.tr(),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                
                              const SizedBox(height: 8),
                
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
                            children: [
                              CustomText(
                                label: 'auth.create.email'.tr(),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                
                              const SizedBox(height: 8),
                
                              CustomTextField(
                                controller: _emailController,
                                type: TextFieldType.email,
                                onChanged: (value) => setState(() {}),
                                hintText: 'auth.create.enter_email'.tr(),
                                validator: _validateEmail,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                ]
              ),
            ),
      
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomFooter(
                label: 'global.sendinstruction'.tr(),
                fullWidth: true,
                isDisabled: _isFormValid, 
                onPressed: _submitForm,
                otherButton: Align(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCountryChanged(CountryCode countryCode) {
    setState(() {
      _countryCode = countryCode.dialCode!;
    });
  }
}