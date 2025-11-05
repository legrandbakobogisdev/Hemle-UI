import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/home/data/models/home_models.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ProgramsScreenSchool extends StatefulWidget {
  final School school;
  const ProgramsScreenSchool({super.key, required this.school});
  @override
  State<ProgramsScreenSchool> createState() => _ProgramsScreenSchoolState();
}

class _ProgramsScreenSchoolState extends State<ProgramsScreenSchool> {
  static const _dividerColor = Color(0xFFE1E4E8);
  static const _verticalSpacing = 14.0;
  static const _smallSpacing = 10.0;

  // Méthode pour créer une section avec titre et contenu
  Widget _buildSection(
    String title,
    Widget content, {
    double topSpacing = _verticalSpacing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topSpacing),
        CustomText(label: title, fontSize: 16, fontWeight: FontWeight.w600),
        SizedBox(height: _smallSpacing),
        content,
      ],
    );
  }

  // Méthode pour créer une section avec titre et contenu
  Widget _buildSectionCustom(
    String title,
    String trailing,
    Widget content, {
    double topSpacing = _verticalSpacing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topSpacing),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(label: title, fontSize: 16, fontWeight: FontWeight.w600),
            CustomText(
              label: trailing,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6A737D),
            ),
          ],
        ),
        SizedBox(height: 5),
        const Divider(thickness: 1, color: _dividerColor),
        SizedBox(height: 5),
        content,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              label: 'schoolprofile.programs.title'.tr(),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),

            _buildSectionCustom(
              'Lower Primary',
              'Grades 1–3',
              CustomText(
                label:
                    'Focuses on building essential literacy and numeracy skills, encouraging social development, and nurturing a love of learning through interactive lessons.',
              ),
              topSpacing: 20,
            ),

            _buildSectionCustom(
              'Upper Primary',
              'Grades 4–6',
              CustomText(
                label:
                    'Expands students’ knowledge with more advanced subjects in English, Mathematics, Science, and Social Studies, while preparing them for future academic challenges.',
              ),
              topSpacing: 16,
            ),

            const SizedBox(height: 20),

            _buildSection(
              'global.extracurricularactivities'.tr(),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFF7F8FA),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Icon(
                          IconsaxPlusLinear.activity,
                          color: Color(0xFF6A737D),
                        ),
                        CustomText(
                          label: 'Activity',
                          color: Color(0xFF6A737D),
                          fontSize: 12,
                        ),
                      ],
                    ),
                  );
                },
              ),
              topSpacing: 0,
            ),
          ],
        ),
      ),
    );
  }
}
