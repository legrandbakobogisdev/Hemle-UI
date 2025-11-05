import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class LanguageSelector extends StatefulWidget {
  final Color? textColor;
  final Color? iconColor;
  final VoidCallback? onLanguageChanged;

  const LanguageSelector({
    super.key,
    this.textColor,
    this.iconColor,
    this.onLanguageChanged
  });

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String getCurrentLanguage() {
    final locale = context.locale;
    if (locale.languageCode == 'fr') {
      return 'Français';
    } else {
      return 'English';
    }
  }

  void _changeLanguage(String languageCode) {
    context.setLocale(Locale(languageCode));
     widget.onLanguageChanged?.call();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      enableFeedback: false,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      elevation: 1,
      shadowColor: Colors.transparent,
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Colors.transparent)
      ),
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFF7F8FA)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              getCurrentLanguage(),
              style: TextStyle(
                color: widget.textColor ?? Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              IconsaxPlusLinear.arrow_down,
              size: 16,
              color: widget.iconColor ?? Colors.grey.shade700,
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'fr',
          height: 40,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: _buildLanguageItem('Français', isSelected: context.locale.languageCode == 'fr'),
          ),
        ),
        // Option English
        PopupMenuItem<String>(
          value: 'en',
          height: 40,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: _buildLanguageItem('English', isSelected: context.locale.languageCode == 'en'),
          ),
        ),
      ],
      onSelected: _changeLanguage,
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          width: 1,
          color: Color(0xFFE1E4E8)
        )
      ),

    );
  }

  Widget _buildLanguageItem(String language, {bool isSelected = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelected ? Color(0xFFDEEBFF) : Colors.transparent
      ),
      child: CustomText(
        label: language,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
        ),
    );
  }
}