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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                    value: true,
                    onChanged: (value) {},
                    activeColor: AppColors.primary,
                  ),
                ),

                CustomTitleWidgetSeparated(
                  title: 'global.biometrics'.tr(),
                  widget: Switch.adaptive(
                    value: true,
                    onChanged: (value) {},
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

          SizedBox(height: 40),

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
        SizedBox(height: 10),
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
              Spacer(),
              CupertinoListTileChevron(),
            ],
          ),

          Divider(),
        ],
      ),
    );
  }
}
