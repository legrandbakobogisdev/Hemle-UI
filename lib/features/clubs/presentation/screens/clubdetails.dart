import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/components/custom_title_desc.dart';
import 'package:hemle/components/custom_title_separateddata.dart';
import 'package:hemle/components/custom_title_widget.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';

class Clubdetails extends StatefulWidget {
  const Clubdetails({super.key});

  @override
  State<Clubdetails> createState() => _ClubdetailsState();
}

class _ClubdetailsState extends State<Clubdetails> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Map<String, dynamic>> _switcherButtons = [
    {'label': 'global.information'.tr(), 'index': 0},
    {'label': 'global.events'.tr(), 'index': 1},
  ];

  final List<Map<String, String>> _generalinfos = [
    {'title': 'global.instructor'.tr(), 'value': 'Fabianne Hernan'},
    {'title': 'global.capacity'.tr(), 'value': '23/30 students'},
    {'title': 'global.classroom'.tr(), 'value': 'Main building C4'},
  ];

  final List<Map<String, String>> _schedules = [
    {'day': 'Tuesdays', 'hour': '3:00 p.m'},
    {'day': 'Thursdays', 'hour': '3:00 p.m'},
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
        children: [
          CustomHeader(
            title: 'Fine Arts Club',
            desc: 'See information and events',
            actions: Center(
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
                        child: Center(
                          child: CustomText(label: button['label']),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          _body(),
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
        children: [information(), events()],
      ),
    );
  }

  Widget information() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 20),
            children: [
              CustomTitleDesc(
                title: 'global.description'.tr(),
                desc:
                    'A club where the children will learn basics on fine arts exploring with paintings and watercolor.',
              ),

              SizedBox(height: 20),

              CustomTitleSeparateddata(
                title: 'global.generalinfo'.tr(),
                datas: _generalinfos,
                data_key: 'title',
                data_value: 'value',
              ),

              SizedBox(height: 20),

              CustomTitleSeparateddata(
                title: 'global.schedules'.tr(),
                datas: _schedules,
                data_key: 'day',
                data_value: 'hour',
              ),
            ],
          ),
        ),

        CustomFooter(
          label: 'global.unregister'.tr(),
          fullWidth: true,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget events() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        CustomTitleWidget(
          title: 'Exposition June 2024',
          widget: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              49,
              (index) => GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(16),
                      child: Column(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                label: '20240615_IMG',
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/66.svg',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: AppSizes.screenHeight(context) / 2,
                            width:
                                AppSizes.screenWidth(context) -
                                32, // -32 pour le padding
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFF7F8FA),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 102,
                  height: 101,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFD9D9D9),
                  ),
                ),
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }
}
