import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/profil/presentation/screens/subscreen/childprofile.dart';
import 'package:hemle/features/profil/presentation/screens/subscreen/editchildprofile.dart';

class Mychildren extends StatefulWidget {
  const Mychildren({super.key});

  @override
  State<Mychildren> createState() => _MychildrenState();
}

class _MychildrenState extends State<Mychildren> {
  List<Map<String, String>> childrens = [
    {"name": "Amara Fobi", "code": "STU001", "school": "Maarif School"},
    {"name": "Jean-Baptiste Fobi", "code": "STU002", "school": "Maarif School"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          spacing: 8,
          children: childrens
              .map(
                (child) => Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  height: 174,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFF7F8FA),
                    border: Border.all(color: Color(0xFFE1E4E8)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          CircleAvatar(radius: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                label: 'Chantal Fobi',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),

                              CustomText(
                                label: 'home.appbar.nochild'.tr(),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            label: 'profile.currentschool'.tr(),
                            color: Color(0xFF6A737D),
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            label: child['school']!,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Divider(thickness: 1, color: Color(0xFFE1E4E8)),
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: CustomButton(
                              label: 'global.modify'.tr(),
                              border: Border.all(color: Color(0xFF0065FF)),
                              color: Color(0xFFDEEBFF),
                              textColor: AppColors.primary,
                              onPressed: () {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => Editchildprofile(),));
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomButton(
                              label: 'profile.view'.tr(),
                              onPressed: () {
                                
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => Childprofile(),));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
