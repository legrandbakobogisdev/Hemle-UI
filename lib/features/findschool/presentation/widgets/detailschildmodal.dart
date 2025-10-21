import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

void showConfirmInformationModal({
  required BuildContext context,
  required String fullName,
  required String age,
  required String dateOfBirth,
  required String level,
  required String gender,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,

    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: ConfirmInformationModal(
          fullName: fullName,
          age: age,
          dateOfBirth: dateOfBirth,
          level: level,
          gender: gender,
          onConfirm: onConfirm,
        ),
      );
    },
  );
}

class ConfirmInformationModal extends StatefulWidget {
  final String fullName;
  final String age;
  final String dateOfBirth;
  final String level;
  final String gender;
  final VoidCallback onConfirm;

  const ConfirmInformationModal({
    super.key,
    required this.fullName,
    required this.age,
    required this.dateOfBirth,
    required this.level,
    required this.gender,
    required this.onConfirm,
  });

  @override
  State<ConfirmInformationModal> createState() =>
      _ConfirmInformationModalState();
}

class _ConfirmInformationModalState extends State<ConfirmInformationModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          _buildHeader(),

          // School Info
          _buildSchoolInfo(),

          // Profile Summary
          _buildProfileSummary(),

          // Buttons
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'detailschild.title'.tr(),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          CustomText(
            label: 'detailschild.desc'.tr(),
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolInfo() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
          ),
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
          _buildInfoRow('global.fullname'.tr(), widget.fullName),
          _buildInfoRow('global.age', widget.age),
          _buildInfoRow('global.dateofbirth', widget.dateOfBirth),
          _buildInfoRow('global.level', widget.level),
          _buildInfoRow('global.gender', widget.gender),

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

  Widget _buildButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CustomButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            isDisabled: false,
            fullWidth: true,
            color: Colors.white,
            textColor: AppColors.black,
            border: Border.all(
              color: Color(0XFFE1E4E8)
            ),
            label: 'detailschildmodal.backtoform'.tr(),
          ),
          SizedBox(height: 8),
          CustomButton(
            onPressed: () {
               Navigator.of(context).pop(); 
              widget.onConfirm();
             // Ferme la modal après confirmation
            },
            isDisabled: false,
            fullWidth: true,
            label: 'Confirm & Continue',
          ),
        ],
      ),
    );
  }
}
