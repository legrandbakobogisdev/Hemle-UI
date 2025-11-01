import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/CustomFormSection.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:hemle/features/findschool/presentation/widgets/MyPopupMenuButton.dart';
import 'package:hemle/features/findschool/presentation/widgets/file_selection_card.dart';
import 'package:hemle/features/home/data/models/home_models.dart';

class Editchildprofile extends StatefulWidget {
  const Editchildprofile({super.key});

  @override
  State<Editchildprofile> createState() => _EditchildprofileState();
}

class _EditchildprofileState extends State<Editchildprofile> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
    _fullname.dispose();
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
    return _fullname.text.isNotEmpty &&
        _dateOfBirthController.text.isNotEmpty &&
        _selectedLevel != null &&
        _selectedGender != null;
  }

  final List<Document> documents = [
    Document(
      id: '1',
      title: 'selectdocuments.passportorid.title'.tr(),
      description: 'selectdocuments.passportorid.desc'.tr(),
    ),
    Document(
      id: '2',
      title: 'selectdocuments.passportorid.title'.tr(),
      description: 'selectdocuments.passportorid.desc'.tr(),
    ),
  ];

  // Getter pour vérifier si tous les documents ont un fichier
  bool get _allDocumentsHaveFiles {
    return documents.every((document) => document.hasFile);
  }

  void _onFileSelected(XFile file, Document document) async {
    final fileSize = await file.length();

    setState(() {
      final index = documents.indexWhere((doc) => doc.id == document.id);
      if (index != -1) {
        documents[index] = Document(
          id: document.id,
          title: document.title,
          description: document.description,
          fileName: file.name,
          fileSize: fileSize,
          maxSize: document.maxSize,
          file: file,
        );
      }
    });
  }

  void _onFileRemoved(Document document) {
    setState(() {
      final index = documents.indexWhere((doc) => doc.id == document.id);
      if (index != -1) {
        documents[index] = Document(
          id: document.id,
          title: document.title,
          description: document.description,
          maxSize: document.maxSize,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomBackAppbar(),
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            _header(),
            Expanded(child: _body()),
            // _footer(),
            CustomFooter(
              label: 'global.savechange'.tr(),
              onPressed: () {},
              isDisabled: _isFormComplete && _allDocumentsHaveFiles,
              fullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: BouncingScrollPhysics(),
        children: [
          Customformsection(
            title: 'global.fullname'.tr(),
            isRequired: true,
            input: CustomTextField(
              controller: _fullname,
              type: TextFieldType.fullName,
            ),
          ),

          SizedBox(height: 14),

          Row(
            children: [
              // Colonne Age
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        CustomText(
                          label: '*',
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        CustomText(
                          label: 'global.age'.tr(),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ],
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
                    Wrap(
                      children: [
                        CustomText(
                          label: '*',
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        CustomText(
                          label: 'global.dateofbirth'.tr(),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ],
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

          SizedBox(height: 14),

          _buildLevelSection(),

          SizedBox(height: 14),

          _buidocumemts(),
        ],
      ),
    );
  }

  Widget _header() {
    return CustomHeader(
      title: 'global.editchildprofile'.tr(),
      desc: 'Amanda Fobi',
    );
  }


  Widget _buildLevelSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        CustomText(
          label: 'global.level'.tr(),
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
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

        const SizedBox(height: 10),

        // Section Gender
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            CustomText(
              label: 'global.gender'.tr(),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
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

  Widget _buidocumemts() {
    return Column(
      children: [
        Column(
          children: documents
              .map(
                (document) => FileSelectionCard(
                  document: document,
                  onFileSelected: _onFileSelected,
                  onFileRemoved: _onFileRemoved,
                ),
              )
              .toList(),
        ),
    
        SizedBox(height: 20),
      ],
    );
  }
}
