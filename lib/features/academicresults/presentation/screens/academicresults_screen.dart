import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';
import 'package:hemle/features/academicresults/presentation/screens/subjetgrade_screen.dart';
import 'package:hemle/features/findschool/presentation/widgets/MyPopupMenuButton.dart';

class AcademicresultsScreen extends StatefulWidget {
  const AcademicresultsScreen({super.key});

  @override
  State<AcademicresultsScreen> createState() => _AcademicresultsScreenState();
}

class _AcademicresultsScreenState extends State<AcademicresultsScreen> {
  String? _selectedTerm;
  final List<String> _termOptions = ['Term 1', 'Term 2', 'Term 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _header(),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            label: 'results.title'.tr(),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            width: 107,
            height: 40,
            child: MyPopupMenuButton(
              options: _termOptions,
              color: Color(0xFFF7F8FA),
              bordercolor: Color(0xFFE1E4E8),
              label: _selectedTerm ?? 'results.select_term'.tr(),
              onSelect: (value) {
                setState(() {
                  _selectedTerm = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        // Mathematics
        _buildSubjectCard(
          svgPath: 'assets/images/55.svg',
          subject: 'results.mathematics'.tr(),
          classAverage: '0',
          score: '17/20',
          progress: 17/20,
        ),
        const SizedBox(height: 16),

        // English
        _buildSubjectCard(
          svgPath: 'assets/images/56.svg',
          subject: 'results.english'.tr(),
          classAverage: '0',
          score: '13/20',
          progress: 13/20,
        ),
        const SizedBox(height: 16),

        // Science
        _buildSubjectCard(
          svgPath: 'assets/images/57.svg',
          subject: 'results.science'.tr(),
          classAverage: '0',
          score: '18/20',
          progress: 18/20,
        ),
        const SizedBox(height: 16),

        // History
        _buildSubjectCard(
          svgPath: 'assets/images/58.svg',
          subject: 'results.history'.tr(),
          classAverage: '0',
          score: '11/20',
          progress: 11/20,
        ),
      ],
    );
  }

  Widget _buildSubjectCard({
    required String svgPath,
    required String subject,
    required String classAverage,
    required String score,
    required double progress,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => SubjetgradeScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE1E4E8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Title
            Row(
              children: [
                SvgPicture.asset(svgPath),
                const SizedBox(width: 8),
                CustomText(
                  label: subject,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                Spacer(),
                CustomText(
                  label: score,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ],
            ),
            const SizedBox(height: 12),
      
            // Class Average
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  label: 'results.class_average'.tr(),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
                CustomText(
                  label: classAverage,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
      
            const SizedBox(height: 20),
      
            // Progress Bar
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      label: '0',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                    CustomText(
                      label: '20',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    )
                  ],
                ),
                Container(
                  width: AppSizes.screenWidth(context) - 64,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: Container(
                          width: (AppSizes.screenWidth(context) - 64) * progress,
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
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
    );
  }
}