import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';
import 'package:hemle/features/home/data/models/home_models.dart';

class PhotoScreenSchool extends StatefulWidget {
  final School school;
  const PhotoScreenSchool({super.key, required this.school});

  @override
  State<PhotoScreenSchool> createState() => _PhotoScreenSchoolState();
}

class _PhotoScreenSchoolState extends State<PhotoScreenSchool> {
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
              label: 'global.photo'.tr(),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),

            SizedBox(height: 20),

            _photoList(),
          ],
        ),
      ),
    );
  }

  Widget _photoList() {
  return GridView.builder(
    itemCount: 10,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    ),
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(16),
              child: Container(
                height: AppSizes.screenHeight(context) / 2,
                width: AppSizes.screenWidth(context) - 32, // -32 pour le padding
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFF7F8FA),
                ),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFF7F8FA),
          ),
        ),
      );
    },
  );
}
}
