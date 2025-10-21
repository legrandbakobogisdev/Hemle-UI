// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:hemle/features/navigation/presentation/screens/layoutSupport.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isValidating = false;

  void _validateCode() {
    if (_codeController.text.isEmpty) return;
    
    setState(() {
      _isValidating = true;
    });
    
    // Simuler la validation
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isValidating = false;
      });
      
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Layoutsupport()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomBackAppbar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomInset: false,
        floatingActionButton:                 // Bouton de validation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: CustomButton(
                    label: 'home.code.validate_button'.tr(),
                    fullWidth: true,
                    isDisabled: _codeController.text.isEmpty,
                    isLoading: _isValidating,
                    onPressed: _validateCode,
                  ),
                ),
                
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: 'home.code.title'.tr(),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                      
                    const SizedBox(height: 24),
                    
                    // Description
                    CustomText(
                      label: 'home.code.description'.tr(),
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Champ de code
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          label: 'home.code.input_label'.tr(),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _codeController,
                          type: TextFieldType.custom,
                          hintText: 'home.code.input_hint'.tr(),
                          onChanged: (value) => setState(() {}),
                        ),
                      ],
                    ),
                  ],
                ),


                                // Bouton de validation
           
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}