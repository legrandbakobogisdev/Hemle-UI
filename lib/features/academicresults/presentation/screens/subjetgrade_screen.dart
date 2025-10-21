import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/home/data/models/home_models.dart';

class SubjetgradeScreen extends StatefulWidget {
  const SubjetgradeScreen({super.key});

  @override
  State<SubjetgradeScreen> createState() => _SubjetgradeScreenState();
}

class _SubjetgradeScreenState extends State<SubjetgradeScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Map<String, dynamic>> _switcherButtons = [
    {'label': 'global.grades'.tr(), 'index': 0},
    {'label': 'global.homework'.tr(), 'index': 1},
    {'label': 'global.comment'.tr(), 'index': 2},
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


final List<Map<String, dynamic>> _comments = [
    {
      'id': 1,
      'userName': 'Marie L.',
      'comment': 'Excellent school with dedicated teachers. My daughter is thriving in this program.',
      'date': '14/12/2024',
    },
    {
      'id': 2,
      'userName': 'John D.',
      'comment': 'Great facilities and caring staff. The curriculum is well-structured.',
      'date': '10/12/2024',
    },
  ];

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
                  label: 'Mathematics',
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  label: 'Subject Description',
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
                      width: 102.67,
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
                        child: CustomText(
                          label: button['label'],
                          color: isActive ? AppColors.primary : null,
                        ),
                      ),
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
        children: [
          // Page Grades
          _buildGradesPage(),
          // Page Homework
          _homewordforday(),
          // Page Comments
          _commentsList(),
        ],
      ),
    );
  }

Widget _commentsList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _comments.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final review = _comments[index];
          
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFF7F8FA),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      label: review['userName'] as String,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
      
                    const Spacer(),
      
                    CustomText(label: review['date'], color: AppColors.textSecondary,),
                  ],
                ),
      
                const SizedBox(height: 10),
                CustomText(
                  label: review['comment'] as String,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _homewordforday() {
    return _homeworks.isEmpty
        ? Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  SvgPicture.asset(
                    "assets/images/59.svg",
                    width: 247,
                    height: 199,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    spacing: 8,
                    children: [
                      CustomText(
                        label: 'error.grade.title'.tr(),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        textAlign: TextAlign.center,
                      ),

                      CustomText(
                        label: 'error.grade.desc'.tr(),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : ListView(
            padding: const EdgeInsets.all(16),
           shrinkWrap: true,
              children: [
                Column(
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
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: 'home.homeworkforlongterm'.tr(args: ['']),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 12),
                    // Liste des écoles
                    ..._homeworks.map((homework) => _homeworkCard(homework)),
                  ],
                ),
              ],
            
          );
  }

  Widget _homeworkCard(Homework homework) {
    bool isActive = false;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
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

  Widget _buildGradesPage() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              // Grades Section
              _buildGradesSection(),
              const SizedBox(height: 24),

              // Grades History
              _buildGradesHistory(),
            ],
          ),
        ),

        // Export PDF Button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: CustomButton(
            onPressed: () {
              // Action pour exporter le PDF
            },
            isDisabled: false,
            fullWidth: true,
            color: const Color(0xFF0065FF),
            textColor: Colors.white,
            label: 'grades.export_pdf'.tr(),
          ),
        ),
      ],
    );
  }

  Widget _buildGradesSection() {
    return Row(
      spacing: 8,
      children: [
        // Child Average
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE1E4E8)),
            ),
            child: Column(
              children: [
                CustomText(
                  label: '17/20',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 8),
                CustomText(
                  label: 'grades.child_average'.tr(),
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Class Average
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE1E4E8)),
            ),
            child: Column(
              children: [
                CustomText(
                  label: '16/20',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 8),
                CustomText(
                  label: 'grades.class_average'.tr(),
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGradesHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label: 'grades.history'.tr(),
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        const SizedBox(height: 16),

        // Grades History List
        Column(
          children: [
            _buildHistoryRow('Test 1', '18/20'),
            _buildHistoryRow('Test 2', '20/20'),
            _buildHistoryRow('Test 3', '15/20'),
            _buildHistoryRow('Test 4', '19/20'),
            _buildHistoryRow('Test 5', '17/20'),
            _buildHistoryRow('Test 6', '16/20'),
          ],
        ),
      ],
    );
  }

  Widget _buildHistoryRow(String testName, String score) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            label: testName,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
          CustomText(
            label: score,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
