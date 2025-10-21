import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/applications/presentation/screens/applicationstatus_screen.dart';
import 'package:hemle/features/findschool/presentation/widgets/MyPopupMenuButton.dart';
import 'package:hemle/features/findschool/presentation/widgets/detailschildmodal.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ChildprofileScreen extends StatefulWidget {
  const ChildprofileScreen({super.key});

  @override
  State<ChildprofileScreen> createState() => _ChildprofileScreenState();
}

class _ChildprofileScreenState extends State<ChildprofileScreen> {
  static const _smallSpacing = 10.0;

  // Contrôleurs pour les champs de texte
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  // Variables pour les sélections
  String? _selectedLevel;
  String? _selectedGender;
  String? _calculatedAge;

  // Listes pour les dropdowns
  final List<String> _levelOptions = [
    'Preschool',
    'Elementary',
    'Middle School',
    'High School',
  ];
  final List<String> _genderOptions = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    // Écouter les changements de date de naissance pour calculer l'âge
    _dateOfBirthController.addListener(_calculateAge);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  void _calculateAge() {
    if (_dateOfBirthController.text.length == 10) {
      // DD/MM/YYYY format
      setState(() {
        _calculatedAge = _calculateAgeFromDate(_dateOfBirthController.text);
      });
    }
  }

  String _calculateAgeFromDate(String date) {
    try {
      final parts = date.split('/');
      if (parts.length == 3) {
        final day = int.tryParse(parts[0]);
        final month = int.tryParse(parts[1]);
        final year = int.tryParse(parts[2]);

        if (day != null && month != null && year != null) {
          final birthDate = DateTime(year, month, day);
          final now = DateTime.now();
          final age = now.year - birthDate.year;

          if (now.month < birthDate.month ||
              (now.month == birthDate.month && now.day < birthDate.day)) {
            return '${age - 1}';
          }
          return age.toString();
        }
      }
    } catch (e) {
      return e.toString();
    }
    return '';
  }

  bool get _isFormComplete {
    return _fullNameController.text.isNotEmpty &&
        _dateOfBirthController.text.isNotEmpty &&
        _selectedLevel != null &&
        _selectedGender != null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomBackAppbar(),
        body: Column(children: [_header(), _body()]),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'childprofile.title'.tr(),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: _smallSpacing),
          CustomText(
            label: 'childprofile.desc'.tr(),
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          const SizedBox(height: 10),

          CircleAvatar(
            radius: 60,
            backgroundColor: Color(0xFFE1E4E8),
            child: Icon(
              IconsaxPlusLinear.camera,
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(height: 20),

          // Full Name Section
          _buildSectionTitle('Full Name'),
          const SizedBox(height: 12),
          _buildFullNameSection(),

          const SizedBox(height: 24),

          // Level Requested Section
          _buildSectionTitle('Level Requested'),
          const SizedBox(height: 12),
          _buildLevelSection(),

          const SizedBox(height: 40),

          // Continue Button
          // Dans votre ChildprofileScreen, modifiez le onPressed du CustomButton :
          CustomButton(
            onPressed: _isFormComplete
                ? () {
                    showConfirmInformationModal(
                      context: context,
                      fullName: _fullNameController.text,
                      age: _calculatedAge ?? '',
                      dateOfBirth: _dateOfBirthController.text,
                      level: _selectedLevel ?? '',
                      gender: _selectedGender ?? '',
                      onConfirm: () {
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (context) => const ApplicationstatusScreen(),
                        ));
                        setState(() {
                          
                        });
                      },
                    );
                  }
                : null,
            isDisabled: !_isFormComplete,
            icon: Icon(IconsaxPlusLinear.arrow_right, color: Colors.white),
            fullWidth: true,
            label: 'global.continue'.tr(),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return CustomText(
      label: title,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  Widget _buildFullNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Champ Full Name
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE1E4E8)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _fullNameController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter child\'s full name',
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            onChanged: (value) => setState(() {}),
          ),
        ),
        const SizedBox(height: 16),

        // Section Age et Date of Birth
        Row(
          children: [
            // Colonne Age
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    label: 'Age',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE1E4E8)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText(
                      label: _calculatedAge ?? 'Age',
                      fontSize: 14,
                      color: _calculatedAge != null
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Colonne Date of Birth
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    label: 'Date of Birth',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE1E4E8)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _dateOfBirthController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'DD/MM/YYYY',
                        hintStyle: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLevelSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown Level
        MyPopupMenuButton(
          options: _levelOptions,
          label: _selectedLevel ?? 'Select Level',
          color: const Color(0xFFF7F8FA),
          bordercolor: Color(0xFFE1E4E8),
          onSelect: (value) {
            setState(() {
              _selectedLevel = value;
            });
          },
        ),
        const SizedBox(height: 16),

        // Section Gender
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              label: 'Gender',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            const SizedBox(height: 8),
            MyPopupMenuButton(
              options: _genderOptions,
              color: const Color(0xFFF7F8FA),
              bordercolor: Color(0xFFE1E4E8),
              label: _selectedGender ?? 'Select Gender',
              onSelect: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
