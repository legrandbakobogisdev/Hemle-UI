// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/home/data/models/home_models.dart';

class TuitonScreenSchool extends StatefulWidget {
  School school;
  TuitonScreenSchool({super.key, required this.school});

  @override
  State<TuitonScreenSchool> createState() => _TuitonScreenSchoolState();
}

class _TuitonScreenSchoolState extends State<TuitonScreenSchool> {
  static const _textColor = Color(0xFF6A737D);
  static const _dividerColor = Color(0xFFE1E4E8);
  static const _verticalSpacing = 14.0;
  static const _smallSpacing = 10.0;

  // Méthode pour créer une ligne d'information avec icône
  Widget _buildInfoRow(String title, String cost, bool divider) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              label: title,
              color: _textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(width: 6),
            CustomText(
              label: cost,
              fontSize: 14,
              color: Color(0xFF22A06B),
              fontWeight: FontWeight.w700,
            ),
          ],
        ),

        if (divider == true) const Divider(thickness: 1, color: _dividerColor),
      ],
    );
  }

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
              label: 'schoolprofile.tuiton.title'.tr(),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),

            _buildSection(
              'global.tuitionfees'.tr(),
              Column(
                children: [
                  _buildInfoRow('Lower Primary', 'FREE', true),
                  const SizedBox(height: 4),
                  _buildInfoRow('Upper Primary', '1,850 XAF / year', true),
                ],
              ),
            ),

            _buildSection(
              'global.aditionalfees'.tr(),
              Column(
                children: [
                  _buildInfoRow('Application Fee', 'FREE', true),
                  const SizedBox(height: 4),
                  _buildInfoRow('Uniform Fee', '150 XAF', true),
                  const SizedBox(height: 4),
                  _buildInfoRow('Books & Supplies', '300 XAF', true),
                  const SizedBox(height: 4),
                  _buildInfoRow('Meals Program', '200 XAF', true),
                ],
              ),
            ),

                        _buildSection(
              'global.scholarships'.tr(),
              Column(
                children: [
                  _buildInfoRow('Need-based', '50% covered', true),
                  const SizedBox(height: 4),
                  _buildInfoRow('Merit-based', '30-70% covered', true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
