import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/applications/presentation/widgets/ApplicationStatusWidget.dart';
import 'package:hemle/features/navigation/presentation/screens/layoutSupport.dart';

class ApplicationstatusScreen extends StatefulWidget {
  const ApplicationstatusScreen({super.key});

  @override
  State<ApplicationstatusScreen> createState() =>
      _ApplicationstatusScreenState();
}

class _ApplicationstatusScreenState extends State<ApplicationstatusScreen> {
  static const _smallSpacing = 10.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_header(), _body(), _footer()],
      ),
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
            label: 'applicationstatus.title'.tr(),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: _smallSpacing),
          CustomText(
            label: 'applicationstatus.desc'.tr(),
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
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // School Info
                _buildSchoolInfo(),

                // Profile Summary
                _buildProfileSummary(),

                _status(),

                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolInfo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              _buildInfoRow(
                'applicationstatus.Application'.tr(),
                'APP-1756908832267',
              ),
              _buildInfoRow('applicationstatus.submittedon'.tr(), '09/03/2025'),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF7F8FA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              CircleAvatar(radius: 25),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: 'Maarif School',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      label: 'Global education with local impact',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'detailschildmodal.profilesummary'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 16),

          // Table-like information
          _buildInfoRow('global.fullname'.tr(), 'Fatima Diallo'),
          _buildInfoRow('global.age'.tr(), '7'),
          _buildInfoRow('global.dateofbirth'.tr(), '10/01/2018'),
          _buildInfoRow('global.level'.tr(), 'Grade 2'),
          _buildInfoRow('global.gender'.tr(), 'Male'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomText(
              label: label,
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 3,
            child: CustomText(
              label: value,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _status() {
    return ApplicationStatusCard(
      schoolName: "Maarif School",
      studentCode: "STU01",
      status: StatusType.accepted,
    );
  }

  Widget _footer() {
    return CustomFooter(
      label: 'global.backtohome'.tr(),
      onPressed: () {
        Navigator.pushAndRemoveUntil(context,  CupertinoPageRoute(builder: (context) => Layoutsupport()), (route) => false,);
      },
      fullWidth: true,
      isDisabled: true,
    );
  }
}
