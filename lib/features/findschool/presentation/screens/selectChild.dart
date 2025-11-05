import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/findschool/presentation/screens/selectDocuments.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class Selectchild extends StatefulWidget {
  const Selectchild({super.key});

  @override
  State<Selectchild> createState() => _SelectchildState();
}

class _SelectchildState extends State<Selectchild> {
  // Données des enfants
  final List<Map<String, String>> _children = [
    {
      'name': 'Amara Fobi',
      'code': 'STU001',
    },
    {
      'name': 'Jean-Baptiste Fobi', 
      'code': 'STU002',
    },
  ];

  // Constantes réutilisables
  static const _containerColor = Color(0xFFF7F8FA);
  static const _verticalSpacing = 14.0;
  static const _smallSpacing = 10.0;

  // Widget réutilisable pour un enfant
  Widget _buildChildCard(String name, String code) {
    return InkWell(
      onTap: () {
        
      },
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      child: Container(
        height: 72,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _containerColor,
          border: Border.all(
            color: Color(0xFFE1E4E8)
          )
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            const CircleAvatar(radius: 25),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label: name,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  label: code,
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_header(), _body(), _footer()]),
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
            label: 'selectchild.title'.tr(),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: _smallSpacing),
          CustomText(
            label: 'selectchild.desc'.tr(),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              label: 'selectchild.existingchild'.tr(),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: _verticalSpacing),
            
            // Liste des enfants
            Column(
              children: _children.map((child) {
                return Column(
                  children: [
                    _buildChildCard(child['name']!, child['code']!),
                    if (_children.indexOf(child) < _children.length - 1)
                      const SizedBox(height: _smallSpacing),
                  ],
                );
              }).toList(),
            ),
           
          ],
        ),
      ),
    );
  }

  Widget _footer(){
    return CustomFooter(
       onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => Selectdocuments()));
            },
            icon: Icon(IconsaxPlusLinear.add, color: Colors.white,),
            fullWidth: true,
            label: 'selectchild.addnewprofiile'.tr(),
    );
  }
}