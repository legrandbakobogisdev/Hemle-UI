import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';
import 'package:hemle/features/Notifications/presentation/screens/notificationslist.dart';
import 'package:hemle/features/Settings/presentation/screens/settings.dart';
import 'package:hemle/features/academicresults/presentation/screens/academicresults_screen.dart';
import 'package:hemle/features/clubs/presentation/screens/clubs_screen.dart';
import 'package:hemle/features/home/presentation/widgets/appbar_widget.dart';
import 'package:hemle/features/messagesystem/presentation/screens/inboxChat.dart';
import 'package:hemle/features/navigation/presentation/screens/home_screen.dart';
import 'package:hemle/features/profil/presentation/screens/profil_screen.dart';
import 'package:hemle/features/transports/presentation/screens/transports_screen.dart';
import 'package:hemle/main.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class Layoutsupport extends StatefulWidget {
  const Layoutsupport({super.key});

  @override
  State<Layoutsupport> createState() => _LayoutsupportState();
}

class _LayoutsupportState extends State<Layoutsupport> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    AcademicresultsScreen(),
    TransportsScreen(),
    ClubsScreen(),
    Inboxchat(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 60,
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.screenWidth(context) / 30,
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 20),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CupertinoButton(
                        sizeStyle: CupertinoButtonSize.small,
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            CustomText(
                              label: 'Chantal Fobi',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              IconsaxPlusLinear.arrow_down,
                              color: Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ProfilScreen(),
                            ),
                          );
                        },
                      ),
                      CustomText(
                        label: 'STU001',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Row(
                    spacing: 4,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset('assets/images/14.svg'),
                        onPressed: () {
                          showNotification(
                            'Eleanor Vance',
                            'now',
                            'Sent you a message',
                          );
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Notificationslist(),
                            ),
                          );
                        },
                      ),

                      IconButton(
                        icon: SvgPicture.asset('assets/images/15.svg'),
                        onPressed: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SettingsScreen(),));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        showLanguageSelector: false,
      ),

      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        currentIndex: currentIndex,
        backgroundColor: AppColors.background,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/60.svg',
              color: currentIndex == 0 ? AppColors.primary : null,
            ),
            label: 'nav.bottombar.label.home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/61.svg',
              color: currentIndex == 1 ? AppColors.primary : null,
            ),
            label: 'nav.bottombar.label.results'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/62.svg',
              color: currentIndex == 2 ? AppColors.primary : null,
            ),
            label: 'nav.bottombar.label.transport'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/63.svg',
              color: currentIndex == 3 ? AppColors.primary : null,
            ),
            label: 'nav.bottombar.label.clubs'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/64.svg',
              color: currentIndex == 4 ? AppColors.primary : null,
            ),
            label: 'nav.bottombar.label.chats'.tr(),
          ),
        ],
      ),
    );
  }
}
