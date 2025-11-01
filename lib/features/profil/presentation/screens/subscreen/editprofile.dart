import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/CustomFormSection.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:hemle/features/auth/presentation/widgets/phone_field.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  List<Map<String, String>> childrens = [
    {"name": "Amara Fobi", "code": "STU001", "school": "Maarif School"},
    {"name": "Jean-Baptiste Fobi", "code": "STU002", "school": "Maarif School"},
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomBackAppbar(),
        body: Column(
          children: [
            _header(),
            Expanded(child: _body()),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return CustomHeader(title: 'global.editprofile'.tr(), desc: 'Chantal Fobi');
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            spacing: 10,
            children: [
              Customformsection(
                title: 'global.fullname'.tr(),
                isRequired: true,
                input: CustomTextField(
                  controller: _fullname,
                  type: TextFieldType.fullName,
                ),
              ),

              Customformsection(
                title: 'global.phonenumber'.tr(),
                isRequired: true,
                input: PhoneField(
                  onCountryChanged: _onCountryChanged,
                  phoneController: phoneController,
                  validator: _validatePhoneNumber,
                ),
              ),

              Customformsection(
                title: 'global.email'.tr(),
                isRequired: false,
                input: CustomTextField(
                  controller: _email,
                  type: TextFieldType.email,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              CustomText(
                label: 'global.children'.tr(),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),

              Column(
                children: childrens
                    .map(
                      (child) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                label: child['name']!,
                                fontWeight: FontWeight.w500,
                              ),
                              Icon(IconsaxPlusLinear.trash, size: 20),
                            ],
                          ),

                          Divider(),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return CustomFooter(label: 'global.savechange'.tr(), onPressed: (){}, fullWidth: true, isDisabled: true,);
  }

  void _onCountryChanged(CountryCode countryCode) {
    setState(() {});
  }
}
