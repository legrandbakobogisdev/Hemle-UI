// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/applications/presentation/screens/applicationstatus_screen.dart';
import 'package:hemle/features/home/data/models/home_models.dart';
import 'package:hemle/features/tuition/presentation/screens/tuition_screen.dart';
import 'package:hemle/features/tuition/presentation/widgets/setreminderdialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<School> _schools = [
    School(
      id: '1',
      name: 'Starfield Academy',
      location: 'Ngaoundéré',
      type: 'Secondary',
      status: 'Pending',
    ),
  ];

  final List<Homework> _homeworks = [
    Homework(
      id: '1',
      title: 'Exercise 1 – Textbook, page 60',
      description: '',
      dueDate: DateTime.now(),
    ),

    Homework(
      id: '2',
      title: 'Exercise 1 – Textbook, page 60',
      description: '',
      dueDate: DateTime.now(),
    ),
  ];

  final List<Payment> _payments = [
    Payment(
      id: '1',
      title: 'Transport',
      amount: 50,
      receiver: 'Amara Fobi ',
      dueDate: DateTime.now(),
    ),

    Payment(
      id: '2',
      title: 'Transport',
      amount: 50,
      receiver: 'Amara Fobi ',
      dueDate: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 20),
            _pendingApps(),
            const SizedBox(height: 20),
            _homewordforday(),
            const SizedBox(height: 20),
            _payment(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return CustomText(
      label: 'home.title'.tr(),
      fontSize: 25,
      fontWeight: FontWeight.w700,
    );
  }

  Widget _pendingApps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label: 'home.pendingapps'.tr(),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 12),
        // Liste des écoles
        ..._schools.map((school) => _schoolCard(school)),
      ],
    );
  }

  Widget _schoolCard(School school) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => ApplicationstatusScreen(),));
      },
      child: Card(
        elevation: 2,
        shadowColor: AppColors.gray.withOpacity(.2),
        color: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 10,
            children: [
              CircleAvatar(radius: 35),
              
      
              const SizedBox(width: 12),
      
              // Informations de l'école
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    CustomText(
                      label: school.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
      
                    Row(
                      spacing: 10,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/28.svg'),
                            const SizedBox(width: 4),
                            CustomText(
                              label: school.location ?? '',
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
      
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/29.svg'),
                            const SizedBox(width: 4),
                            CustomText(
                              label: school.type ?? '',
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ],
                    ),
      
                    const SizedBox(width: 12),
      
                    // Statut
                    Row(
                      spacing: 10,
                      children: [
                        Image.asset('assets/images/30.png'),
                        CustomText(
                          label: school.status ?? 'Pending',
                          fontSize: 14,
                          color: AppColors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homewordforday() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label: 'home.homeworkfordat'.tr(args: ['']),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 12),
        // Liste des écoles
        ..._homeworks.map((homework) => _homeworkCard(homework)),
      ],
    );
  }

  Widget _homeworkCard(Homework homework) {
    bool isActive = false;

    return Card(
      elevation: 2,
      color: AppColors.background,
      shadowColor: AppColors.gray.withOpacity(.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Logo de l'école
            SizedBox(
              height: 50,
              child: Checkbox.adaptive(
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = !isActive;
                  });
                },
              ),
            ),

            const SizedBox(width: 8),

            // Informations de l'école
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  CustomText(
                    label: homework.title,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),

                  CustomText(
                    label: 'home.duedate'.tr(
                      args: [homework.dueDate.day.toString()],
                    ),
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _payment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label: 'home.pendingpayment'.tr(args: ['']),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 12),
        // Liste des écoles
        Column(
          spacing: 8,
          children: _payments.map((payment) => _paymentCard(payment)).toList(),
        )
      ],
    );
  }

  Widget _paymentCard(Payment payment) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.background,
        border: Border.all(color: Color(0xFFE1E4E8)),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomText(
                      label: payment.title,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),

                    CustomText(
                      label: payment.receiver,
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Wrap(
                      children: [
                        CustomText(
                          label: payment.amount.toString(),
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          fontSize: 16,
                        ),

                        CustomText(
                          label: 'XAF',
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ],
                    ),

                    CustomText(
                      label:
                          '${payment.dueDate.month.toString()}, ${payment.dueDate.day.toString()}',
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                Expanded(child: CustomButton(label: 'global.paynow'.tr(), onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => TuitionScreen(),));
                })),

                Expanded(
                  child: CustomButton(
                    label: 'global.setreminder'.tr(),
                    textColor: Color(0xFF6A737D),
                    border: Border.all(width: 1, color: Color(0xFF6A737D)),
                    color: AppColors.background,
                    onPressed: () {
                      showSetReminderModal(
                          context: context,
                        );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
