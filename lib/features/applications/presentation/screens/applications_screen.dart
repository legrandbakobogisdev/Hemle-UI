import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/applications/presentation/screens/applicationstatus_screen.dart';
import 'package:hemle/features/home/data/models/home_models.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {

  final List<School> _schools = [
    School(
      id: '1',
      name: 'Starfield Academy',
      location: 'Ngaoundéré',
      type: 'Secondary',
      status: 'Pending',
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: CustomText(
          label: 'global.back'.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(child: Column(children: [_header(), _body()])),
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
            label: 'applications.title'.tr(),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 10),
          CustomText(
            label: 'application.desc'.tr(),
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _body(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
          _schools.map((school) => _schoolCard(school)).toList(),
        
      ),
    );
  }


Widget _schoolCard(School school) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => ApplicationstatusScreen(),));
      },
      child: Card(
        elevation: 2,
        shadowColor: AppColors.gray.withOpacity(.2),
        color: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 10,
            children: [
              CircleAvatar(radius: 35),
              
      
              const SizedBox(width: 12),
      
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
                      spacing: 10,
                      children: [
                        Image.asset('assets/images/30.png'),
                        CustomText(
                          label: school.status ?? 'Pending',
                          fontSize: 14,
                          color: AppColors.warning,
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