import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/clubs/presentation/screens/clubdetails.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ClubsScreen extends StatefulWidget {
  const ClubsScreen({super.key});

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  int currentIndex = 1;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> clubsactivities = [
    {"id": '1', "name": "Arts", 'icon': IconsaxPlusLinear.paintbucket},
    {"id": '2', "name": "Science", 'icon': IconsaxPlusLinear.battery_charging},
    {"id": '3', "name": "Sports", 'icon': IconsaxPlusLinear.bag},
    {"id": '4', "name": "Arts", 'icon': IconsaxPlusLinear.paintbucket},
    {"id": '5', "name": "Science", 'icon': IconsaxPlusLinear.battery_charging},
    {"id": '6', "name": "Sports", 'icon': IconsaxPlusLinear.bag},
  ];

  List<Map<String, dynamic>> activities = [
    {
      'id': '1',
      'name': 'Fine Arts',
      'status': 'Registered',
      'description':
          'A club where the children learn basics on fine arts exploring with paintings and watercolor.',
    },
    {
      'id': '2',
      'name': 'Choral Group',
      'status': 'Available',
      'description':
          'If your child has hability for singing, please sign him in the school choral group. We would be happy to have his voice here!',
    },
  ];

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
      body: Column(children: [_header(), _body()]),
    );
  }

  Widget _header() {
    return CustomHeader(
      title: 'clubs.title'.tr(),
      desc: 'clubs.desc'.tr(),
      hideshadow: true,
      actions: Center(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: clubsactivities.map((button) {
              final index = int.parse(button['id']!);
              final isActive = currentIndex == index;

              return GestureDetector(
                onTap: () => _onSwitcherTap(index),
                child: Container(
                  height: 38,
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFDEEBFF)
                        : AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: isActive ? 1 : 0,
                      color: isActive
                          ? const Color(0xFF0065FF)
                          : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      spacing: 10,
                      children: [
                        Icon(
                          button['icon'],
                          color: isActive ? AppColors.primary : null,
                        ),
                        CustomText(
                          label: button['name'],
                          fontWeight: FontWeight.w500,
                          color: isActive ? AppColors.primary : null,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: ListView.builder(
        itemCount: activities.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          var activitie = activities[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => Clubdetails()),
              );
            },
            child: Container(
              height: 125,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        label: activitie['name'],
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      Row(
                        children: [
                          if (activitie['status'] == 'Registered')
                            Icon(Icons.check, color: AppColors.primary),

                          CustomText(
                            label: activitie['status'],
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: activitie['status'] == 'Available'
                                ? AppColors.success
                                : activitie['status'] == 'Registered'
                                ? AppColors.primary
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),

                  CustomText(
                    label: activitie['description'],
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
