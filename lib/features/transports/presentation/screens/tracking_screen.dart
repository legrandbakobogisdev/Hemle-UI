// ignore_for_file: unused_field

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final bool _isDelayed = false;
  final int _currentStop = 2; // Stop 3 est actif (index 2)

    final int _currentStep = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(
        children: [
          _header(),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _header() {
    return CustomHeader(title: 'tracking.title'.tr());
    
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        _buildStatusTimeline(),
        // Time Information
        _buildTimeInformation(),
        // Delay Notification
        _buildDelayNotification(),
      ],
    );
  }

  Widget _buildStatusTimeline() {
    return Container(
      padding: const EdgeInsets.all(16),

      child: Column(
        spacing: 15,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Pending Step
              _buildTimelineStep(
                step: 1,
                title: 'Stop 1',
                isActive: _currentStep >= 1,
                isCompleted: _currentStep > 1,
              ),

              // Processing Step
              _buildTimelineStep(
                step: 2,
                title: 'Stop 2',
                isActive: _currentStep >= 2,
                isCompleted: _currentStep > 2,
              ),
              // Verificating Step
              _buildTimelineStep(
                step: 3,
                title: 'Stop 3',
                isActive: _currentStep >= 3,
                isCompleted: _currentStep > 3,
              ),
              // Completed Step
              _buildTimelineStep(
                step: 4,
                title: 'Stop 4',
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



  Widget _buildTimeInformation() {
    return Container( 
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTimeRow('tracking.remaining_time'.tr(), '25 mins'),
          Divider(thickness: 1, color: AppColors.border),
          _buildTimeRow('tracking.picking_up_time'.tr(), '8:25 a.m'),
           Divider(thickness: 1, color: AppColors.border),
          _buildTimeRow('tracking.arriving_time'.tr(), '8:45 a.m'),
        ],
      ),
    );
  }

  Widget _buildTimeRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          label: label,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
        CustomText(
          label: value,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ],
    );
  }

  Widget _buildDelayNotification() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE2E2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFD9B3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 6,
            children: [
              SvgPicture.asset('assets/images/65.svg'),
              CustomText(
                label: 'tracking.delayed'.tr(),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ],
          ),
          const SizedBox(height: 4),
          CustomText(
            label: 'tracking.delay_message'.tr(),
            fontSize: 14,
            color: AppColors.error,
            fontWeight: FontWeight.w400,
            
          ),
        ],
      ),
    );
  }
}