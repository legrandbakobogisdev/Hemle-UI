// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';
import 'package:hemle/features/Notifications/presentation/screens/notificationslist.dart';
import 'package:hemle/features/Settings/presentation/screens/settings.dart';
import 'package:hemle/features/home/presentation/screens/enter_code_screen.dart';
import 'package:hemle/features/home/presentation/screens/find_school_screen.dart';
import 'package:hemle/features/home/presentation/widgets/appbar_widget.dart';
import 'package:hemle/features/profil/presentation/screens/profil_screen.dart';
import 'package:hemle/main.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class HomeScreenZeroState extends StatefulWidget {
  const HomeScreenZeroState({super.key});

  @override
  State<HomeScreenZeroState> createState() => _HomeScreenZeroStateState();
}

class _HomeScreenZeroStateState extends State<HomeScreenZeroState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar(
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.screenWidth(context) / 28,
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
                        label: 'home.appbar.nochild'.tr(),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),

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
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        showLanguageSelector: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Titre de bienvenue
              CustomText(
                label: 'home.welcome.title'.tr(),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Option 1: Apply to school
              _buildOptionCard(
                title: 'home.option.apply.title'.tr(),
                subtitle: 'home.option.apply.subtitle'.tr(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FindSchoolScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // Option 2: Enter school code
              _buildOptionCard(
                title: 'home.option.code.title'.tr(),
                subtitle: 'home.option.code.subtitle'.tr(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EnterCodeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: .5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.background,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8,
                      children: [
                        CustomText(
                          label: title,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),

                        Image.asset("assets/images/16.png"),
                      ],
                    ),

                    const SizedBox(height: 4),
                    CustomText(
                      label: subtitle,
                      fontSize: 14,
                      color: AppColors.textSecondary,
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
}
