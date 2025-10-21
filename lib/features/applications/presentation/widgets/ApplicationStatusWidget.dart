import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

enum StatusType { accepted, pending, rejected }

class ApplicationStatusCard extends StatelessWidget {
  final StatusType status;
  final String schoolName;
  final String? studentCode;
  final VoidCallback? onBackToHome;

  const ApplicationStatusCard({
    super.key,
    required this.status,
    required this.schoolName,
    this.studentCode,
    this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    final statusConfig = _getStatusConfig();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusConfig.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusConfig.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre du statut
          Row(
            children: [
              Icon(
                statusConfig.icon,
                color: statusConfig.iconColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              CustomText(
                label: 'application_status.${status.name}.title'.tr(),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: statusConfig.titleColor,
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Description
          CustomText(
            label: _getDescription(),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
   
          
          // Bouton Back to Home
          if (onBackToHome != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: onBackToHome,
                isDisabled: false,
                fullWidth: true,
                label: 'application_status.back_home'.tr(),
                color: Colors.transparent,
                textColor: AppColors.primary,
                // borderColor: AppColors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  

  String _getDescription() {
    switch (status) {
      case StatusType.accepted:
        return tr(
          'application_status.accepted.description',
          namedArgs: {'schoolName': schoolName},
        );
      case StatusType.pending:
        return tr(
          'application_status.pending.description',
          namedArgs: {'schoolName': schoolName},
        );
      case StatusType.rejected:
        return tr(
          'application_status.rejected.description',
        );
    }
  }

  StatusConfig _getStatusConfig() {
    switch (status) {
      case StatusType.accepted:
        return StatusConfig(
          icon: IconsaxPlusLinear.tick_circle,
          iconColor: AppColors.success,
          titleColor: Color(0xFF22A06B),
          backgroundColor: AppColors.success.withOpacity(0.05),
          borderColor: AppColors.success.withOpacity(0.2),
        );
      case StatusType.pending:
        return StatusConfig(
          icon: IconsaxPlusLinear.clock,
          iconColor: AppColors.warning,
          titleColor: AppColors.warning,
          backgroundColor: AppColors.warning.withOpacity(0.05),
          borderColor: AppColors.warning.withOpacity(0.2),
        );
      case StatusType.rejected:
        return StatusConfig(
          icon: IconsaxPlusLinear.close_circle,
          iconColor: AppColors.error,
          titleColor: AppColors.error,
          backgroundColor: AppColors.error.withOpacity(0.05),
          borderColor: AppColors.error.withOpacity(0.2),
        );
    }
  }
}

class StatusConfig {
  final IconData icon;
  final Color iconColor;
  final Color titleColor;
  final Color backgroundColor;
  final Color borderColor;

  const StatusConfig({
    required this.icon,
    required this.iconColor,
    required this.titleColor,
    required this.backgroundColor,
    required this.borderColor,
  });
}