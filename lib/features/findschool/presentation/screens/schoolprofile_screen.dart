// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';
import 'package:hemle/features/findschool/presentation/screens/selectChild.dart';
import 'package:hemle/features/findschool/presentation/screens/subscreen/about.dart';
import 'package:hemle/features/findschool/presentation/screens/subscreen/photo.dart';
import 'package:hemle/features/findschool/presentation/screens/subscreen/programs.dart';
import 'package:hemle/features/findschool/presentation/screens/subscreen/reviews.dart';
import 'package:hemle/features/findschool/presentation/screens/subscreen/tuiton.dart';
import 'package:hemle/features/home/data/models/home_models.dart';

class SchoolProfileScreen extends StatefulWidget {
  School school;
  SchoolProfileScreen({super.key, required this.school});

  @override
  State<SchoolProfileScreen> createState() => _SchoolProfileScreenState();
}

class _SchoolProfileScreenState extends State<SchoolProfileScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  // Liste des boutons du switcher
  final List<Map<String, dynamic>> _switcherButtons = [
    {
      'image': 'assets/images/37.svg',
      'index': 0,
    },
    {
      'image': 'assets/images/39.svg',
      'index': 1,
    },
    {
      'image': 'assets/images/41.svg',
      'index': 2,
    },
    {
      'image': 'assets/images/43.svg',
      'index': 3,
    },
    {
      'image': 'assets/images/45.svg',
      'index': 4,
    },
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_header(), SizedBox(height: 6), _body(), _footer()],
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
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppSizes.screenWidth(context) / 12),
            child: Row(
            spacing: 10,
            children: [
              CircleAvatar(radius: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    label: widget.school.name,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    label:
                        widget.school.slogan ??
                        'Global education with local impact',
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ],
          )
          ),

          const SizedBox(height: 16),

          Container(
            width: 320,
            height: 40,
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
                    height: 30,
                    width: 55,
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
                    child: Center(
                      child: SvgPicture.asset(button['image'], color: isActive ? AppColors.primary : null
                      ),
                    ),
                  ),
                );
              }).toList(),
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
        children: [
          // Page 1
          AboutPageSchool(school: widget.school),

          // Page 2
          ProgramsScreenSchool(school: widget.school),

          // Page 3
          TuitonScreenSchool(school: widget.school),

          // Page 4
          ReviewsScreenSchool(school: widget.school,),

          // Page 5
          PhotoScreenSchool(school: widget.school,),
        ],
      ),
    );
  }

  Widget _footer() {
    return CustomFooter(
      label: 'schoolprofile.applythisschool'.tr(),
        fullWidth: true,
        onPressed: () {
          Navigator.push(context, CupertinoPageRoute(builder: (context) => Selectchild(),));
        },
    );
  }
}
