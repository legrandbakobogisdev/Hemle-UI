// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/applications/presentation/screens/applicationstatus_screen.dart';
import 'package:hemle/features/home/data/models/home_models.dart';

enum StatusType { accepted, pending, rejected }

class CustomApplicationCard extends StatelessWidget {
  School school;

  CustomApplicationCard({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => ApplicationstatusScreen()),
        );
      },
      child: Card(
        elevation: 2,
        shadowColor: AppColors.gray.withOpacity(.2),
        color: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 20,
            children: [
              CircleAvatar(radius: 35),

              // Informations de l'école
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    CustomText(
                      label: school.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),

                    Row(
                      spacing: 10,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/28.svg'),

                            const SizedBox(width: 4),

                            CustomText(
                              label: school.location ?? '',
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            SvgPicture.asset('assets/images/29.svg'),
                            const SizedBox(width: 4),
                            CustomText(
                              label: school.type ?? '',
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(width: 12),

                    // Statut
                    Row(
                      spacing: 4,
                      children: [
                        SvgPicture.asset(
                          school.status!.toLowerCase() == "pending"
                              ? 'assets/images/51.svg'
                              : school.status!.toLowerCase() == "accepted"
                              ? 'assets/images/53.svg'
                              : 'assets/images/65.svg',
                        ),
                        CustomText(
                          label: school.status ?? 'Pending',
                          fontSize: 14,
                          color: school.status!.toLowerCase() == "pending"
                              ? AppColors.warning
                              : school.status!.toLowerCase() == "accepted"
                              ? AppColors.success
                              : AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
