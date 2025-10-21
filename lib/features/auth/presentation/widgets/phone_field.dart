// ignore_for_file: must_be_immutable

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/config/colors/appColors.dart';

class PhoneField extends StatefulWidget {
  ValueChanged<CountryCode>? onCountryChanged;
  TextEditingController phoneController;
  String? Function(String?)? validator;
  PhoneField({
    super.key,
    required this.onCountryChanged,
    required this.phoneController,
    this.validator,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE1E4E8)),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 117,
            decoration: BoxDecoration(
              color: Color(0xFFF7F8FA),
              border: Border(
                right: BorderSide(width: 1, color: Color(0xFFE1E4E8)),
              ),
            ),
            child: CountryCodePicker(
              initialSelection: 'CM',
              favorite: ['+237', 'CM'],
              onChanged: widget.onCountryChanged,
              headerText: 'auth.selectcountry'.tr(),
            ),
          ),

          Expanded(
            child: TextFormField(
              controller: widget.phoneController,
              cursorColor: AppColors.primary,
              validator: widget.validator,
              keyboardType: TextInputType.phone,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'auth.create.enter_phone_number'.tr(),
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.grey.shade600,
                ),
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.grey.shade700,
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
