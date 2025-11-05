import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';
import 'package:hemle/features/auth/presentation/screens/forgotPass_screen.dart';
import 'package:hemle/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:hemle/features/auth/presentation/widgets/phone_field.dart';
import 'package:hemle/features/home/presentation/screens/home_screen_zero_state.dart';
import 'package:hemle/features/splashscreen/presentation/widgets/language_selector.dart';

class LoginaccountScreen extends StatefulWidget {
  const LoginaccountScreen({super.key});

  @override
  State<LoginaccountScreen> createState() => _LoginaccountScreenState();
}

class _LoginaccountScreenState extends State<LoginaccountScreen> {
  // Clé pour forcer le rebuild du LanguageSelector
  final GlobalKey languageKey = GlobalKey();

  void onLanguageChanged() {
    // Forcer le rebuild de tout l'écran
    setState(() {});
  }

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool isvalid = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    // Vérifier si tous les champs sont remplis et valides
    final isPasswordValid = _passwordController.text.length >= 8;
    final isPhoneValid = _phoneController.text.trim().isNotEmpty;

    return isPasswordValid && isPhoneValid;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _isFormValid) {
      // Toutes les validations sont passées
      _loginAccount();
    }
  }

  void _loginAccount() {
    // Combiner le code pays avec le numéro de téléphone

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreenZeroState()),
    );
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: CustomText(
            label: 'global.back'.tr(),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          surfaceTintColor: AppColors.background,
          backgroundColor: AppColors.background,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                children: [ 
                  Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: AppSizes.screenHeight(context) / 10),
                
                      CustomText(
                        label: 'auth.login.title'.tr(),
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                
                      SizedBox(height: 10),
                
                      CustomText(label: 'auth.login.desc'.tr(), fontSize: 16),
                
                      SizedBox(height: 20),
                
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
                
                      SizedBox(height: 20),
                
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          CustomText(
                            label: 'auth.login.password'.tr(),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                
                          CustomTextField(
                            controller: _passwordController,
                            type: TextFieldType.password,
                            obscureText: true,
                            onChanged: (value) => setState(() {}),
                            hintText: 'auth.login.enter_password'.tr(),
                          ),
                        ],
                      ),
                
                      SizedBox(height: 20),
                
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CupertinoButton(
                          sizeStyle: CupertinoButtonSize.small,
                          child: CustomText(
                            label: 'auth.login.forgot_pass'.tr(),
                            color: AppColors.primary,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ForgotpassScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ]
              ),
            ),

            CustomFooter(
              label: 'global.login'.tr(),
              fullWidth: true,
              isDisabled: _isFormValid,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  void _onCountryChanged(CountryCode countryCode) {
    setState(() {});
  }
}
