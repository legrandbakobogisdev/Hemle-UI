// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/home/data/models/home_models.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class AboutPageSchool extends StatefulWidget {
  final School school;
  const AboutPageSchool({super.key, required this.school});

  @override
  State<AboutPageSchool> createState() => _AboutPageSchoolState();
}

class _AboutPageSchoolState extends State<AboutPageSchool> {
  // Constantes pour les couleurs et espacements réutilisables
  static const _defaultColor = Color(0xFF0065FF);
  static const _textColor = Color(0xFF6A737D);
  static const _dividerColor = Color(0xFFE1E4E8);
  static const _containerColor = Color(0xFFF7F8FA);
  static const _verticalSpacing = 14.0;
  static const _smallSpacing = 10.0;

  // Méthode pour créer une ligne d'information avec icône
  Widget _buildInfoRow(IconData icon, String text, bool darkColor) {
    return Row(
      children: [
        Icon(icon, color: _defaultColor, size: 16),
        const SizedBox(width: 6),
        CustomText(
          label: text,
          fontSize: 14,
          color: darkColor == true ? null : _textColor,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  // Méthode pour créer une section avec titre et contenu
  Widget _buildSection(String title, Widget content, {double topSpacing = _verticalSpacing}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topSpacing),
        CustomText(
          label: title,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: _smallSpacing),
        content,
      ],
    );
  }

  // Méthode pour créer une ligne de détail avec séparateur
  Widget _buildDetailRow(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              label: label,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            CustomText(
              label: value,
              fontSize: 16,
              color: _textColor,
            ),
          ],
        ),
        const Divider(thickness: 1, color: _dividerColor),
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
              label: 'schoolprofile.about.title'.tr(),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),

            const SizedBox(height: 20),

            // Section Description
            _buildSection(
              'global.description'.tr(),
              CustomText(
                fontSize: 14,
                color: const Color(0xFF1C2024),
                label: widget.school.description ?? 
                  'Maarif School in Cameroon is part of the Turkish Maarif Foundation\'s international network, offering quality education with a focus on academic excellence, cultural values, and global citizenship. The school provides modern facilities, dedicated teachers, and programs designed to prepare students for higher education and future careers.',
              ),
              topSpacing: 0,
            ),

            // Section Détails de l'école
            _buildSection(
              '',
              Column(
                children: [
                  _buildDetailRow('global.type'.tr(), widget.school.type ?? 'N/A'),
                  _buildDetailRow('global.level'.tr(), widget.school.status ?? 'N/A'),
                  _buildDetailRow('global.affiliation'.tr(), widget.school.affiliation ?? 'N/A'),
                ],
              ),
            ),

            // Section Accréditation
            _buildSection(
              'global.accreditation'.tr(),
              _buildInfoRow(
                Icons.verified_outlined,
                widget.school.accreditation ?? 'N/A',
                true
              ),
            ),

            // Section Adresse
            _buildSection(
              'global.address'.tr(),
              _buildInfoRow(
                Icons.location_on_outlined,
                widget.school.location ?? 'N/A',
                true
              ),
            ),

            // Carte/Image placeholder
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 12),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: _containerColor,
              ),
            ),

            // Section Contact
            _buildSection(
              'global.contact'.tr(),
              Column(
                children: [
                  _buildInfoRow(IconsaxPlusLinear.call, widget.school.tel ?? 'N/A', false),
                  const SizedBox(height: 4),
                  _buildInfoRow(Icons.mail_outline, widget.school.email ?? 'N/A', false),
                  const SizedBox(height: 4),
                  _buildInfoRow(Icons.link, widget.school.website ?? widget.school.tel ?? 'N/A', false),
                ],
              ),
            ),

            // Section Transport
            _buildSection(
              'global.transport'.tr(),
              _buildInfoRow(
                IconsaxPlusLinear.truck,
                'School bus is available',
                true
              ),
            ),
          ],
        ),
      ),
    );
  }
}