// ignore_for_file: camel_case_types

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/profil/presentation/screens/subscreen/mychildren.dart';
import 'package:hemle/features/profil/presentation/screens/subscreen/myprofile.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Map<String, dynamic>> _switcherButtons = [
    {'label': 'profile.myprofile'.tr(), 'index': 0},
    {'label': 'profile.mychildren'.tr(), 'index': 1},
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    final page = _pageController.page?.round() ?? 0;
    if (page != currentIndex) {
      setState(() {
        currentIndex = page;
      });
    }
  }

  void _onSwitcherTap(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(children: [_header(), SizedBox(height: 6), _body()]),
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
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  label: 'profile.title'.tr(),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  label: 'profile.desc'.tr(),
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: Container(
              width: 320,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _switcherButtons.map((button) {
                  final index = button['index'] as int;
                  final isActive = currentIndex == index;
            
                  return GestureDetector(
                    onTap: () => _onSwitcherTap(index),
                    child: Container(
                      height: 38,
                      width: 154,
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFFDEEBFF) : null,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: isActive ? 1 : 0,
                          color: isActive
                              ? const Color(0xFF0065FF)
                              : Colors.transparent,
                        ),
                      ),
                      child: Center(child: CustomText(label: button['label'])),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [Myprofile(), Mychildren()],
      ),
    );
  }
}

