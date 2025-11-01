import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';

class PaymentStatusScreen extends StatefulWidget {
  const PaymentStatusScreen({super.key});

  @override
  State<PaymentStatusScreen> createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  // ignore: unused_field
  final PaymentStatus _currentStatus = PaymentStatus.processing;
  final int _currentStep = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(children: [_header(), _body(), _footer()]),
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
            label: 'payment_status.title'.tr(),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 10),
          CustomText(
            label: 'payment_status.desc'.tr(),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          // Current Status Section
          _buildCurrentStatus(),
          const SizedBox(height: 24),

          // Status Timeline
          _buildStatusTimeline(),
          const SizedBox(height: 24),

          // Divider
          const Divider(height: 1, color: Color(0xFFE1E4E8)),
          const SizedBox(height: 24),

          // Payment Details
          _buildPaymentDetails(),
          const SizedBox(height: 32),



        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child:           // View History Button
          CustomButton(
            onPressed: () {
              // Action pour voir l'historique
            },
            isDisabled: false,
            fullWidth: true,
            label: 'payment_status.view_history'.tr(),
          ),
    );
  }

  Widget _buildStatusTimeline() {
    return Container(
      padding: const EdgeInsets.all(16),

      child: Column(
        spacing: 15,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Pending Step
              _buildTimelineStep(
                step: 1,
                title: 'payment_status.pending'.tr(),
                isActive: _currentStep >= 1,
                isCompleted: _currentStep > 1,
              ),

              // Processing Step
              _buildTimelineStep(
                step: 2,
                title: 'payment_status.processing'.tr(),
                isActive: _currentStep >= 2,
                isCompleted: _currentStep > 2,
              ),
              // Verificating Step
              _buildTimelineStep(
                step: 3,
                title: 'payment_status.verificating'.tr(),
                isActive: _currentStep >= 3,
                isCompleted: _currentStep > 3,
              ),
              // Completed Step
              _buildTimelineStep(
                step: 4,
                title: 'payment_status.completed'.tr(),
                isActive: _currentStep >= 4,
                isCompleted: _currentStep > 4,
              ),
            ],
          ),

          Container(
            width: AppSizes.screenWidth(context) - 16,
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
                    width:
                        (AppSizes.screenWidth(context) - 16) *
                        (_currentStep / 4),
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
    );
  }

  Widget _buildTimelineStep({
    required int step,
    required String title,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Column(
      spacing: 4,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? AppColors.primary
                : isActive
                ? AppColors.primary
                : const Color(0xFFE1E4E8),
   
          ),
          child: isCompleted
              ? SvgPicture.asset('assets/images/54.svg')
              : Center(child: CustomText(label: step.toString(), color: isActive
                ? AppColors.white
                : AppColors.textSecondary,))
        ),

        CustomText(
          label: title,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
        ),
      ],
    );
  }

  Widget _buildCurrentStatus() {
    String statusTitle = '';
    String icon = '';
    String statusDescription = '';
    Color color = Colors.white;
    Color bordercolor = Colors.white;

    switch (_currentStep) {
      case 1:
        statusTitle = 'payment_status.pending'.tr();
        icon = 'assets/images/51.svg';
        statusDescription = 'payment_status.pending_desc'.tr();
        color = Color(0xFFFEFBD7);
        bordercolor = Color(0xFFF2EB99);
        break;
      case 2:
        statusTitle = 'payment_status.processing'.tr();
        statusDescription = 'payment_status.processing_desc'.tr();
        color = Color(0xFFE6F0FF);
        icon = 'assets/images/52.svg';
        bordercolor = Color(0xFFA3C7FF);
        break;
      case 3:
        statusTitle = 'payment_status.verificating'.tr();
        statusDescription = 'payment_status.verificating_desc'.tr();
        color = Color(0xFFE6F0FF);
        icon = 'assets/images/52.svg';
        bordercolor = Color(0xFFA3C7FF);
        break;
      case 4:
        icon = 'assets/images/53.svg';
        statusTitle = 'payment_status.completed'.tr();
        statusDescription = 'payment_status.completed_desc'.tr();
        color = Color(0xFFD7FEE4);
        bordercolor = Color(0xFFB3ECC5);
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bordercolor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              SvgPicture.asset(icon),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    label: statusTitle,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),

                  CustomText(
                    label: statusDescription,
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Reference ID and Amount
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoRow(
                  'payment_status.reference_id'.tr(),
                  'PAY206318590R',
                  isBold: _currentStep >= 3,
                ),

                _buildInfoRow(
                  'payment_status.amount'.tr(),
                  '4,200.00 XAF',
                  isBold: _currentStep >= 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          label: label,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        CustomText(
          label: value,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'payment_status.payment_details'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 16),

          _buildDetailRow('payment_status.method'.tr(), 'Orange Money'),
          const Divider(),
          _buildDetailRow('payment_status.last_updated'.tr(), 'Just now'),
          const Divider(),
          _buildDetailRow(
            'payment_status.estimated_time'.tr(),
            '2 business days',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: CustomText(
            label: label,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          flex: 3,
          child: CustomText(
            label: value,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

enum PaymentStatus { pending, processing, verificating, completed }
