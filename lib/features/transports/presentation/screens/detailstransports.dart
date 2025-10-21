import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/transports/presentation/screens/tracking_screen.dart';

class Detailstransports extends StatefulWidget {
  const Detailstransports({super.key});

  @override
  State<Detailstransports> createState() => _DetailstransportsState();
}

class _DetailstransportsState extends State<Detailstransports> {
  String? _selectedStop;
  final List<String> _stops = [
    'Poste Centrale',
    'Felicity Park',
    'Han Street',
    'School',
  ];

  final List<String> _operatingDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Friday',
  ];

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
    return CustomHeader(title: 'detailstransport.title'.tr(), desc:  'detailstransport.desc'.tr(),);
    
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              // Information Section
              _buildInformationSection(),
              // Operating Days Section
              _buildOperatingDaysSection(),
              // Select Stop Section
              _buildSelectStopSection(),
            ],
          ),
        ),

        // Subscribe Button
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: CustomButton(
            onPressed: _selectedStop != null
                ? () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => TrackingScreen(),));
                  }
                : null,
            isDisabled: _selectedStop == null,
            fullWidth: true,
            color: const Color(0xFF0065FF),
            textColor: Colors.white,
            label: 'detailstransport.subscribe'.tr(),
          ),
        ),
      ],
    );
  }

  Widget _buildInformationSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'detailstransport.information'.tr(),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 16),

          // Driver
          _buildInfoRow('detailstransport.driver'.tr(), 'Jean-Pierre Talla'),
          const SizedBox(height: 12),

          // Capacity
          _buildInfoRow('detailstransport.capacity'.tr(), '18/35 seats'),
        ],
      ),
    );
  }

  Widget _buildOperatingDaysSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'detailstransport.operating_days'.tr(),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 16),

          // Days
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: _operatingDays.map((day) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(1000),
                  border: Border.all(color: AppColors.border),
                ),
                child: CustomText(
                  label: day,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          _buildInfoRow('detailstransport.pickup'.tr(), '6:15 a.m'),
          _buildInfoRow('detailstransport.dropoff'.tr(), '4:00 p.m'),
        ],
      ),
    );
  }

  Widget _buildSelectStopSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'detailstransport.select_stop'.tr(),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          
          const SizedBox(height: 16),

          Stack(
            children: [
              Positioned(
                left: 8,
                child: Container(
                  height: 200,
                  width: 4,
                  decoration: BoxDecoration(color: Color(0xFFDEEBFF)),
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _stops.map((stop) {
                  return _buildStopOption(stop);
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      children: [
        Row(
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
        ),

        Divider(thickness: 1, color: AppColors.border),
      ],
    );
  }


  Widget _buildStopOption(String stop) {
    bool isSelected = _selectedStop == stop;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStop = stop;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0065FF)
                      :  Colors.white,
                  width: 2,
                ),
                color: isSelected
                    ? const Color(0xFF0065FF)
                    : Color(0xFFDEEBFF),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomText(
                label: stop,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
