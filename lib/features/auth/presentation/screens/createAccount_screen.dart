import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/CustomFormSection.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/auth/presentation/screens/phoneVerification_screen.dart';
import 'package:hemle/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:hemle/features/auth/presentation/widgets/phone_field.dart';
import 'package:hemle/features/auth/presentation/widgets/role_dropdown.dart';
import 'package:hemle/features/splashscreen/presentation/widgets/language_selector.dart';

class CreateaccountScreen extends StatefulWidget {
  const CreateaccountScreen({super.key});

  @override
  State<CreateaccountScreen> createState() => _CreateaccountScreenState();
}

class _CreateaccountScreenState extends State<CreateaccountScreen> {
  // Clé pour forcer le rebuild du LanguageSelector
  final GlobalKey languageKey = GlobalKey();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isAcceptTerm = false;
  String? _selectedRole;
  String _countryCode = '+237';
  bool isvalid = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void onLanguageChanged() {
    // Forcer le rebuild de tout l'écran
    setState(() {});
  }

  void _onRoleChanged(String? role) {
    setState(() {
      _selectedRole = role;
    });
  }

  void _onCountryChanged(CountryCode countryCode) {
    setState(() {
      _countryCode = countryCode.dialCode!;
    });
  }

  bool get _isFormValid {
    // Vérifier si tous les champs sont remplis et valides
    final isFullNameValid = _fullnameController.text.trim().isNotEmpty;
    final isEmailValid =
        _emailController.text.trim().isNotEmpty &&
        RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        ).hasMatch(_emailController.text.trim());
    final isPasswordValid = _passwordController.text.length >= 8;
    final isPhoneValid = _phoneController.text.trim().isNotEmpty;
    final isRoleSelected = _selectedRole != null;
    final isTermsAccepted = isAcceptTerm;

    return isFullNameValid &&
        isEmailValid &&
        isPasswordValid &&
        isPhoneValid &&
        isRoleSelected &&
        isTermsAccepted;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _isFormValid) {
      // Toutes les validations sont passées
      _createAccount();
    }
  }

  void _createAccount() {
    // Combiner le code pays avec le numéro de téléphone
    final fullPhoneNumber = '$_countryCode${_phoneController.text.trim()}';

    final userData = {
      'role': _selectedRole,
      'fullName': _fullnameController.text.trim(),
      'phone': fullPhoneNumber,
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhoneverificationScreen(userData: userData),
      ),
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
          surfaceTintColor: AppColors.background,
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
        body: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomText(
                          label: "auth.create.title".tr(),
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),

                        SizedBox(height: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            CustomText(
                              label: 'auth.create.select_role'.tr(),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            RoleDropdown(onChanged: _onRoleChanged),
                          ],
                        ),

                        SizedBox(height: 20),

                        Customformsection(
                          title: 'auth.create.full_name'.tr(),
                          isRequired: true,
                          input: CustomTextField(
                            controller: _fullnameController,
                            type: TextFieldType.fullName,
                            onChanged: (value) => setState(() {}),
                            hintText: 'auth.create.enter_full_name'.tr(),
                          ),
                        ),

                        SizedBox(height: 20),

                        Customformsection(
                          title: 'auth.create.phone_number'.tr(),
                          isRequired: true,
                          input: PhoneField(
                            onCountryChanged: _onCountryChanged,
                            phoneController: _phoneController,
                            validator: _validatePhoneNumber,
                          ),
                        ),

                        SizedBox(height: 20),

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

                        SizedBox(height: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            CustomText(
                              label: 'auth.create.create_password'.tr(),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),

                            CustomTextField(
                              controller: _passwordController,
                              type: TextFieldType.password,
                              obscureText: true,
                              onChanged: (value) => setState(() {}),
                              hintText: 'auth.create.enter_password'.tr(),
                              helper: CustomText(
                                label: 'auth.create.password_hint'.tr(),
                                fontstyle: FontStyle.italic,
                                fontSize: 12,
                                color: _passwordController.text.length >= 8
                                    ? AppColors.success
                                    : AppColors.textSecondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Row(
                          children: [
                            Checkbox.adaptive(
                              value: isAcceptTerm,
                              onChanged: (value) {
                                setState(() {
                                  isAcceptTerm = !isAcceptTerm;
                                });
                              },
                            ),
                            Expanded(
                              child: Wrap(
                                children: [
                                  CustomText(
                                    label: 'auth.create.terms_text'.tr(),
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Naviguer vers les Terms of Service
                                    },
                                    child: CustomText(
                                      label: 'auth.create.terms_of_service'
                                          .tr(),
                                      fontSize: 14,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  CustomText(
                                    label: 'auth.create.and'.tr(),
                                    fontSize: 14,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Naviguer vers la Data Policy
                                    },
                                    child: CustomText(
                                      label: 'auth.create.data_policy'.tr(),
                                      fontSize: 14,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            CustomFooter(
              label: 'global.register'.tr(),
              fullWidth: true,
              isDisabled: _isFormValid,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
}
