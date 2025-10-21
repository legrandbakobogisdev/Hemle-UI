// ignore_for_file: unused_local_variable, unused_element

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/transports/presentation/screens/detailstransports.dart';

class TransportsScreen extends StatefulWidget {
  const TransportsScreen({super.key});

  @override
  State<TransportsScreen> createState() => _TransportsScreenState();
}

class _TransportsScreenState extends State<TransportsScreen> {
  final List<Map<String, dynamic>> _routes = [
    {
      'name': 'Route A - North District',
      'driver': 'Jean-Pierre Talla',
      'stops': '4 Stops (Poste Centrale → School)',
      'seats': '18/35 seats',
      'seatsFilled': 35,
      'totalSeats': 35,
    },
    {
      'name': 'Route B - South City Center',
      'driver': 'Aisha Diallo',
      'stops': '3 Stops (Central Market → School)',
      'seats': '12/15 seats',
      'seatsFilled': 12,
      'totalSeats': 15,
    },
    {
      'name': 'Route C - West Lake Express',
      'driver': 'David Mbango',
      'stops': '7 Stops (Lakeview Plaza → School)',
      'seats': '34/35 seats',
      'seatsFilled': 34,
      'totalSeats': 35,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _header(),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _header() {
    return CustomHeader(title: 'transport.title'.tr());
    
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        ..._routes.map((route) => _buildRouteCard(route)),
      ],
    );
  }

  Widget _buildRouteCard(Map<String, dynamic> route) {
    double progress = (route['seatsFilled'] as int) / (route['totalSeats'] as int) * 100;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => Detailstransports(),));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE1E4E8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Route Name
                CustomText(
                  label: route['name'] as String,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(height: 8),
      
                // Driver
                Row(
                  children: [
                    CustomText(
                      label: 'transport.driver'.tr(),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      label: route['driver'] as String,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
      
                // Stops
                Row(
                  children: [
                    CustomText(
                      label: 'transport.stops'.tr(),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: CustomText(
                        label: route['stops'] as String,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
      
                // Seats Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: route['seats'] as String,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E4E8),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1E4E8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          Container(
                            width: progress,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.5) {
      return AppColors.success; // Vert pour faible occupation
    } else if (progress < 0.8) {
      return AppColors.warning; // Orange pour occupation moyenne
    } else {
      return AppColors.error; // Rouge pour forte occupation
    }
  }
}