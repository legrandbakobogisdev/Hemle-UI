import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/components/custom_title_widget.dart';
import 'package:hemle/components/custom_title_widget_separated.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/Settings/presentation/screens/faq.dart';
import 'package:hemle/features/Settings/presentation/screens/policyprivacy.dart';
import 'package:hemle/features/Settings/presentation/screens/termsservices.dart';
import 'package:hemle/features/splashscreen/presentation/widgets/language_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometricsEnabled = false;
  bool _notificationsEnabled = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _biometricsEnabled = _prefs.getBool('biometrics_enabled') ?? false;
      _notificationsEnabled = _prefs.getBool('notifications_enabled') ?? true;
    });
  }

  Future<void> _toggleBiometrics(bool value) async {
    setState(() {
      _biometricsEnabled = value;
    });
    await _prefs.setBool('biometrics_enabled', value);
    
    // Optionnel : Afficher un feedback
    // if (value) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('settings.biometrics.enabled'.tr())),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('settings.biometrics.disabled'.tr())),
    //   );
    // }
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });
    await _prefs.setBool('notifications_enabled', value);
    
    // Optionnel : Afficher un feedback
    // if (value) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('settings.notifications.enabled'.tr())),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('settings.notifications.disabled'.tr())),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(
        children: [
          CustomHeader(title: 'global.settings'.tr()),
          _body(),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          CustomTitleWidget(
            title: 'global.general'.tr(),
            widget: Column(
              children: [
                CustomTitleWidgetSeparated(
                  title: 'global.language'.tr(),
                  widget: LanguageSelector(),
                ),

                CustomTitleWidgetSeparated(
                  title: 'global.notifications'.tr(),
                  widget: Switch.adaptive(
                    value: _notificationsEnabled,
                    onChanged: _toggleNotifications,
                    activeColor: AppColors.primary,
                  ),
                ),

                CustomTitleWidgetSeparated(
                  title: 'global.biometrics'.tr(),
                  widget: Switch.adaptive(
                    value: _biometricsEnabled,
                    onChanged: _toggleBiometrics,
                    activeColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          _buildSection(
            'global.helpsupport'.tr(),
            Column(
              children: [
                buildInfoRowCustom(
                  SvgPicture.asset('assets/images/74.svg'),
                  'FAQ',
                  true,
                  () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => FaqScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          _buildSection(
            'global.privacy'.tr(),
            Column(
              children: [
                buildInfoRowCustom(
                  SvgPicture.asset('assets/images/75.svg'),
                  'global.policyprivacy'.tr(),
                  true,
                  () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => Policyprivacy()),
                    );
                  },
                ),
                buildInfoRowCustom(
                  SvgPicture.asset('assets/images/76.svg'),
                  'global.termsofservices'.tr(),
                  true,
                  () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => Termsservices()),
                    );
                  },
                ),
              ],
            ),
          ),

          _buildSection(
            'Contact',
            Column(
              children: [
                buildInfoRowCustom(
                  SvgPicture.asset('assets/images/77.svg'),
                  '+237 698 024 465',
                  true,
                  () {},
                ),
                buildInfoRowCustom(
                  SvgPicture.asset('assets/images/78.svg'),
                  'hemle@gmail.com',
                  true,
                  () {},
                ),
                buildInfoRowCustom(
                  SvgPicture.asset('assets/images/79.svg'),
                  '123 School Street, 75001 Yaundé, Cameroon',
                  true,
                  () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          Center(
            child: CustomText(
              label: 'appversion'.tr(args: ['1.0.0']),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content, {double topSpacing = 14}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topSpacing),
        CustomText(label: title, fontSize: 16, fontWeight: FontWeight.w600),
        const SizedBox(height: 15),
        content,
      ],
    );
  }

  Widget buildInfoRowCustom(
    Widget icon,
    String text,
    bool darkColor,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 6),
              CustomText(
                label: text,
                fontSize: 14,
                color: darkColor == true ? null : AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              const Spacer(),
              const CupertinoListTileChevron(),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}